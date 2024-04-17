import 'package:chatapp/theme/theme_provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySettings extends StatelessWidget {
  const MySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("Settings"), backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,),

      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("D A R K M O D E",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
            

            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode , 
            onChanged: (value) => Provider.of<ThemeProvider>(context,listen: false).toggletheme(),
            )
          ],
        ),
      ),
    );
  }
}