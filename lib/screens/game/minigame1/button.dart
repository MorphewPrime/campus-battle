import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final text;
  final function;

  MyButton({this.text, this.function});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onLongPressStart: (_) async {
          isPressed = true;
          do {
            print('long pressing');
            widget.function;
            await Future.delayed(Duration(seconds: 1));
          } while (isPressed);
        },
        onLongPressEnd: (_) => setState(() => isPressed = false),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: widget.function,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.redAccent[200],
              child: Center(
                  child: Text(
                widget.text,
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
