import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonTableScreen extends StatefulWidget {
  @override
  _JsonTableScreenState createState() => _JsonTableScreenState();
}

class _JsonTableScreenState extends State<JsonTableScreen> {
  Map<String, dynamic> data = {}; // Change to hold a Map
  bool isLoading = false;

  Future<void> fetchData() async {
    setState(() => isLoading = true);

    final response = await http.get(
      Uri.parse(
        'https://vercel-zz1tl98to-nishchals-projects-80d9f9a5.vercel.app/api/check-fire',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JSON Data Table')),
      body: Column(
        children: [
          ElevatedButton(onPressed: fetchData, child: Text('Fetch Data')),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(child: buildTable()),
        ],
      ),
    );
  }

  Widget buildTable() {
    if (data.isEmpty) return Text('No data available');

    // Extract data
    String alert = data["alert"];
    Map<String, dynamic> details = data["details"];

    // Creating the DataTable for the "details"
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          // Display the alert at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              alert,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Create the DataTable for details
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns:
                  details.keys
                      .map<DataColumn>((key) => DataColumn(label: Text(key)))
                      .toList(),
              rows: [
                DataRow(
                  cells:
                      details.values
                          .map<DataCell>(
                            (value) => DataCell(Text(value.toString())),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
