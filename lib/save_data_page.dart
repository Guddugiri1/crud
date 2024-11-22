import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'contact.dart';
import 'home_page.dart';
import 'save_contact_helper.dart'; // Import the SaveContactHelper class

class SaveDataPage extends StatefulWidget {
  const SaveDataPage({super.key});

  @override
  State<SaveDataPage> createState() => _SaveDataPageState();
}

class _SaveDataPageState extends State<SaveDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime? selectedDate;
  List<Contact> contactList = [];
  final SaveContactHelper _saveContactHelper = SaveContactHelper(); // Create an instance of SaveContactHelper

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 40.0,
          color: Colors.white,
          icon: const Icon(Icons.home_filled),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: const Text(
          'Save All Data',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        color: Colors.deepOrange.shade50,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildTextField('Enter Your Name', nameController),
            _buildTextField('Enter Your Email Id', emailController,
                keyboardType: TextInputType.emailAddress),
            _buildTextField('Enter Your Mobile No', phoneController,
                keyboardType: TextInputType.number, maxLength: 10),
            _buildTextField('Enter Your Address', addressController),
            _buildDatePicker(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {TextInputType? keyboardType, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              selectedDate == null
                  ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}'
                  : 'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2024),
                lastDate: DateTime(2030),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            child: const Text('Select Date'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, foregroundColor: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        _saveContact(); // Calls the method from SaveContactHelper

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Your data has been saved!'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
      },
      child: const Text('Save Data'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 15,
        shadowColor: Colors.deepOrange.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      ),
    );
  }

  void _saveContact() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty) {
      setState(() {
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        addressController.clear();
        _saveContactHelper.saveContact(
          name: name,
          email: email,
          phone: phone,
          address: address,
          selectedDate: selectedDate,
          contactList: contactList,
        );
        selectedDate = null;
      });
    }
  }

  Future<void> _loadContacts() async {
    List<Contact> loadedContacts = await _saveContactHelper.loadContacts();
    setState(() {
      contactList = loadedContacts;
    });
  }
}
