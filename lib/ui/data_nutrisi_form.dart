import 'package:aplikasi_manajemen_kesehatan/bloc/data_nutrisi_bloc.dart';
import 'package:aplikasi_manajemen_kesehatan/ui/data_nutrisi_page.dart';
import 'package:aplikasi_manajemen_kesehatan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';
import '/model/data_nutrisi.dart';

// ignore: must_be_immutable
class DataNutrisiForm extends StatefulWidget {
  DataNutrisi? dataNutrisi;
  DataNutrisiForm({Key? key, this.dataNutrisi}) : super(key: key);
  
  @override
  _DataNutrisiFormState createState() => _DataNutrisiFormState();
}

class _DataNutrisiFormState extends State<DataNutrisiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH NUTRISI";
  String tombolSubmit = "SIMPAN";
  final _foodItemTextboxController = TextEditingController();
  final _caloriesTextboxController = TextEditingController();
  final _fatContentTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.dataNutrisi != null) {
      setState(() {
        judul = "UBAH NUTRISI";
        tombolSubmit = "UBAH";
        _foodItemTextboxController.text = widget.dataNutrisi!.foodItem!;
        _caloriesTextboxController.text = widget.dataNutrisi!.calories.toString();
        _fatContentTextboxController.text = widget.dataNutrisi!.fatContent.toString();
      });
    } else {
      judul = "TAMBAH NUTRISI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Arial', // Set font to Arial
          ),
        ),
        backgroundColor: Colors.red, // Mengubah warna header menjadi merah
        iconTheme: IconThemeData(color: Colors.white), // Mengubah warna ikon back menjadi putih
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _foodItemTextField(),
                SizedBox(height: 16.0), // Padding antar textbox
                _caloriesTextField(),
                SizedBox(height: 16.0), // Padding antar textbox
                _fatContentTextField(),
                SizedBox(height: 20.0), // Padding sebelum tombol
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Food Item
  Widget _foodItemTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Food Item",
        labelStyle: TextStyle(color: Colors.red), // Label berwarna merah
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border berwarna merah
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border saat fokus berwarna merah
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border saat diaktifkan berwarna merah
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _foodItemTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Food Item harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Calories
  Widget _caloriesTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Calories",
        labelStyle: TextStyle(color: Colors.red), // Label berwarna merah
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border berwarna merah
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border saat fokus berwarna merah
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border saat diaktifkan berwarna merah
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _caloriesTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Calories harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Fat Content
  Widget _fatContentTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Fat Content",
        labelStyle: TextStyle(color: Colors.red), // Label berwarna merah
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border berwarna merah
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border saat fokus berwarna merah
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Border saat diaktifkan berwarna merah
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _fatContentTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Fat Content harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(
        tombolSubmit,
        style: TextStyle(color: Colors.red), // Tulisan tombol berwarna merah
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent, // Latar belakang transparan
        side: BorderSide(color: Colors.red), // Border tombol berwarna merah
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.dataNutrisi != null) {
              ubah(); // kondisi update produk
            } else {
              simpan(); // kondisi tambah produk
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    DataNutrisi createNutrisi = DataNutrisi(id: null);
    createNutrisi.foodItem = _foodItemTextboxController.text;
    createNutrisi.calories = int.parse(_caloriesTextboxController.text);
    createNutrisi.fatContent = int.parse(_fatContentTextboxController.text);

    DataNutrisiBloc.addNutrisi(dataNutrisi: createNutrisi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const DataNutrisiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    DataNutrisi updateNutrisi = DataNutrisi(id: widget.dataNutrisi!.id!);
    updateNutrisi.foodItem = _foodItemTextboxController.text;
    updateNutrisi.calories = int.parse(_caloriesTextboxController.text);
    updateNutrisi.fatContent = int.parse(_fatContentTextboxController.text);
    
    DataNutrisiBloc.updateNutrisi(dataNutrisi: updateNutrisi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const DataNutrisiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}