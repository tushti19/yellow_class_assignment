import 'package:flutter/material.dart';

showLoadingAndSavingAlertBox(context){
  showDialog(context: context, builder: (BuildContext context){
    return Container(
      color: Color(0xFF2d5287),
      child: AlertDialog(
        content: Column(
          children: [
            Text('Saving' ,style: TextStyle(color: Colors.white),),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  });
}