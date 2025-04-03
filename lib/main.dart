import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diwali Offers',
      home: SplashScreen(),
    );
  }
}

// 🎇 Splash Screen with Bomb Drop
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bombDrop;
  bool exploded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _bombDrop = Tween<double>(begin: -100, end: 300).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Start explosion after bomb lands
    Timer(Duration(seconds: 2), () {
      setState(() {
        exploded = true;
      });

      // Navigate to offer page after explosion
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OfferPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      body: Stack(
        children: [
          Center(
            child: Text(
              "🎇 Happy Diwali! 🎆",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          AnimatedBuilder(
            animation: _bombDrop,
            builder: (context, child) {
              return Positioned(
                top: _bombDrop.value,
                left: MediaQuery.of(context).size.width / 2 - 30,
                child: exploded ? ExplosionEffect() : BombEmoji(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 💣 Bomb Emoji
class BombEmoji extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "💣",
      style: TextStyle(fontSize: 80), // Big Bomb
    );
  }
}

// 💥 Explosion Effect
class ExplosionEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "💥",
      style: TextStyle(fontSize: 120, fontWeight: FontWeight.bold), // Big Explosion
    );
  }
}

// 🎁 Offer Page
class OfferPage extends StatelessWidget {
  final List<Map<String, dynamic>> diwaliOffers = [
    {"title": "🔥 50% Off on Sweets 🍬", "emoji": "🔥"},
    {"title": "🎇 Buy 1 Get 1 Free on Firecrackers", "emoji": "🎇"},
    {"title": "👗 Flat 30% Off on Clothing", "emoji": "👗"},
    {"title": "💎 Exclusive Gold Jewelry Discount", "emoji": "💎"},
    {"title": "📱 Big Discounts on Electronics", "emoji": "📱"},
    {"title": "🛍️ Special Combo Deals Available", "emoji": "🛍️"},
  ];

  final List<Color> offerColors = [
    Colors.deepPurple,
    Colors.orange,
    Colors.teal,
    Colors.blueAccent,
    Colors.pink,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(title: Text("Special Diwali Offers 🎇"), backgroundColor: Colors.deepPurple),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemCount: diwaliOffers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OfferDetailsPage(diwaliOffers[index]["title"]),
                ),
              );
            },
            child: Card(
              color: offerColors[index % offerColors.length],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlippedEmoji(emoji: diwaliOffers[index]["emoji"]),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      diwaliOffers[index]["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 🔄 Flipped Emoji Widget (Left to Right Flip)
class FlippedEmoji extends StatelessWidget {
  final String emoji;

  FlippedEmoji({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scale(-1.0, 1.0), // Flipping horizontally
      child: Text(
        emoji,
        style: TextStyle(fontSize: 70),
      ),
    );
  }
}

// 🎁 Offer Details Page
class OfferDetailsPage extends StatelessWidget {
  final String offerTitle;

  OfferDetailsPage(this.offerTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Offer Details"), backgroundColor: Colors.deepPurple),
      backgroundColor: Colors.orange.shade50, // Different Background Color
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                offerTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Don't miss out on this special Diwali offer! 🎉",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("🎊 OFFER CLAIMED SUCCESSFULLY! 🎊")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  "🎁 CLAIM OFFER 🎁",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
