import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:book_recomendation_hazlan/konversi_uang.dart';

class ExtraMenu extends StatefulWidget {
  const ExtraMenu({key});

  @override
  State<ExtraMenu> createState() => _ExtraMenuState();
}

class _ExtraMenuState extends State<ExtraMenu> {
  List<String> listWaktuBagian = <String>['WIB', 'WITA', 'WIT', 'UTC'];
  late String waktuBagian = listWaktuBagian.first;
  late String timeString;
  late Timer timer;
  late double input;
  late double output;
  late String currencyInput;
  late String currencyOutput;
  late String result;
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    timeString = _formatDateTime(DateTime.now());
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
    input = 0;
    currencyInput = 'IDR';
    currencyOutput = 'IDR';
    result = '';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void onInputChanged(String value) {
    setState(() {
      input = double.tryParse(value) ?? 0;
    });
  }

  void onCurrencyInputChanged(String? value) {
    setState(() {
      currencyInput = value ?? 'IDR';
    });
  }

  void onCurrencyOutputChanged(String? value) {
    setState(() {
      currencyOutput = value ?? 'IDR';
    });
  }

  void convert() {
    setState(() {
      switch (currencyInput) {
        case 'IDR':
          switch (currencyOutput) {
            case 'IDR':
              output = input;
              break;
            case 'USD':
              output = input * 0.000067;
              break;
            case 'SAR':
              output = input * 0.00025;
              break;
          }
          break;
        case 'USD':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 14936;
              break;
            case 'USD':
              output = input;
              break;
            case 'SAR':
              output = input * 3.75;
              break;
          }
          break;
        case 'SAR':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 3982.51;
              break;
            case 'USD':
              output = input * 0.27;
              break;
            case 'SAR':
              output = input;
              break;
          }
          break;
      }
      result = output.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Time In Four Zone',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                width: size.width * 1,
                child: const Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      timeString,
                      style:
                      const TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: DropdownButton<String>(
                      underline: Container(),
                      value: waktuBagian,
                      elevation: 16,
                      onChanged: (String? value) {
                        setState(() {
                          waktuBagian = value!;
                        });
                      },
                      items: listWaktuBagian
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 25, fontFamily: 'Poppins'),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 350,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Money Converter',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(
                width: size.width * 1,
                child: const Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: TextField(
                      onChanged: onInputChanged,
                      controller: inputController,
                      decoration: const InputDecoration(
                        filled: true,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ), //<-- SEE HERE
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ), //<-- SEE HERE
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    value: currencyInput,
                    items: const <String>['IDR', 'USD', 'SAR']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: onCurrencyInputChanged,
                  )
                ],
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 3, 3, 3)),
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey.shade300,
                    ),
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 55,
                    child: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    value: currencyOutput,
                    items: const <String>['IDR', 'USD', 'SAR']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: onCurrencyOutputChanged,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: convert,
                child: const Text(
                  'C O N V E R T',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getTime() {
    DateTime waktu;
    if (waktuBagian == 'WITA') {
      waktu = DateTime.now().add(const Duration(hours: 1));
    } else if (waktuBagian == 'WIT') {
      waktu = DateTime.now().add(const Duration(hours: 2));
    } else if (waktuBagian == 'UTC') {
      waktu = DateTime.now().toUtc();
    } else {
      waktu = DateTime.now();
    }

    final String formattedDateTime = _formatDateTime(waktu);
    setState(() {
      timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('kk:mm:ss').format(dateTime);
  }
}
