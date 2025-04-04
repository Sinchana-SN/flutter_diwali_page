import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

defaultImagePath(String imageName) => "images/$imageName";


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Diwali Celebrations",
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double rocket1Y = 1.2;
  double rocket2Y = 1.4;
  double rocket3Y = 1.6;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        rocket1Y -= 0.3;
        rocket2Y -= 0.4;
        rocket3Y -= 0.5;
      });

      if (rocket1Y < -0.5) {
        timer.cancel();
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DiwaliHomePage()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset('images/background.jpg', fit: BoxFit.cover),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: rocket1Y * MediaQuery.of(context).size.height,
            left: MediaQuery.of(context).size.width * 0.2,
            child: Text("🚀", style: TextStyle(fontSize: 80)),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: rocket2Y * MediaQuery.of(context).size.height,
            left: MediaQuery.of(context).size.width * 0.5,
            child: Text("🚀", style: TextStyle(fontSize: 100)),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: rocket3Y * MediaQuery.of(context).size.height,
            left: MediaQuery.of(context).size.width * 0.8,
            child: Text("🚀", style: TextStyle(fontSize: 120)),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            right: 16,
            child: Text(
              "🎆 Happy Diwali! 🎆",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                fontFamily: 'ALGERIAN',
                color: Colors.black,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(blurRadius: 12, color: Colors.grey, offset: Offset(3, 3)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiwaliHomePage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"title": "T-Shirts", "discount": "40-80% OFF", "image": defaultImagePath("tshirts.jpg")},
    {"title": "Sports Shoes", "discount": "40-80% OFF", "image": defaultImagePath("sports_shoes.jpg")},
    {"title": "Shirts", "discount": "40-80% OFF", "image": defaultImagePath("shirts.jpg")},
    {"title": "Jeans", "discount": "40-80% OFF", "image": defaultImagePath("jeans.jpg")},
    {"title": "Track Pants", "discount": "50-80% OFF", "image": defaultImagePath("track_pants.jpg")},
    {"title": "Belts & Wallets", "discount": "50-80% OFF", "image": defaultImagePath("belts_wallets.jpg")},
    {"title": "Sunglasses", "discount": "40-80% OFF", "image": defaultImagePath("sunglasses.jpg")},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print("MEN clicked");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("MEN", style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    print("WOMEN clicked");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("WOMEN", style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    print("HOME clicked");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("HOME", style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    print("BEAUTY clicked");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("BEAUTY", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
            Icon(Icons.person, color: Colors.black),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Shop By Category",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              categories[index]["image"]!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(categories[index]["title"]!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Text(categories[index]["discount"]!, style: TextStyle(fontSize: 12, color: Colors.blue)),
                              Text("Shop Now", style: TextStyle(fontSize: 12, color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}












