import 'package:flutter/material.dart';

class KesanPesan extends StatelessWidget {
  const KesanPesan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saran dan Kesan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                'Bapak mungkin bisa lebih informatif lagi dalam pembagian informasi/pengumuman tentang perkuliahan TPM di grup whatsapp kelas dan juga di spada agar mahasiswa lebih mudah dalam memahami materi, tugas, dan presentasi yang diberikan oleh dosen. Terimakasih'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Kesan',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                'TPM merupakan  mata kuliah yang sangat menarik dan bermanfaat bagi mahasiswa teknik informatika terutama yang mengejar karir sebagai Android Developer. Dosen juga sangat baik dalam memberikan materi dan penjelasan sehingga mahasiswa lebih mudah dalam memahami materi yang diberikan. Terimakasih pak.'),
          ],
        ),
      ),
    );
  }
}
