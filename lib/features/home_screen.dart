import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color.fromARGB(255, 110, 93, 207), // Warna ungu
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 25), // Jarak antara AppBar dengan GridView 1
            Text(
              'MENU BALITA',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 126, 111, 215),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: _buildGridView(
                context,
                [
                  MenuItem(
                    'Pendaftaran',
                    'assets/daftarbalita.png',
                    '/Pendaftaran',
                  ),
                  MenuItem(
                    'Pencatatan',
                    'timbangan.png',
                    '/Pencatatan',
                  ),
                  MenuItem(
                    'Catatan',
                    'catatan.png',
                    '/PencatatanList',
                  ),
                ],
              ),
            ),
            SizedBox(height: 5), // Jarak antara GridView 1 dengan GridView 2
            Text(
              'MENU IBU HAMIL',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 126, 111, 215),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: _buildGridView(
                context,
                [
                  MenuItem(
                    'Pendaftaran',
                    'pendaftaran2.png',
                    '/PendaftaranIbuHamil',
                  ),
                  MenuItem(
                    'Pencatatan',
                    'assets/iconbumil.png',
                    '/PencatatanIbuHamil',
                  ),
                  MenuItem(
                    'Catatan',
                    'catatan2.png',
                    '/ProgressIbuHamil',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, List<MenuItem> menuItems) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.0, // Pengurangan jarak antar kolom
        mainAxisSpacing: 16.0, // Pengurangan jarak antar baris
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(context, menuItems[index]);
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem menuItem) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, menuItem.route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 198, 188, 252),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 195, 195, 195).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              menuItem.imagePath,
              width: 60,
              height: 60,
            ),
            SizedBox(height: 10),
            Text(
              menuItem.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String imagePath;
  final String route;

  MenuItem(this.title, this.imagePath, this.route);
}
