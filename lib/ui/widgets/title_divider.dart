

import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String title;
  TitleDivider(this.title);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: line()),
        //
        Text(title),
        //
        Expanded(child: line()),
      ],
    );
  }

  Widget line(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(195, 197, 199, 1),
              border: Border.all(
                color: Color.fromRGBO(195, 197, 199, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
    );
  }

}