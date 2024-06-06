import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qrcodescanner/qr_scanner.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void startApp() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => QRScanner()));
    });
  }

  @override
  Widget build(BuildContext context) {
    startApp();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 300,
              ),
              Image.asset(
                "images/logo1.png",
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "QR Code Scanner",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              SpinKitCubeGrid(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}
