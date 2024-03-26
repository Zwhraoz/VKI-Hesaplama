import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vki_hesaplama/VkiHesaplama.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GirisEkrani(),
    );
  }
}

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VkiHesaplama(title: '',)),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.scale, size: 70, color: Color.fromARGB(255, 31, 245, 56)),
            SizedBox(height: 20,),
            Text("VKİ HESAPLAMA" , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white , fontSize: 30),),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}