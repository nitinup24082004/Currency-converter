import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatelessWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 70, 140),
        title: const Text(
          'Currency Converter',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: const CurrencyConverterBody(),
    );
  }
}

class CurrencyConverterBody extends StatefulWidget {
  const CurrencyConverterBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterBodyState createState() => _CurrencyConverterBodyState();
}

class _CurrencyConverterBodyState extends State<CurrencyConverterBody> {
  final TextEditingController _usdController = TextEditingController();
  final TextEditingController _inrController = TextEditingController();
  final double _exchangeRate = 82.0; // 1 USD = 82 INR

  @override
  void initState() {
    super.initState();

    // Add listener to clear INR field when USD field is cleared
    _usdController.addListener(() {
      if (_usdController.text.isEmpty) {
        setState(() {
          _inrController.clear();
        });
      }
    });
  }

  void _convertCurrency() {
    setState(() {
      double? usdAmount = double.tryParse(_usdController.text);
      if (usdAmount != null) {
        double convertedAmount = usdAmount * _exchangeRate;
        _inrController.text = convertedAmount.toStringAsFixed(2);
      } else {
        _inrController.text = '';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid input! Please enter a number.'),
          ),
        );
      }
    });

    if (kDebugMode) {
      print('Conversion Complete: ${_inrController.text} INR');
    }
  }

  @override
  void dispose() {
    _usdController.dispose();
    _inrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter USD Amount:',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 70, 140),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _usdController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter amount in USD',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.monetization_on_outlined),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
          const Text(
            'Converted INR Amount:',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 70, 140),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _inrController,
              readOnly: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Converted amount in INR',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.currency_rupee),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: _convertCurrency,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 0, 153, 76),
                ),
                elevation: MaterialStateProperty.all(5),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                fixedSize: MaterialStateProperty.all(const Size(150, 50)),
              ),
              child: const Text(
                'CONVERT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
