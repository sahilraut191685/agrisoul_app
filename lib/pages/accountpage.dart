import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("👤 Personal Account"),
        backgroundColor: Colors.green.shade900,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Profile header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green.shade100,
                    child: const Text("👨‍🌾", style: TextStyle(fontSize: 50)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Sahil Raut",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const Text(
                    "sahilraut200619@gmail.com",
                    style: TextStyle(color: Colors.brown, fontSize: 18),
                  ),
                  const Text(
                    "+91 8188805265",
                    style: TextStyle(color: Colors.brown, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Farm info card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              shadowColor: Colors.green.shade200,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("🌾 Farm Details",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.green),
                      title: Text("Location"),
                      subtitle: Text("Pune, Maharashtra"),
                    ),
                    ListTile(
                      leading: Icon(Icons.male_outlined, color: Colors.green),
                      title: Text("Gender"),
                      subtitle: Text("Male"),
                    ),
                    ListTile(
                      leading: Icon(Icons.hourglass_bottom, color: Colors.green),
                      title: Text("Age"),
                      subtitle: Text("19"),
                    ),
                    ListTile(
                      leading: Icon(Icons.agriculture, color: Colors.green),
                      title: Text("Crop Type"),
                      subtitle: Text("Wheat"),
                    ),
                    ListTile(
                      leading: Icon(Icons.terrain, color: Colors.green),
                      title: Text("Farm Size"),
                      subtitle: Text("5 Acres"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Settings / Edit button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text("Edit Profile",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Edit profile coming soon...")),
                );
              },
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green.shade700),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: Icon(Icons.logout, color: Colors.green.shade900),
              label: const Text("Logout",
                  style: TextStyle(fontSize: 16, color: Colors.green)),
              onPressed: () {
                Navigator.pop(context); // back to login
              },
            ),
          ],
        ),
      ),
    );
  }
}
