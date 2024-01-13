// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  //late Future<List<dynamic>> requestData ;
  late String statusValue;
  late bool error;
  late String message;
  List<String> statusValueList = ["approved", "pending", "rejected"];

  @override
  void initState() {
    super.initState();
    statusValue = 'pending';
    error = false;
    message = "";
    //requestData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    String apiUrl =
        'http://192.168.1.19:3000/admin?status=$statusValue'; // Replace with your actual API endpoint
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['data']['request_data'];
      // setState(() {
      //   requestData = responseData['data']['request_data'];
      // });
    } else {
      // Handle error
      print('Failed to load data');
      throw ("No response");
    }
  }

  Future<void> processRequest(int requestId, String action) async {
    const apiUrl =
        'http://192.168.1.19:3000/admin'; // Replace with your actual API endpoint
    const adminId = 2;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'admin_id': adminId.toString(),
        'request_id': requestId.toString(),
        'action': action
      }),
    );

    if (response.statusCode == 200) {
      // Request processed successfully, you may want to update the UI or perform other actions
      print('Request processed successfully');
    } else {
      // Handle error
      print('Failed to process request');
    }
    //fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Current Requests'),
        ),
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done ||
                  snapshot.connectionState == ConnectionState.active) {
                List<dynamic>? data = snapshot.data;
                if (data == null) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        const Center(
                            child: Text(
                                "Some error occured. Please check internet connection")),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text(
                            'Refresh',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return data.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 4.0,
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            DropdownButton(
                              isExpanded: true,
                              //padding: const EdgeInsets.only(left: 16, right: 16),
                              value: statusValue,
                              hint: const Text("Select Status"),
                              items: statusValueList.map((statusValue) {
                                return DropdownMenuItem(
                                  value: statusValue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      // Center-align text
                                      child: Text(
                                        statusValue
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            statusValue
                                                .substring(1)
                                                .toLowerCase(),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ), //value of item
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  statusValue = value ?? "pending";
                                });
                              },
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final request = data[index];
                                  return Card(
                                    //margin: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      // title: Text('Name: ${request['name']}'),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                8.0), // Add padding as needed
                                            child: Text(
                                                'Name: ${request['name']}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                8.0), // Add padding as needed
                                            child: Text(
                                                'Email: ${request['email']}'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                8.0), // Add padding as needed
                                            child: Text(
                                                'Expected Salary: ${request['expectedSalary']}'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                8.0), // Add padding as needed
                                            child: Text(
                                                'Status: ${request['status']}'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                8.0), // Add padding as needed
                                            child: Text(
                                                'Update Time: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.parse(request['updateTime']))}'),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // mainAxisSize: MainAxisSize.min,
                                            children: statusValue != 'pending'
                                                ? []
                                                : [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // Accept button pressed
                                                        processRequest(
                                                            request['id'],
                                                            'approved');
                                                      },
                                                      child: const Text(
                                                        'Accept',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // Reject button pressed
                                                        processRequest(
                                                            request['id'],
                                                            'rejected');
                                                      },
                                                      child: const Text(
                                                        'Reject',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      const Center(
                          child: Text(
                              "Some error occured. Please check internet connection")),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text(
                          'Refresh',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 4.0,
                  ),
                );
              }
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminPage(),
  ));
}
