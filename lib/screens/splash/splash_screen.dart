import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                //width: size.width * 0.65,
                child: Image(
                  image: AssetImage("assets/images/aacll80.png"),
                  color: Color(0x99111111),
                ),
              ),
              //SizedBox(height: size.height * 0.15),
              Container(
                child: Center(
                  child: SpinKitCircle(
                    duration: Duration(seconds: 2),
                    color: Color(0x99111111),
                    size: 80.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
