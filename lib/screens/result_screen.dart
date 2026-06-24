import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map result;

  ResultScreen({required this.result});

  Color getColor(String label) {
    if (label == "PHISHING") return Colors.red;
    if (label == "SUSPICIOUS") return Colors.orange;
    return Colors.green;
  }

  IconData getIcon(String label) {
    if (label == "PHISHING") return Icons.warning_amber_rounded;
    if (label == "SUSPICIOUS") return Icons.error_outline;
    return Icons.verified;
  }

  @override
  Widget build(BuildContext context) {
    String label = (result["label"] ?? "SAFE").toString();
    int confidence = (result["confidence"] ?? 0);
    List reasons = result["reasons"] ?? [];

    return Scaffold(
      backgroundColor: Color(0xFFF4F6FB),
      appBar: AppBar(
        title: Text("Security Report"),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(getIcon(label), size: 90, color: getColor(label)),

              SizedBox(height: 10),

              Text(
                label,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: getColor(label),
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Risk Score: $confidence%",
                style: TextStyle(color: Colors.grey.shade700),
              ),

              SizedBox(height: 20),

              Divider(),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Analysis",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              if (reasons.isEmpty)
                Text("No suspicious activity detected")
              else
                ...reasons.map(
                  (r) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 8),
                        SizedBox(width: 8),
                        Expanded(child: Text(r.toString())),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
