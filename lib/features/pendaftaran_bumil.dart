import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendaftaranIbuHamil extends StatefulWidget {
  @override
  _PendaftaranIbuHamilState createState() => _PendaftaranIbuHamilState();
}

class _PendaftaranIbuHamilState extends State<PendaftaranIbuHamil> {
  String namaIbuHamil = "";
  String tanggalLahirIbuHamil = "";
  String alamatIbuHamil = "";
  double nikIbuHamil = 0;
  String namaSuami = ""; // Added field

  getNamaIbuHamil(namaIbu) {
    this.namaIbuHamil = namaIbu;
  }

  getNIKIbuHamil(nikIbu) {
    this.nikIbuHamil = double.parse(nikIbu);
  }

  getTanggalLahirIbuHamil(tanggalLahirIbu) {
    this.tanggalLahirIbuHamil = tanggalLahirIbu;
  }

  getAlamatIbuHamil(alamatIbu) {
    this.alamatIbuHamil = alamatIbu;
  }

  getNamaSuami(namaSuami) {
    this.namaSuami = namaSuami;
  }

  createDataIbuHamil() {
    print("created");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataIbuHamil").doc(namaIbuHamil);

    Map<String, dynamic> ibuHamil = {
      "namaIbuHamil": namaIbuHamil,
      "nikIbuHamil": nikIbuHamil,
      "tanggalLahirIbuHamil": tanggalLahirIbuHamil,
      "alamatIbuHamil": alamatIbuHamil,
      "namaSuami": namaSuami, // Added field
    };

    documentReference.set(ibuHamil).whenComplete(() {
      print("$namaIbuHamil created");
    });
  }

  readDataIbuHamil() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataIbuHamil").doc(namaIbuHamil);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        Map<String, dynamic> data = datasnapshot.data() as Map<String, dynamic>;

        print("Nama Ibu: ${data["namaIbuHamil"]}");
        print("NIK Ibu: ${data["nikIbuHamil"]}");
        print("Tanggal Lahir Ibu: ${data["tanggalLahirIbuHamil"]}");
        print("Alamat Ibu: ${data["alamatIbuHamil"]}");
        print("Nama Suami: ${data["namaSuami"]}"); // Added field
      } else {
        print("Document does not exist");
      }
    });
  }

  updateDataIbuHamil() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataIbuHamil").doc(namaIbuHamil);

    Map<String, dynamic> ibuHamil = {
      "namaIbuHamil": namaIbuHamil,
      "nikIbuHamil": nikIbuHamil.toString(),
      "tanggalLahirIbuHamil": tanggalLahirIbuHamil,
      "alamatIbuHamil": alamatIbuHamil,
      "namaSuami": namaSuami, // Added field
    };

    documentReference.set(ibuHamil).whenComplete(() {
      print("$namaIbuHamil updated");
    });
  }

  deleteDataIbuHamil() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataIbuHamil").doc(namaIbuHamil);

    documentReference.delete().whenComplete(() {
      print("$namaIbuHamil deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pendaftaran Ibu Hamil"),
        backgroundColor: Color.fromARGB(255, 126, 111, 215),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Nama Ibu Hamil",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String namaIbu) {
                  getNamaIbuHamil(namaIbu);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "NIK Ibu Hamil",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String nikIbu) {
                  getNIKIbuHamil(nikIbu);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Tanggal Lahir Ibu Hamil",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String tanggalLahirIbu) {
                  getTanggalLahirIbuHamil(tanggalLahirIbu);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Alamat Ibu Hamil",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String alamatIbu) {
                  getAlamatIbuHamil(alamatIbu);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Nama Suami",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String namaSuami) {
                  getNamaSuami(namaSuami);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    createDataIbuHamil();
                  },
                  child: Text("Create"),
                ),
                ElevatedButton(
                  onPressed: () {
                    readDataIbuHamil();
                  },
                  child: Text("Read"),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateDataIbuHamil();
                  },
                  child: Text("Update"),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteDataIbuHamil();
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.50),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                    child: Text("Nama Ibu"),
                  ),
                  Expanded(
                    child: Text("NIK Ibu"),
                  ),
                  Expanded(
                    child: Text("Tanggal Lahir Ibu"),
                  ),
                  Expanded(
                    child: Text("Alamat Ibu"),
                  ),
                  Expanded(
                    child: Text("Nama Suami"),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("DataIbuHamil")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot = documents[index];

                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(documentSnapshot["namaIbuHamil"]),
                          ),
                          Expanded(
                            child: Text(
                                documentSnapshot["nikIbuHamil"].toString()),
                          ),
                          Expanded(
                            child:
                                Text(documentSnapshot["tanggalLahirIbuHamil"]),
                          ),
                          Expanded(
                            child: Text(documentSnapshot["alamatIbuHamil"]),
                          ),
                          Expanded(
                            child: Text(documentSnapshot["namaSuami"]),
                          ),
                        ],
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
          ],
        ),
      ),
    );
  }
}
