import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final String title;
  HeaderWidget({required this.title, Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromARGB(233, 120, 180, 229),
            fontSize: 30,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        widget.title!,
        style: TextStyle(
            color: Color.fromARGB(233, 120, 180, 229),
            fontSize: 30,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
