// // pencatatan_list.dart
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PencatatanList extends StatelessWidget {
//   final List<DocumentSnapshot> pencatatanList;

//   PencatatanList({required this.pencatatanList});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(16.50),
//           child: Row(
//             textDirection: TextDirection.ltr,
//             children: <Widget>[
//               Expanded(
//                 child: Text("Nama"),
//               ),
//               Expanded(
//                 child: Text("Berat"),
//               ),
//               Expanded(
//                 child: Text("Tinggi"),
//               ),
//               Expanded(
//                 child: Text("Lingkar Kepala"),
//               ),
//             ],
//           ),
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: pencatatanList.length,
//           itemBuilder: (context, index) {
//             DocumentSnapshot documentSnapshot = pencatatanList[index];

//             return Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Text(documentSnapshot["namaBalita"]),
//                 ),
//                 Expanded(
//                   child: Text(documentSnapshot["berat"].toString()),
//                 ),
//                 Expanded(
//                   child: Text(documentSnapshot["tinggi"].toString()),
//                 ),
//                 Expanded(
//                   child: Text(documentSnapshot["lingkarKepala"].toString()),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
