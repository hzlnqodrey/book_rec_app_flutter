import 'package:flutter/material.dart';

class MoneyConverterPage extends StatefulWidget {
  const MoneyConverterPage({Key? key}) : super(key: key);

  @override
  State<MoneyConverterPage> createState() => _MoneyConverterPageState();
}

class _MoneyConverterPageState extends State<MoneyConverterPage> {
  late double input;
  late double output;
  late String currencyInput;
  late String currencyOutput;
  late String result;

  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    input = 0;
    currencyInput = 'IDR';
    currencyOutput = 'IDR';
    result = '';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Mata Uang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
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
                              color: Colors.teal,
                            ), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ), //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton(
                      value: currencyInput,
                      items: const <String>['IDR', 'USD', 'EUR']
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
                const Icon(Icons.keyboard_arrow_down_outlined),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
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
                      items: const <String>['IDR', 'USD', 'EUR']
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: convert,
                  child: const Text('Konversi'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}