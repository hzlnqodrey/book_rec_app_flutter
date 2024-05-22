import 'package:flutter/material.dart';

class KesanPesan extends StatelessWidget {
  const KesanPesan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kesan dan Pesan'),),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kesan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            SizedBox(height: 10,),
            Text('TPM is so cool),
            SizedBox(height: 20,),
            Text('Pesan', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('Semoga Kedepannya lebih baik lagi'),
          ],
        ),
      ),

    );
  }
}
