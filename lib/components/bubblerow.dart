import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class BubbleRow extends StatelessWidget{
  final Color textColor;
  final Color rowColor;
  final String message;

  const BubbleRow(this.textColor, this.rowColor, this.message);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Bubble(
        radius: Radius.circular(15.0),
        color: rowColor,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
            ],
          ),
        ));
    //throw UnimplementedError();
  }

}