import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pencatatan extends StatefulWidget {
  @override
  _Pencatatan createState() => _Pencatatan();
}

class FirestoreService {
  final CollectionReference _dataBalitaCollection =
      FirebaseFirestore.instance.collection('DataBalita');

  Future<List<DocumentSnapshot>> fetchDataBalita() async {
    try {
      QuerySnapshot querySnapshot = await _dataBalitaCollection.get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<DocumentSnapshot> fetchBalitaById(String idBalita) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _dataBalitaCollection.doc(idBalita).get();
      return documentSnapshot;
    } catch (e) {
      print('Error fetching data by ID: $e');
      throw e;
    }
  }
}

class _Pencatatan extends State<Pencatatan> {
  FirestoreService _firestoreService = FirestoreService();
  List<DocumentSnapshot> dataBalitaList = [];
  String idBalita = "";
  String namaBalita = "";
  double berat = 0;
  double tinggi = 0;
  double lingkarKepala = 0;

  @override
  void initState() {
    super.initState();
    fetchDataBalita();
  }

  Future<void> fetchDataBalita() async {
    List<DocumentSnapshot> dataBalita =
        await _firestoreService.fetchDataBalita();
    setState(() {
      dataBalitaList = dataBalita;
    });
  }

  Future<void> fetchDataById(String id) async {
    DocumentSnapshot balita = await _firestoreService.fetchBalitaById(id);
    if (balita.exists) {
      setState(() {
        namaBalita = balita["namaBalita"];
      });
    } else {
      print('Dokumen tidak ditemukan');
    }
  }

  void getNamaBalita(String nama) {
    setState(() {
      namaBalita = nama;
    });
  }

  void getBerat(String beratInput) {
    setState(() {
      if (beratInput.isNotEmpty) {
        berat = double.tryParse(beratInput) ?? 0.0;
      } else {
        berat = 0.0;
      }
    });
  }

  void getTinggi(String tinggiInput) {
    setState(() {
      if (tinggiInput.isNotEmpty) {
        tinggi = double.tryParse(tinggiInput) ?? 0.0;
      } else {
        tinggi = 0.0;
      }
    });
  }

  void getLingkarKepala(String lingkarKepalaInput) {
    setState(() {
      if (lingkarKepalaInput.isNotEmpty) {
        lingkarKepala = double.tryParse(lingkarKepalaInput) ?? 0.0;
      } else {
        lingkarKepala = 0.0;
      }
    });
  }

  void createData() async {
    try {
      if (idBalita.isNotEmpty) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('DataBalita')
            .doc(idBalita)
            .get();

        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          Bayi bayi = Bayi.fromMap(data);

          DocumentReference documentReference =
              FirebaseFirestore.instance.collection("Pencatatan").doc(idBalita);

          Map<String, dynamic> catatan = {
            "namaBalita": bayi.namaBalita,
            "berat": berat.toString(),
            "tinggi": tinggi.toString(),
            "lingkarKepala": lingkarKepala.toString(),
          };

          documentReference.set(catatan).whenComplete(() {
            print("${bayi.namaBalita} - Pencatatan created");
          });
        } else {
          print('Dokumen tidak ditemukan');
        }
      } else {
        print('Nama Balita tidak boleh kosong');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Stream<QuerySnapshot> getPencatatanStream(String idBalita) {
    return FirebaseFirestore.instance
        .collection("Pencatatan")
        .where("namaBalita", isEqualTo: namaBalita)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pencatatan Balita"),
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
                  labelText: "Nama Balita",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String id) {
                  setState(() {
                    idBalita = id;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchDataById(idBalita);
              },
              child: Text("Cari Balita"),
            ),
            SizedBox(height: 16),
            Text("Nama Balita: $namaBalita"),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Berat",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String beratInput) {
                  getBerat(beratInput);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Tinggi",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String tinggiInput) {
                  getTinggi(tinggiInput);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Lingkar Kepala",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String lingkarKepalaInput) {
                  getLingkarKepala(lingkarKepalaInput);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                createData();
              },
              child: Text("Simpan Pencatatan"),
            ),
            StreamBuilder(
              stream: getPencatatanStream(idBalita),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;

                  return Column(
                    children: documents.map((doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;

                      return Card(
                        child: ListTile(
                          title: Text("Nama Balita: ${data["namaBalita"]}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Berat: ${data["berat"]}"),
                              Text("Tinggi: ${data["tinggi"]}"),
                              Text("Lingkar Kepala: ${data["lingkarKepala"]}"),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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

// Model Bayi
class Bayi {
  final String alamat;
  final String namaBalita;
  final String namaIbu;
  final String nikBalita;
  final String tanggalLahir;

  Bayi({
    required this.alamat,
    required this.namaBalita,
    required this.namaIbu,
    required this.nikBalita,
    required this.tanggalLahir,
  });

  // Konstruktor dari Map
  factory Bayi.fromMap(Map<String, dynamic> map) {
    return Bayi(
      alamat: map['alamat'] ?? '',
      namaBalita: map['namaBalita'] ?? '',
      namaIbu: map['namaIbu'] ?? '',
      nikBalita: map['nikBalita'].toString(),
      tanggalLahir: map['tanggalLahir'] ?? '',
    );
  }
}
