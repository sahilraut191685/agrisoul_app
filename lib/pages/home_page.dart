import 'package:flutter/material.dart';
// ⭐️ 1. IMPORT THE URL LAUNCHER PACKAGE
import 'package:url_launcher/url_launcher.dart';

// import the real settings page
import 'setting.dart';
// import the real account page
import 'accountpage.dart';
// import the market price page
import 'package:agrisoul2/pages/livemarket.dart';
// import the real weather page
import 'package:agrisoul2/pages/weatherpage.dart';


// VideosPage now contains the full video list with URLs
class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  // ⭐️ 2. ADD A 'url' FIELD TO YOUR VIDEO DATA
  final List<Map<String, String>> videos = const [
    {
      "title": "Planting Seeds 101",
      "thumbnail": "🌱",
      "duration": "10:23",
      "url": "https://www.youtube.com/watch?v=FW_bw9jdrlQ"
    },
    {
      "title": "Fertilizer Guide",
      "thumbnail": "💚",
      "duration": "8:45",
      "url": "https://www.youtube.com/watch?v=-xkz5pSRA1M"
    },
    {
      "title": "Irrigation Techniques",
      "thumbnail": "💧",
      "duration": "12:10",
      "url": "https://www.youtube.com/watch?v=Vof1GmL2DAQ"
    },
    {
      "title": "Pest Control Tips",
      "thumbnail": "🐛",
      "duration": "7:50",
      "url": "https://www.youtube.com/watch?v=OoShJ76U8II"
    },
    {
      "title": "Harvesting Methods",
      "thumbnail": "🌾",
      "duration": "15:00",
      "url": "https://www.youtube.com/watch?v=YbAcJ1SH0QY"
    },
    {
      "title": "Soil Preparation Tips",
      "thumbnail": "🌿",
      "duration": "9:30",
      "url": "https://www.youtube.com/watch?v=r9p8ilq0sOQ"
    },
  ];

  // ⭐️ 3. ADD THE FUNCTION TO LAUNCH URLS
  // This function will open the link in an external app like YouTube or a browser.
  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Show an error message if the URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Could not open the video.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎥 Video Tutorials"),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.green.shade50,
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              shadowColor: Colors.green.shade200,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green.shade300,
                  child: Text(
                    video["thumbnail"]!,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                title: Text(
                  video["title"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  "Duration: ${video["duration"]}",
                  style: const TextStyle(fontSize: 14, color: Colors.brown),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.white),
                ),
                // ⭐️ 4. CALL THE FUNCTION WHEN THE TILE IS TAPPED
                onTap: () {
                  // Pass the context and the video's URL to the function
                  _launchUrl(context, video["url"]!);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// (The rest of your code: ExpenseTracker and HomePage remains the same)

// Expense Tracker widget
class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});
  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<Map<String, dynamic>> _expenses = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addExpense() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;
    setState(() {
      _expenses.add({
        "title": _titleController.text,
        "amount": double.tryParse(_amountController.text) ?? 0.0,
        "date": DateTime.now(),
      });
    });
    _titleController.clear();
    _amountController.clear();
    FocusScope.of(context).unfocus(); // Close keyboard
  }

  double get totalExpenses =>
      _expenses.fold(0.0, (sum, item) => sum + item["amount"]);

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}, "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade200, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade300.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Expenses",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "₹${totalExpenses.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Expense (Seeds, Fertilizer...)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.green.shade50,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 120, // Give amount field a specific width
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount (₹)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.green.shade50,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
          ),
          onPressed: _addExpense,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text("Add Expense")
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _expenses.isEmpty
              ? const Center(
                  child: Text(
                    "No expenses recorded yet 🌱",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (context, index) {
                    final expense = _expenses[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.shade100,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.agriculture,
                          color: Colors.green,
                        ),
                        title: Text(
                          expense["title"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(formatDate(expense["date"])),
                        trailing: Text(
                          "₹${expense["amount"].toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// Agriculture-themed HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Text(
                "🌾 Farm Dashboard",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _agriFeatureBox(
                        context,
                        Icons.settings,
                        "Settings",
                        AgriSettingsPage(),
                      ), // ✅ real settings
                      _agriFeatureBox(
                        context,
                        Icons.person,
                        "Account",
                        const AccountPage(),
                      ),
                      _agriFeatureBox(
                        context,
                        Icons.show_chart,
                        "Market Prices",
                        MarketPricePage(), // Correctly navigates to the real page
                      ),
                      _agriFeatureBox(
                        context,
                        Icons.cloud,
                        "Weather",
                        const WeatherPage(), // Correctly navigates to your real weather page
                      ),
                      _agriFeatureBox(
                        context,
                        Icons.attach_money,
                        "Expense Tracker",
                        Scaffold(
                          appBar: AppBar(title: const Text("Expense Tracker"), backgroundColor: Colors.green.shade800, foregroundColor: Colors.white,),
                          body: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: ExpenseTracker(),
                          ),
                        ),
                      ),
                      _agriFeatureBox(
                        context,
                        Icons.video_label,
                        "Tutorial Video",
                        const VideosPage(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 10,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "⬅ Back to Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _agriFeatureBox(
    BuildContext context,
    IconData icon,
    String label,
    Widget page,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.green.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.green.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.shade100,
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: Colors.green.shade900),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}