import 'package:aplikasi_manajemen_kesehatan/bloc/data_nutrisi_bloc.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/data_nutrisi_detail.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/data_nutrisi_form.dart';
import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '/model/data_nutrisi.dart';
import 'login_page.dart';

class DataNutrisiPage extends StatefulWidget {
  const DataNutrisiPage({Key? key}) : super(key: key);

  @override
  _DataNutrisiPageState createState() => _DataNutrisiPageState();
}

class _DataNutrisiPageState extends State<DataNutrisiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Nutrisi',
          style: TextStyle(color: Colors.white, fontFamily: 'Arial'), // White text and Arial font
        ),
        backgroundColor: Colors.red, // Set AppBar color to red
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.white), // Set icon color to white
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataNutrisiForm()));
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.red, // Set drawer background color to red
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Arial', // Set font to Arial
                    color: Colors.white, // Set font color to white
                  ),
                ),
                trailing: const Icon(Icons.logout, color: Colors.white), // Set icon color to white
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false)
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: DataNutrisiBloc.getNutrisi(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListNutrisi(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListNutrisi extends StatelessWidget {
  final List? list;
  const ListNutrisi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemNutrisi(
            dataNutrisi: list![i],
          );
        });
  }
}

class ItemNutrisi extends StatelessWidget {
  final DataNutrisi dataNutrisi;
  const ItemNutrisi({Key? key, required this.dataNutrisi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NutrisiDetail(
                      dataNutrisi: dataNutrisi,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(5), // Padding antar card
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.red, width: 2), // Red outline
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(
              dataNutrisi.foodItem!,
              style: const TextStyle(fontFamily: 'Arial'), // Set font to Arial
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  'Calories: ${dataNutrisi.calories.toString()}',
                  style: const TextStyle(fontFamily: 'Arial'), // Set font to Arial
                ),
                Text(
                  'Fat Content: ${dataNutrisi.fatContent.toString()}',
                  style: const TextStyle(fontFamily: 'Arial'), // Set font to Arial
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
