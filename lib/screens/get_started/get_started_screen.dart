import 'package:e_commerce_app/screens/home/shop_home_screen.dart';
import 'package:e_commerce_app/shared/componant/componant.dart';
import 'package:e_commerce_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/unsplash_fouVDmGXoPI.png'), // Replace with your asset image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Dark Gradient Overlay (optional for readability)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            // Text and Button Positioned on the screen
            Positioned(
              bottom: 50.0,
              left: 20.0,
              right: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Center(
                    child: Text(
                      'You want Authentic, here you go!',
                      style: TextStyle(
                        fontSize: 34.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Find it here, buy it now!',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Get Started Button
                  Center(

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopLayout(),
                            ),
                                (Route<dynamic> route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        backgroundColor: MyColors.defaultColor, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}