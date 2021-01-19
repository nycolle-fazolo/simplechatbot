import 'package:flutter/material.dart';

class ContainerAvatar extends StatelessWidget{
  final String iconImage;

  ContainerAvatar(this.iconImage);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40,
      width: 40,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(iconImage),
        //backgroundImage: AssetImage("assets/robot-icon.jpg"),
      ),
    );
    //throw UnimplementedError();
  }

}