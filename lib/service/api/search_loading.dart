import 'dart:convert';

import 'package:book_recomendation_hazlan/service/provider/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class searchloading extends StatefulWidget {
  var text;
  searchloading({@required this.text});

  @override
  State<searchloading> createState() => _searchloadingState();
}

class _searchloadingState extends State<searchloading> {
  var cp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    Response r = await get(
      Uri.parse(
          // "https://www.googleapis.com/books/v1/volumes?q=intitle:${widget.text}&maxResult=40&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"),
          "https://www.googleapis.com/books/v1/volumes?q=intitle:${widget.text}&maxResult=40&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"),
    );

    cp = jsonDecode(r.body);
    print(cp);
    try {
      if (cp['items'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No Book Found'),
          ),
        );
        Navigator.pop(context);
        return;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => searchfilter(
              d: cp,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No Book Found'),
        ),
      );
      Navigator.pop(context);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return (const Scaffold(
      body: Center(
        // ignore: prefer_const_constructors
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    ));
  }
}
