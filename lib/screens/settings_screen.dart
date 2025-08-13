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
  final SPHelper helper = SPHelper();

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
          saveSettings().then((value) {
            String message = value
                ? "Successfully saved"
                : "Error: Not able to save";
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 3),
              ),
            );
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<bool> saveSettings() async {
    return await helper.setSettings(txtName.text, _selectedImage);
  }

  Future<void> getSettings() async {
    Map<String, String> settings = await helper.getSettings();

    final String loadedImage = settings['image'] ?? 'Beach';

    setState(() {
      _selectedImage = _images.contains(loadedImage)
          ? loadedImage
          : 'Beach'; // This is to safeguard against null values or invalid values.
      if (_selectedImage == '') _selectedImage = 'Beach';
      txtName.text = settings['name'] ?? '';
    });
  }

  @override
  void dispose() {
    txtName.dispose();
    super.dispose();
  }
}
