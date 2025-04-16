import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'providers.dart';

void main() {
  runApp(ProviderScope(child: MyApp())); // Wrap the app with ProviderScope
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

class SplashScreen extends ConsumerStatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
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
           ref.read(splashStateProvider.notifier).state = false; 
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSplashVisible = ref.watch(splashStateProvider); 

    if (!isSplashVisible) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DiwaliHomePage()),
        );
      });
    }

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

class DiwaliHomePage extends StatefulWidget {
  @override
  _DiwaliHomePageState createState() => _DiwaliHomePageState();
}

class _DiwaliHomePageState extends State<DiwaliHomePage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> categories = [
    {"title": "T-Shirts", "discount": "40-80% OFF", "image": "images/tshirts.jpg"},
    {"title": "Sports Shoes", "discount": "60-80% OFF", "image": "images/sports_shoes.jpg"},
    {"title": "Shirts", "discount": "50-80% OFF", "image": "images/shirts.jpg"},
    {"title": "Jeans", "discount": "40-80% OFF", "image": "images/jeans.jpg"},
    {"title": "Track Pants", "discount": "50-80% OFF", "image": "images/track_pants.jpg"},
    {"title": "Belts & Wallets", "discount": "50-80% OFF", "image": "images/belts_wallets.jpg"},
    {"title": "Sunglasses", "discount": "40-80% OFF", "image": "images/sunglasses.jpg"},
    {"title": "Perfumes", "discount": "30-70% OFF", "image": "images/perfumes.jpg"},
    {"title": "Watches", "discount": "35-75% OFF", "image": "images/watches.jpg"},
  ];

  // Initialize filteredCategories to an empty list
  List<Map<String, String>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(categories); // Initially show all categories
    _searchController.addListener(() {
      filterCategories();
    });
  }

  void filterCategories() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredCategories = categories
          .where((category) => category["title"]!.toLowerCase().contains(query))
          .toList();
    });
  }

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
                _buildTab("MEN"),
                SizedBox(width: 12),
                _buildTab("WOMEN"),
                SizedBox(width: 12),
                _buildTab("HOME"),
                SizedBox(width: 12),
                _buildTab("BEAUTY"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () => print("Search tapped"),
                ),
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black),
                  onPressed: () => print("Bell tapped"),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () => print("Wishlist tapped"),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
                  onPressed: () => print("Bag tapped"),
                ),
                IconButton(
                  icon: Icon(Icons.person_outline, color: Colors.black),
                  onPressed: () => print("Profile tapped"),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  filterCategories();
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search for products...',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),

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
                itemCount: filteredCategories.length,
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
                              filteredCategories[index]["image"]!,
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
                              Text(filteredCategories[index]["title"]!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Text(filteredCategories[index]["discount"]!, style: TextStyle(fontSize: 12, color: Colors.blue)),
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

  Widget _buildTab(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(color: Colors.black)),
    );
  }
}















