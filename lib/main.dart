import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tapthetarget_robot/start_game.dart';
import 'web_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url = '';
  bool isOpen = false;
  bool isDataFetched = false;

  Future<void> fetchIsOn() async {
    try {
      final response = await http.get(
        Uri.parse('https://6703907dab8a8f892730a6d2.mockapi.io/api/v1/elementalmatch'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            isOpen = data[0]['is_on'] ?? false;
            url = data[0]['url'] ?? '';
            isDataFetched = true;
          });
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchIsOn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isOpen && url.isNotEmpty
          ? WebViewScreen(backgroundColor: Colors.white, url: url)
          : const StartGame(),
    );
  }
}
