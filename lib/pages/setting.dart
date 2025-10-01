import 'package:flutter/material.dart';

class AgriSettingsPage extends StatefulWidget {
  @override
  _AgriSettingsPageState createState() => _AgriSettingsPageState();
}

class _AgriSettingsPageState extends State<AgriSettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        title: Text(
          "Agri Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Profile Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(Icons.person, color: Colors.green.shade800),
              ),
              title: Text("Farmer Account", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Privacy, security, and account info"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green.shade600, size: 18),
              onTap: () {},
            ),
          ),
          SizedBox(height: 16),

          // Dark Mode
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: SwitchListTile(
              secondary: Icon(Icons.dark_mode, color: Colors.green.shade800),
              title: Text("Dark Mode"),
              value: _darkMode,
              onChanged: (val) {
                setState(() => _darkMode = val);
              },
            ),
          ),
          SizedBox(height: 12),

          // Notifications
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: SwitchListTile(
              secondary: Icon(Icons.notifications, color: Colors.green.shade800),
              title: Text("Notifications"),
              value: _notifications,
              onChanged: (val) {
                setState(() => _notifications = val);
              },
            ),
          ),
          SizedBox(height: 12),

          // Language
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.language, color: Colors.green.shade800),
              title: Text("Language"),
              subtitle: Text("English"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green.shade600, size: 18),
              onTap: () {
                 showAboutDialog(
                  context: context,
                  applicationName: "LANGUAGE",
                  applicationIcon: Icon(Icons.language,color: Colors.green,),
                  children: [Text("The feature will be available soon")]
                  ); 
              },
            ),
          ),
          SizedBox(height: 12),
          //change password
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.password, color: Colors.green.shade800),
              title: Text("Change Password"),
              subtitle: Text("Change the password here"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green.shade600, size: 18),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Change Password",
                  applicationIcon: Icon(Icons.password,color: Colors.green,),
                  children: [Text("The PASSWORD cannot be changed")]
                  );
              },
            ),
          ),
          SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.policy, color: Colors.green.shade800),
              title: Text("Private Policy"),
              onTap: (){
                showAboutDialog(
                  context: context,
                  applicationName: "Private Policy",
                  applicationIcon: Icon(Icons.private_connectivity,color: Colors.green,),
                  children: [Text("We respect your privacy and only collect information necessary to provide and improve our services. Your data is never shared or sold to third parties.")],
                );
              },
              
              
            ),
          ),
          SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.data_saver_on_outlined, color: Colors.green.shade800),
              title: Text("Data"),
              onTap: (){
                showAboutDialog(
                  context: context,
                  applicationName: "AgriSoul",
                  applicationIcon:Icon(Icons.agriculture, color: Colors.green),
                  children: [Text("No data found")],
                );
              },
            ),
          ),
          SizedBox(height: 12),
          // About Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.green.shade800),
              title: Text("About AgriApp"),
              subtitle: Text("Version 1.0.0"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "AgriSoul",
                  applicationVersion: "1.0.0",
                  applicationIcon: Icon(Icons.agriculture, color: Colors.green),
                  children: [Text("An app made for farmers 🌱")],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
