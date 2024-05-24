// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:ui';

import 'package:book_recomendation_hazlan/service/api/bookloading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:book_recomendation_hazlan/screen/bookdisplay.dart';

class searchfilter extends StatefulWidget {
  var d;
  searchfilter({@required this.d});

  @override
  State<searchfilter> createState() => _searchfilterState();
}

class _searchfilterState extends State<searchfilter> {
  var isbn;

  getisbn(int index) {
    try {
      setState(() {
        isbn = widget.d["items"][index + 1]["volumeInfo"]["industryIdentifiers"]
            [0]["identifier"];
      });
      print(isbn);
      print("MASUK SINI 1 !!!");
      if (isbn != null) {
        print("MASUK SINI 3 !!!");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return bookloading(
              c: widget.d["items"][index + 1]["volumeInfo"]
                  ["industryIdentifiers"][0]["identifier"]);
        }));
      } else {
        print("error 1 !!!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book details are not available'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("error 2 !!!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Book details are not available'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 20) {
        break;
      }
      count++;
      ans = ans + s[i];
    }
    return ans + "...";
  }

  @override
  var url = "";
  void initState() {
    // TODO: implement initState
    super.initState();
    geturl(0);
  }

  geturl(int index) {
    try {
      url =
          widget.d["items"][index + 1]["volumeInfo"]["imageLinks"]["thumbnail"];
    } catch (e) {
      SnackBar(content: Text("Image not available"));
    }
  }

  String getImageUrl(int index) {
    String imageUrl =
        "https://islandpress.org/files/default_book_cover_2015.jpg";
    try {
      imageUrl =
          widget.d["items"][index + 1]["volumeInfo"]["imageLinks"]["thumbnail"];
    } catch (e) {
      print("Error getting image URL: $e");
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(70, 150, 196, 162), // green[50]
        body: Column(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Hasil Pencarian",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "   ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.d["items"].length == null
                    ? 0
                    : widget.d["items"].length - 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 270,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(10),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.white.withOpacity(0.2),
                            ),
                            color: Color.fromARGB(255, 37, 85, 50),
                            image: DecorationImage(
                              image: AssetImage("assets/overlay.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 210,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(getImageUrl(index)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Flexible(
                                    child: Text(
                                      (widget.d["items"][index + 1]
                                                      ["volumeInfo"]["title"])
                                                  .length >
                                              20
                                          ? st(widget.d["items"][index + 1]
                                              ["volumeInfo"]["title"])
                                          : widget.d["items"][index + 1]
                                              ["volumeInfo"]["title"],
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      (widget.d["items"][index + 1]
                                                          ["volumeInfo"]
                                                      ["authors"][0])
                                                  .length >
                                              20
                                          ? "by " +
                                              st(widget.d["items"][index + 1]
                                                  ["volumeInfo"]["authors"][0])
                                          : "by " +
                                              widget.d["items"][index + 1]
                                                  ["volumeInfo"]["authors"][0],
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Page Count:- " +
                                        (widget.d["items"][index + 1]
                                                ["volumeInfo"]["pageCount"]
                                            .toString()),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    (widget.d["items"][index + 1]["volumeInfo"]
                                                ["averageRating"]) ==
                                            null
                                        ? "⭐ " + "Not rating available"
                                        : "⭐ " +
                                            (widget.d["items"][index + 1]
                                                    ["volumeInfo"]
                                                    ["averageRating"]
                                                .toString()),
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("MASUK SINI 2 !!!");
                                      getisbn(index);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(
                                          70, 150, 196, 162), // green[50],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      "DETAILS",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
