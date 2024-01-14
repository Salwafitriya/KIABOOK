import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PencatatanList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pencatatan Balita'),
        backgroundColor: Color.fromARGB(255, 126, 111, 215),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Pencatatan").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = documents[index];

                return Card(
                  child: ListTile(
                    title:
                        Text("Nama Balita: ${documentSnapshot["namaBalita"]}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Berat: ${documentSnapshot["berat"]}"),
                        Text("Tinggi: ${documentSnapshot["tinggi"]}"),
                        Text(
                            "Lingkar Kepala: ${documentSnapshot["lingkarKepala"]}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
