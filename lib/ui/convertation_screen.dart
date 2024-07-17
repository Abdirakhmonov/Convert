import 'package:currency_converter/models/currency.dart';
import 'package:flutter/material.dart';

class ConvertationScreen extends StatefulWidget {
  final Currency currency;

  const ConvertationScreen({super.key, required this.currency});

  @override
  _ConvertationScreenState createState() => _ConvertationScreenState();
}

class _ConvertationScreenState extends State<ConvertationScreen> {
  final TextEditingController _controller = TextEditingController();
  double convertedAmount = 0.0;
  bool isUsdToCurrency = true;

  void _convertCurrency() {
    final amount = double.tryParse(_controller.text);
    if (amount != null) {
      setState(() {
        if (isUsdToCurrency) {
          convertedAmount = amount * widget.currency.currency;
        } else {
          convertedAmount = amount / widget.currency.currency;
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Convert to ${widget.currency.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                labelText: isUsdToCurrency
                    ? 'Enter  in USD'
                    : 'Enter  in ${widget.currency.name}',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20,),
            FilledButton(
              onPressed: _convertCurrency,style: FilledButton.styleFrom(shape: RoundedRectangleBorder()),
              child: const Text(
                "Convert",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted: ${convertedAmount.toStringAsFixed(2)} ${isUsdToCurrency ? widget.currency.name : 'USD'}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
    );
  }
}
