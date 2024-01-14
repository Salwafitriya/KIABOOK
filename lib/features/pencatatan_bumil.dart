import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PencatatanIbuHamil extends StatefulWidget {
  @override
  _PencatatanIbuHamilState createState() => _PencatatanIbuHamilState();
}

class FirestoreServiceIbuHamil {
  final CollectionReference _dataIbuHamilCollection =
      FirebaseFirestore.instance.collection('DataIbuHamil');

  Future<List<DocumentSnapshot>> fetchDataIbuHamil() async {
    try {
      QuerySnapshot querySnapshot = await _dataIbuHamilCollection.get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<DocumentSnapshot> fetchIbuHamilById(String idIbuHamil) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _dataIbuHamilCollection.doc(idIbuHamil).get();
      return documentSnapshot;
    } catch (e) {
      print('Error fetching data by ID: $e');
      throw e;
    }
  }
}

class _PencatatanIbuHamilState extends State<PencatatanIbuHamil> {
  FirestoreServiceIbuHamil _firestoreServiceIbuHamil =
      FirestoreServiceIbuHamil();
  List<DocumentSnapshot> dataIbuHamilList = [];
  String idIbuHamil = "";
  String namaIbuHamil = "";
  double beratIbuHamil = 0;
  double lingkarPerutIbuHamil = 0;
  String keluhanIbuHamil = "";

  @override
  void initState() {
    super.initState();
    fetchDataIbuHamil();
  }

  Future<void> fetchDataIbuHamil() async {
    List<DocumentSnapshot> dataIbuHamil =
        await _firestoreServiceIbuHamil.fetchDataIbuHamil();
    setState(() {
      dataIbuHamilList = dataIbuHamil;
    });
  }

  Future<void> fetchDataByIdIbuHamil(String id) async {
    DocumentSnapshot ibuHamil =
        await _firestoreServiceIbuHamil.fetchIbuHamilById(id);
    if (ibuHamil.exists) {
      setState(() {
        namaIbuHamil = ibuHamil["namaIbuHamil"];
      });
    } else {
      print('Dokumen tidak ditemukan');
    }
  }

  void getNamaIbuHamil(String nama) {
    setState(() {
      namaIbuHamil = nama;
    });
  }

  void getBeratIbuHamil(String beratInput) {
    setState(() {
      if (beratInput.isNotEmpty) {
        beratIbuHamil = double.tryParse(beratInput) ?? 0.0;
      } else {
        beratIbuHamil = 0.0;
      }
    });
  }

  void getLingkarPerutIbuHamil(String lingkarPerutInput) {
    setState(() {
      if (lingkarPerutInput.isNotEmpty) {
        lingkarPerutIbuHamil = double.tryParse(lingkarPerutInput) ?? 0.0;
      } else {
        lingkarPerutIbuHamil = 0.0;
      }
    });
  }

  void getKeluhanIbuHamil(String keluhanInput) {
    setState(() {
      keluhanIbuHamil = keluhanInput;
    });
  }

  void createDataIbuHamil() async {
    try {
      if (idIbuHamil.isNotEmpty) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('DataIbuHamil')
            .doc(idIbuHamil)
            .get();

        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          IbuHamil ibuHamil = IbuHamil.fromMap(data);

          DocumentReference documentReference = FirebaseFirestore.instance
              .collection("PencatatanIbuHamil")
              .doc(idIbuHamil);

          Map<String, dynamic> catatan = {
            "namaIbuHamil": ibuHamil.namaIbuHamil,
            "beratIbuHamil": beratIbuHamil.toString(),
            "lingkarPerutIbuHamil": lingkarPerutIbuHamil.toString(),
            "keluhanIbuHamil": keluhanIbuHamil,
          };

          documentReference.set(catatan).whenComplete(() {
            print("${ibuHamil.namaIbuHamil} - Pencatatan Ibu Hamil created");
          });
        } else {
          print('Dokumen tidak ditemukan');
        }
      } else {
        print('ID Ibu Hamil tidak boleh kosong');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pencatatan Ibu Hamil"),
        backgroundColor: Color.fromARGB(255, 126, 111, 215),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nama Ibu Hamil",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    onChanged: (String id) {
                      setState(() {
                        idIbuHamil = id;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      fetchDataByIdIbuHamil(idIbuHamil);
                    },
                    child: Text("Cari Ibu Hamil"),
                  ),
                  SizedBox(height: 16),
                  Text("Nama Ibu Hamil: $namaIbuHamil"),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Berat Ibu Hamil",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      onChanged: (String beratInput) {
                        getBeratIbuHamil(beratInput);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Lingkar Perut Ibu Hamil",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      onChanged: (String lingkarPerutInput) {
                        getLingkarPerutIbuHamil(lingkarPerutInput);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Keluhan Ibu Hamil",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      onChanged: (String keluhanInput) {
                        getKeluhanIbuHamil(keluhanInput);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      createDataIbuHamil();
                    },
                    child: Text("Simpan Pencatatan Ibu Hamil"),
                  ),
                ],
              ),
            ),
            // Missing closing parenthesis here
          ],
        ),
      ),
    );
  }
}

// Model IbuHamil
class IbuHamil {
  final String alamat;
  final String namaIbuHamil;
  final String namaSuami;
  final String nikIbuHamil;
  final String tanggalLahirIbuHamil;

  IbuHamil({
    required this.alamat,
    required this.namaIbuHamil,
    required this.namaSuami,
    required this.nikIbuHamil,
    required this.tanggalLahirIbuHamil,
  });

  // Konstruktor dari Map
  factory IbuHamil.fromMap(Map<String, dynamic> map) {
    return IbuHamil(
      alamat: map['alamat'] ?? '',
      namaIbuHamil: map['namaIbuHamil'] ?? '',
      namaSuami: map['namaSuami'] ?? '',
      nikIbuHamil: map['nikIbuHamil'].toString(),
      tanggalLahirIbuHamil: map['tanggalLahirIbuHamil'] ?? '',
    );
  }
}
