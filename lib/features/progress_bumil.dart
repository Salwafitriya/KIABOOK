import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressIbuHamil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Ibu Hamil'),
        backgroundColor: Color.fromARGB(255, 126, 111, 215),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("PencatatanIbuHamil")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = documents[index];

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID Ibu Hamil: ${documentSnapshot.id}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Nama Ibu Hamil: ${documentSnapshot["namaIbuHamil"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Berat Ibu Hamil: ${documentSnapshot["beratIbuHamil"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Lingkar Perut Ibu Hamil: ${documentSnapshot["lingkarPerutIbuHamil"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Keluhan Ibu Hamil: ${documentSnapshot["keluhanIbuHamil"]}",
                          style: TextStyle(fontSize: 14),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
