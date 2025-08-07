import 'package:flutter/material.dart';
import 'package:airplane_prac/data/sp_helper.dart';

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
  void initState() {
    super.initState();
    getSettings();
  }

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
                setState(() {
                  _selectedImage = newvalue ?? 'Beach';
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveSettings();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future saveSettings() async {
    final SPHelper helper = SPHelper();
    await helper.setSettings(txtName.text, _selectedImage);
  }

  Future<void> getSettings() async {
    final SPHelper helper = SPHelper();
    Map<String, String> settings = await helper.getSettings();
    _selectedImage = settings['image'] ?? 'Beach';
    txtName.text = settings['name'] ?? '';
    setState(() {});
  }
}
