import 'package:flutter/material.dart';

class CoffeeHomeScreen extends StatelessWidget {
  const CoffeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF5A3E2B),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [

          Image.asset(
            "assets/images/Union.png",
            fit: BoxFit.cover,
            width: size.width,
            height: 80,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.home, color: Colors.white, size: 28),
                Icon(Icons.shopping_cart_outlined,
                    color: Colors.white, size: 28),
                Icon(Icons.favorite_border, color: Colors.white, size: 28),
                Icon(Icons.person_outline, color: Colors.white, size: 28),
              ],
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage:
                          AssetImage("assets/images/image-60.png"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shahzaib",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600)),
                            Text("Good Morning!",
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.search, color: Colors.white, size: 28),
                        SizedBox(width: 15),
                        Icon(Icons.notifications_none,
                            color: Colors.white, size: 28),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7A571),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Get 20% Discount\nOn your First Order!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Lorem ipsum dolor sit amet consectetur.\nVestibulum eget blandit mattis.",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image(
                        image: AssetImage("assets/images/image13.png"),
                        width: 129,
                        height: 119,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Hot Coffees",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("Ice Teas",
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                    Text("Hot Teas",
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                    Text("Drinks",
                        style: TextStyle(color: Colors.white70, fontSize: 16)),
                  ],
                ),

                const SizedBox(height: 20),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.75,
                  children: [
                    _buildCoffeeCard(
                        "Arabica", "assets/images/image6.png", "\$18", false),
                    _buildCoffeeCard(
                        "Robusta", "assets/images/image8.png", "\$20", true),
                    _buildCoffeeCard(
                        "Excelsa", "assets/images/image _9.png", "\$15", false),
                    _buildCoffeeCard("Liberica", "assets/images/image_10.png",
                        "\$12", false),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoffeeCard(
      String title, String image, String price, bool isFav) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF9C6B3D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Image.asset(image, height: 80),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 6),
          const Text(
            "Lorem ipsum dolor sit\namet cons",
            style: TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(price,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }
}
