import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController txtName = TextEditingController();
  final List<String> _images = ['Beach', 'Forest', 'Lake', 'Mountain'];
  String _selectedImage = 'Beach';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: "Enter Your name"),
            ),
            DropdownButton(
              value: _selectedImage,
              // icon: const Icon(Icons.arrow_downward_outlined),
              items: _images.map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (newvalue) {
                _selectedImage = newvalue ?? 'Beach';
              },
            ),
          ],
        ),
      ),
    );
  }
}
