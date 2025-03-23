import 'package:flutter/material.dart';

class TwoButtonRow extends StatefulWidget {
  @override
  _TwoButtonRowState createState() => _TwoButtonRowState();
}

class _TwoButtonRowState extends State<TwoButtonRow> {
  String selectedButton = ""; // Initially, no button is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Two Button Row")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedButton = "Button1";
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      selectedButton == "Button1" ? Colors.cyan : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.cyan),
                  ),
                ),
                child: Text(
                  "Button 1",
                  style: TextStyle(
                    color: selectedButton == "Button1"
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedButton = "Button2";
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      selectedButton == "Button2" ? Colors.cyan : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.cyan),
                  ),
                ),
                child: Text(
                  "Button 2",
                  style: TextStyle(
                    color: selectedButton == "Button2"
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
