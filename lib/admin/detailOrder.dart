import 'package:flutter/material.dart';

class DetailOrder extends StatefulWidget {
  late String id;
  DetailOrder({Key? key,required this.id}) : super(key: key);

  @override
  _DetailOrderState createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
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
                // insert(_namaPemesanController.text, _nomerHpController.text, dropdownValue, _jumlahController.text, _alamatController.text, _catatanController.text);
              }),
            )
          ],
        ),
      ),
    );
  }
}