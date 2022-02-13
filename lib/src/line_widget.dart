import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget{
 final double x;
 final double y;

  const LineWidget({Key? key,required this.x,required this.y}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Positioned(child: Row(children: [
     Expanded(child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Container(
           width: double.infinity,
           height: 1,
           color: Colors.white,
         ),
         Container(
           width: double.infinity,
           height: 1,
           color: Colors.white,
         )
       ],
     )),

     Expanded(child: Container(
       width: 1,
       color: Colors.white,
       height: double.infinity,
     ))
   ],),
   left: x,
     top: y,
   );
  }
}