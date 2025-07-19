import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown Example'),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String selectedText = 'Item 1'; // Set the initial selected value

  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4']; // List of items

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: selectedText,
            onChanged: (String? newValue) {
              setState(() {
                selectedText = newValue!;
              });
            },
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text(
            'Selected Text: $selectedText',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

