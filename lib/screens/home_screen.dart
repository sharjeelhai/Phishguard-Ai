import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController urlController = TextEditingController();
  bool loading = false;

  void checkURL() async {
    setState(() => loading = true);

    var result = await ApiService.checkUrl(urlController.text);

    setState(() => loading = false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultScreen(result: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text("PhishGuard AI"),
        backgroundColor: Colors.indigo.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),

            // HEADER CARD
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blueAccent],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.white, size: 40),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "AI Phishing Detection Engine",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            // INPUT FIELD (FIXED DARK TEXT ISSUE)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: TextField(
                controller: urlController,
                style: TextStyle(color: Colors.black), // FIXED
                decoration: InputDecoration(
                  hintText: "Enter suspicious URL...",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.link),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),

            SizedBox(height: 20),

            // BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade700,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: loading ? null : checkURL,
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("SCAN URL"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
