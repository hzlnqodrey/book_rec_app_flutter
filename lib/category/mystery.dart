import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../service/api/bookloading.dart';

class mystery extends StatefulWidget {
  var c1;
  mystery({@required this.c1});

  @override
  State<mystery> createState() => _mysteryState();
}

class _mysteryState extends State<mystery> {
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
  Widget build(BuildContext context) {
    return (Container(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // home screen book list view max (9 books)
          itemCount: 9,
          itemBuilder: (context, index) {
            return (Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return bookloading(
                              c: widget.c1["items"][index + 1]["volumeInfo"]
                                  ["industryIdentifiers"][0]["identifier"]);
                        }));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 230,
                            width: 150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 8,
                                    offset: Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(widget.c1["items"]
                                          [index + 1]["volumeInfo"]
                                      ["imageLinks"]["thumbnail"]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (widget.c1["items"][index + 1]["volumeInfo"]
                                            ["title"])
                                        .length >
                                    20
                                ? st(widget.c1["items"][index + 1]["volumeInfo"]
                                    ["title"])
                                : widget.c1["items"][index + 1]["volumeInfo"]
                                    ["title"],
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
          }),
    ));
  }
}
