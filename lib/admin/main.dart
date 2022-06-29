import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uenak/admin/detailOrder.dart';
import 'package:uenak/admin/tambahOrder.dart';

class Admin extends StatefulWidget {
  Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  late Future<List<Data>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: fetchData,
        child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TambahOrder(),));
          },
        ),
        appBar: AppBar(
          title: Text("Admin"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: FutureBuilder <List<Data>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data>? data = snapshot.data;
                return 
                ListView.builder(
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    
                    // onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOrder(id: data![index].id),));
                    // },
                    title: Text(data![index].nama_pemesan),
                    // subtitle: RichText(text: Text.rich()),
                    subtitle: Text("Rp. ${data[index].total} \n${data[index].kue} \n${data[index].alamat}"),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(data[index].total),
                    //     Text(data[index].kue)
                    //   ],
                    // ),
                    trailing: Text(data[index].jumlah),
                    leading: IconButton(onPressed: (){
                      delete(data[index].id);
                    }, icon: Icon(Icons.delete)),
                  );
                }
              );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
      )
    );
  }
delete(id) async{
  final response =
      await http.delete(Uri.parse("http://localhost/uenak-ci/api/admin/delete/"+id));
  print(response.statusCode);
  if (response.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Admin(),));
  }
}
}



Future<List<Data>> fetchData() async {
  final response =
      await http.get(Uri.parse("http://localhost/uenak-ci/api/admin/order/"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['pesanan'];
    
    // return "";
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String id;
  final String total;
  final String nama_pemesan;
  final String nomer_hp;
  final String kue;
  final String jumlah;
  final String alamat;
  final String catatan;

  Data({
    required this.total,
    required this.id,
    required this.nama_pemesan,
    required this.nomer_hp,
    required this.kue,
    required this.jumlah,
    required this.alamat,
    required this.catatan,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      total: json['total'],
      id:  json['id'],
      nama_pemesan: json['nama_pemesan'],
      nomer_hp: json['nomer_hp'],
      kue: json['kue'],
      jumlah: json['jumlah'],
      alamat: json['alamat'],
      catatan: json['catatan'],
      // userId: json['userId'],
      // id: json['id'],
      // title: json['title'],
    );
  }
}
