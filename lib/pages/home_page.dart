import 'package:flutter/material.dart';
// import the real settings page
import 'setting.dart';
// import the real account page
import 'accountpage.dart';

// Dummy Market Prices page
class MarketPricesPage extends StatelessWidget {
  const MarketPricesPage({super.key});
  @override
  Widget build(BuildContext context) => _dummyPage("📈 Market Prices Page");
}

// Dummy Weather page
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});
  @override
  Widget build(BuildContext context) => _dummyPage(
    "☁ Weather Forecasting is not available till now. Will fix in further update",
  );
}

// VideosPage now contains the full video list
class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  final List<Map<String, String>> videos = const [
    {"title": "Planting Seeds 101", "thumbnail": "🌱", "duration": "10:23"},
    {"title": "Fertilizer Guide", "thumbnail": "💚", "duration": "8:45"},
    {"title": "Irrigation Techniques", "thumbnail": "💧", "duration": "12:10"},
    {"title": "Pest Control Tips", "thumbnail": "🐛", "duration": "7:50"},
    {"title": "Harvesting Methods", "thumbnail": "🌾", "duration": "15:00"},
    {"title": "Soil Preparation Tips", "thumbnail": "🌿", "duration": "9:30"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎥 Video Tutorials"),
        backgroundColor: Colors.green.shade900,
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
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Playing ${video["title"]}")),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// Dummy page builder (for placeholder pages)
Widget _dummyPage(String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title), backgroundColor: Colors.green.shade900),
    body: Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

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
            Expanded(
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
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 15,
                ),
              ),
              onPressed: _addExpense,
              child: const Icon(Icons.add),
            ),
          ],
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
                        const MarketPricesPage(),
                      ),
                      _agriFeatureBox(
                        context,
                        Icons.cloud,
                        "Weather",
                        const WeatherPage(),
                      ),
                      _agriFeatureBox(
                        context,
                        Icons.attach_money,
                        "Expense Tracker",
                        const Scaffold(
                          body: Padding(
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
                padding: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade50,
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
                      color: Colors.green,
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
