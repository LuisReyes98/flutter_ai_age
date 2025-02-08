import 'dart:math';

import 'package:flutter/material.dart';

class CompoundInterestCalculator extends StatefulWidget {
  const CompoundInterestCalculator({super.key});

  @override
  _CompoundInterestCalculatorState createState() =>
      _CompoundInterestCalculatorState();
}

class _CompoundInterestCalculatorState
    extends State<CompoundInterestCalculator> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _timesController = TextEditingController();

  double? _futureValue;
  double? _principalAmount;

  void _calculateCompoundInterest() {
    if (_formKey.currentState!.validate()) {
      double principal = double.parse(_principalController.text);
      double rate = double.parse(_rateController.text) / 100;
      int years = int.parse(_yearsController.text);
      int compoundsPerYear = int.parse(_timesController.text);

      setState(() {
        _principalAmount = principal;
        _futureValue = principal *
            pow((1 + rate / compoundsPerYear), compoundsPerYear * years);
      });
    }
  }

  @override
  void dispose() {
    _principalController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    _timesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compound Interest Calculator"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _principalController,
                decoration: InputDecoration(
                  labelText: "Principal Amount",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the principal amount";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _rateController,
                decoration: InputDecoration(
                  labelText: "Interest Rate (%)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the interest rate";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _yearsController,
                decoration: InputDecoration(
                  labelText: "Number of Years",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the number of years";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _timesController,
                decoration: InputDecoration(
                  labelText: "Times compounded per year",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the number of times interest is compounded per year";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateCompoundInterest,
                child: Text("Calculate"),
              ),
              SizedBox(height: 24),
              if (_futureValue != null && _principalAmount != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Future Value: ${_futureValue!.toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Principal Amount: ${_principalAmount!.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Difference: ${(_futureValue! - _principalAmount!).toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
