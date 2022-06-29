import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uenak/admin/main.dart';

class TambahOrder extends StatefulWidget {
  TambahOrder({Key? key}) : super(key: key);

  @override
  _TambahOrderState createState() => _TambahOrderState();
}

class _TambahOrderState extends State<TambahOrder> {
  String dropdownValue = 'blackforest';
  // <String> items = [
  //   'blackforest',
  //       'redvelvet'
  //       'lapislegit'
  //       'bikaambon'
  //       'rotitawar'
  //       'puding'
  // ];
  TextEditingController _namaPemesanController = new TextEditingController();
  TextEditingController _nomerHpController = new TextEditingController();
  // TextEditingController _namaPemesanController = new TextEditingController();
  TextEditingController _jumlahController = new TextEditingController();
  TextEditingController _alamatController = new TextEditingController();
  TextEditingController _catatanController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Tambah Pesanan"),
        ),
        body: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Nama Pemesan",
              ),
              controller: _namaPemesanController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "NomerHp",
              ),
              controller: _nomerHpController,
            ),
            DropdownButton(
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'blackforest',
                  'redvelvet',
                  'lapislegit',
                  'bikaambon',
                  'rotitawar',
                  'puding'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            TextField(
              decoration: const InputDecoration(
                hintText: "Alamat",
              ),
              controller: _alamatController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Jumlah",
              ),
              controller: _jumlahController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Catatan",
              ),
              controller: _catatanController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            Center(
              child: ElevatedButton(child: Text("Simpan"), onPressed: () {
                insert(_namaPemesanController.text, _nomerHpController.text, dropdownValue, _jumlahController.text, _alamatController.text, _catatanController.text);
              }),
            )
          ],
        ),
      ),
    );
  }
  insert(
  nama_pemesan,
  nomer_hp,
  kue,
  jumlah,
  alamat,
  catatan,
) async {
  Map data = {
    'nama': nama_pemesan,
    'nomer_hp': nomer_hp,
    'kue': kue,
    'jumlah': jumlah,
    'alamat': alamat,
    'catatan': catatan,
  };
  print(data.toString());
  final response =
      await http.post(Uri.parse("http://localhost/uenak-ci/api/admin/orderinsert"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));
  print(response.statusCode);
  if (response.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Admin(),));
  }
}
}


