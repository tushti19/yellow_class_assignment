import 'package:flutter/material.dart';

showCancelAlertBox(parentContext){
  showDialog(context: parentContext, builder: (BuildContext context){
    return AlertDialog(
      backgroundColor: Color(0xFF2d5287),
      content: Text('Discard your changes?' ,style: TextStyle(color: Colors.white),),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(parentContext);
        }, child: Text('Okay' , style: TextStyle(color: Colors.white),),),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel' , style: TextStyle(color: Colors.white),),),
      ],
    );
  });
}