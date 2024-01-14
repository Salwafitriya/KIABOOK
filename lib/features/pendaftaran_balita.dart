import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pendaftaran extends StatefulWidget {
  @override
  // Pendaftaran({Key? key}) : super(key: key);
  _Pendaftaran createState() => _Pendaftaran();
}

class _Pendaftaran extends State<Pendaftaran> {
  String namaBalita = "";
  String tanggalLahir = "";
  String namaIbu = "";
  String alamat = "";
  double nikBalita = 0;

  // , NIKBalita, TanggalLahir, NamaIbu, Alamat;

  getNamaBalita(namabalita) {
    this.namaBalita = namabalita;
  }

  getNIKBalita(nikbalita) {
    this.nikBalita = double.parse(nikbalita);
  }

  getTanggalLahir(tanggallahir) {
    this.tanggalLahir = tanggallahir;
  }

  getNamaIbu(namaibu) {
    this.namaIbu = namaibu;
  }

  getAlamat(alamat) {
    this.alamat = alamat;
  }

  createData() {
    print("created");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataBalita").doc(namaBalita);

    Map<String, dynamic> balita = {
      "namaBalita": namaBalita,
      "nikBalita": nikBalita,
      "tanggalLahir": tanggalLahir,
      "namaIbu": namaIbu,
      "alamat": alamat,
    };

    documentReference.set(balita).whenComplete(() {
      print("$namaBalita created");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataBalita").doc(namaBalita);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        Map<String, dynamic> data = datasnapshot.data() as Map<String, dynamic>;

        print("Nama Balita: ${data["namaBalita"]}");
        print("NIK Balita: ${data["nikBalita"]}");
        print("Tanggal Lahir: ${data["tanggalLahir"]}");
        print("Nama Ibu: ${data["namaIbu"]}");
        print("Alamat: ${data["alamat"]}");
      } else {
        print("Document does not exist");
      }
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataBalita").doc(namaBalita);

    Map<String, dynamic> balita = {
      "namaBalita": namaBalita,
      "nikBalita": nikBalita.toString(),
      "tanggalLahir": tanggalLahir,
      "namaIbu": namaIbu,
      "alamat": alamat,
    };

    documentReference.set(balita).whenComplete(() {
      print("$namaBalita updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("DataBalita").doc(namaBalita);

    documentReference.delete().whenComplete(() {
      print("$namaBalita deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pendaftaran Balita"),
          backgroundColor: Color.fromARGB(255, 126, 111, 215),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Nama Balita",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String namabalita) {
                    getNamaBalita(namabalita);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "NIK Balita",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String nikbalita) {
                    getNIKBalita(nikbalita);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Tanggal Lahir",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String tanggallahir) {
                    getTanggalLahir(tanggallahir);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Nama Ibu",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String namaibu) {
                    getNamaIbu(namaibu);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Alamat",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0))),
                  onChanged: (String alamat) {
                    getAlamat(alamat);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 33, 110, 173), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      createData();
                    },
                    child: Text("Create"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 14, 134, 141), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      readData();
                    },
                    child: Text("Read"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 149, 130, 255), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      updateData();
                    },
                    child: Text("Update"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 243, 33, 33), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      deleteData();
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
                      child: Text("Nama"),
                    ),
                    Expanded(
                      child: Text("NIK"),
                    ),
                    Expanded(
                      child: Text("Tanggal Lahir"),
                    ),
                    Expanded(
                      child: Text("Nama Ibu"),
                    ),
                    Expanded(
                      child: Text("Alamat"),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("DataBalita")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final documents =
                        snapshot.data!.docs; // Corrected property name

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot = documents[index];

                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(documentSnapshot["namaBalita"]),
                            ),
                            Expanded(
                              child: Text(
                                  documentSnapshot["nikBalita"].toString()),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["tanggalLahir"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["namaIbu"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["alamat"]),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator(); // Or any loading indicator you prefer
                  }
                },
              ),
            ])));
  }
}
