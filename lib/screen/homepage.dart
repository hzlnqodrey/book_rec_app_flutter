import 'package:book_recomendation_hazlan/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'extra_menu.dart';
import 'profile.dart';
import '../service/api/loadingscreen.dart';
import 'package:book_recomendation_hazlan/screen/saran_kesan.dart';
import 'package:book_recomendation_hazlan/models/shared_preference.dart';
import 'package:book_recomendation_hazlan/screen/login_page.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController c;
  var c1;
  var c2;
  var c3;
  var c4;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  void initState() {
    // TODO: implement initState
    super.initState();
    getcategorydata();
  }

  void getcategorydata() async {
    Response r1 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:mystery&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    Response r2 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    Response r3 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:horror&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    Response r4 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:health&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
    c1 = jsonDecode(r1.body);
    c2 = jsonDecode(r2.body);
    c3 = jsonDecode(r3.body);
    c4 = jsonDecode(r4.body);

    // Shuffle the books
    c1['items'].shuffle(Random());
    c2['items'].shuffle(Random());
    c3['items'].shuffle(Random());
    c4['items'].shuffle(Random());
    print(c1);
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return HomeScreen(c1: c1, c2: c2, c3: c3, c4: c4);
    // }));
  }

  Widget bodyFunction() {
    switch (_page) {
      case 0:
        return Profil();
        break;
      case 1:
        return ExtraMenu();
        break;
      case 2:
        return KesanPesan();
        break;
      case 3:
        return HomeScreen(c1: c1, c2: c2, c3: c3, c4: c4);
        break;
      default:
        return Profil();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rekomendasi Buku",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Color.fromARGB(255, 37, 85, 50),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              exit(context); // panggil fungsi exit saat tombol logout ditekan
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 37, 85, 50),
      body: bodyFunction(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_rounded),
            label: 'Extra Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Kesan dan Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
        currentIndex: _page,
        selectedItemColor: Colors.green[800],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}

void exit(BuildContext context) async {
  SharedPreference().setLogout();
  AlertDialog alert = AlertDialog(
    title: Text("Log Out"),
    content: Container(
      child: Text("Apakah Anda Yakin Ingin Log Out ?"),
    ),
    actions: [
      TextButton(
        child: Text('Yes'),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
        },
      ),
      TextButton(
        child: Text('No'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
  showDialog(context: context, builder: (context) => alert);
}
