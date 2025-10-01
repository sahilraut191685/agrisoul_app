import 'package:flutter/material.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  // Sample video data
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              shadowColor: Colors.green.shade200,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green.shade300,
                  child: Text(video["thumbnail"]!, style: const TextStyle(fontSize: 24)),
                ),
                title: Text(
                  video["title"]!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: const Icon(Icons.play_arrow, color: Colors.white),
                ),
                onTap: () {
                  // Add video play logic here
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
