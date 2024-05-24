// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:book_recomendation_hazlan/service/category/fantasy.dart';
import 'package:book_recomendation_hazlan/service/category/horror.dart';
import 'package:book_recomendation_hazlan/service/category/health.dart';
import 'package:book_recomendation_hazlan/service/category/mystery.dart';
import 'package:book_recomendation_hazlan/service/api/search_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  var c1;
  var c2;
  var c3;
  var c4;

  HomeScreen(
      {@required this.c1,
      @required this.c2,
      @required this.c3,
      @required this.c4});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController t = TextEditingController();
  bool _isLoading = false; // Track loading state

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 3) {
        break;
      }
      if (s[i] == ' ') {
        count++;
      }
      ans = ans + s[i];
    }
    return ans + "...";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.c1);
    _loadData();
  }

    Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network call or data loading
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 37, 85, 50),
      //   title: Text(
      //     "Rekomendasi Buku",
      //     style: GoogleFonts.lato(
      //         textStyle: TextStyle(
      //             color: Colors.white,
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold)),
      //   ),
      // ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 37, 85, 50),
      body: SafeArea(
          child: _isLoading ? Center(child: CircularProgressIndicator())  : Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "book_bg.png",
                      ),
                      fit: BoxFit.cover)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: Container(
                        height: 40,
                        child: TextField(
                          controller: t,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Cari Buku...",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return searchloading(text: t.text);
                        }));
                      },
                      // splashColor: Color(0xfff012AC0),
                      // color: Colors.white,
                      child: Text(
                        "CARI",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Buku adalah jendela dunia",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "- Muhammad Yamin.",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.green[50],
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  "Kategori Buku:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 37, 85, 50),
                                    border: Border.all(
                                      width: 8,
                                      color: Color.fromARGB(255, 37, 85, 50),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40))),
                                child: const Text(
                                  "Fantasy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        fantasy(c2: widget.c2),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 37, 85, 50),
                                    border: Border.all(
                                      width: 8,
                                      color: Color.fromARGB(255, 37, 85, 50),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40))),
                                child: const Text(
                                  "Health",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        romance(c4: widget.c4),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 37, 85, 50),
                                    border: Border.all(
                                      width: 8,
                                      color: Color.fromARGB(255, 37, 85, 50),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40))),
                                child: const Text(
                                  "Horror",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        horror(c3: widget.c3),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 37, 85, 50),
                                    border: Border.all(
                                      width: 8,
                                      color: Color.fromARGB(255, 37, 85, 50),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40))),
                                child: const Text(
                                  "Riddle and Mystery",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        mystery(c1: widget.c1),
                      ],
                    )))
                  ],
                ),
              ))
        ],
      )),
    ));
  }
}
