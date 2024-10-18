import 'package:aplikasi_manajemen_kesehatan/bloc/data_nutrisi_bloc.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/data_nutrisi_page.dart';
import 'package:aplikasi_manajemen_kesehatan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';
import '/model/data_nutrisi.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/data_nutrisi_form.dart';

// ignore: must_be_immutable
class NutrisiDetail extends StatefulWidget {
  DataNutrisi? dataNutrisi;

  NutrisiDetail({Key? key, this.dataNutrisi}) : super(key: key);

  @override
  _NutrisiDetailState createState() => _NutrisiDetailState();
}

class _NutrisiDetailState extends State<NutrisiDetail> {
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.red, // Set AppBar background color to red
      title: const Text(
        'Detail Nutrisi',
        style: TextStyle(
          fontFamily: 'Arial', // Set font family to Arial
          color: Colors.white, // Set font color to white
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white, // Set back button icon color to white
      ),
    ),
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Card with red outline at the top
        Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.red, width: 2), // Red outline
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding inside the card
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "ID : ${widget.dataNutrisi!.id}",
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Food Item : ${widget.dataNutrisi!.foodItem}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Calories : ${widget.dataNutrisi!.calories}",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Fat Content : ${widget.dataNutrisi!.fatContent}",
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20), // Space between card and buttons
        _tombolHapusEdit() // Buttons below the card
      ],
    ),
  );
}


  Widget _tombolHapusEdit() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space evenly between buttons
    children: [
      // Tombol Edit with outline border red and black text
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red), // Red outline
        ),
        child: Text(
          "EDIT",
          style: const TextStyle(color: Colors.black), // Change text color to black
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DataNutrisiForm(
                dataNutrisi: widget.dataNutrisi!,
              ),
            ),
          );
        },
      ),
      // Tombol Hapus with red background
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Use backgroundColor for red background
          foregroundColor: Colors.white, // Use foregroundColor for white text
        ),
        child: const Text("DELETE"),
        onPressed: () => confirmHapus(),
      ),
    ],
  );
}


  void confirmHapus() {
  AlertDialog alertDialog = AlertDialog(
    content: const Text("Yakin ingin menghapus data ini?"),
    actions: [
      // Tombol hapus dengan latar belakang merah
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Latar belakang merah
          foregroundColor: Colors.white, // Teks putih
        ),
        child: const Text("Ya"),
        onPressed: () {
          DataNutrisiBloc.deleteNutrisi(id: widget.dataNutrisi!.id!).then(
            (value) => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DataNutrisiPage(),
                ),
              )
            },
            onError: (error) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                  description: "Hapus gagal, silahkan coba lagi",
                ),
              );
            },
          );
        },
      ),
      // Tombol batal dengan outline merah dan teks hitam
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red), // Border merah
          foregroundColor: Colors.black, // Teks hitam
        ),
        child: const Text("Batal"),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );

  showDialog(builder: (context) => alertDialog, context: context);
}
}
