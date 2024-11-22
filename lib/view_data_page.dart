import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'contact.dart'; // Ensure Contact class is imported

class ViewDataPage extends StatefulWidget {
  const ViewDataPage({super.key});

  @override
  State<ViewDataPage> createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  List<Contact> contactList = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Data List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 34,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: contactList.isEmpty
          ? const Center(
              child: Text(
                'No Data Available',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10, // Adds a shadow for the 3D effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  margin:
                      const EdgeInsets.all(10), // Adds margin around the card
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent, // Set background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5), // Shadow color
                          offset: const Offset(0, 4), // Shadow position
                          blurRadius: 8, // Shadow blur radius
                        ),
                      ],
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            index % 2 == 0 ? Colors.pinkAccent : Colors.cyan ,
                        foregroundColor: Colors.white,
                        child: Text(
                          contactList[index]
                              .name[0], // First letter of the name
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contactList[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            contactList[index].email,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            contactList[index].phone,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            contactList[index].address,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text('Date: ${contactList[index].date}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            contactList.removeAt(index); // Remove contact
                          });
                          _saveContactsToSharedPreferences();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Load the contact list from SharedPreferences
  Future<void> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? contactStrings = prefs.getStringList('contactList');
    if (contactStrings != null) {
      setState(() {
        contactList = contactStrings
            .map((contactString) => Contact.fromJson(jsonDecode(contactString)))
            .toList();
      });
    }
  }

  // Save the updated contact list to SharedPreferences
  Future<void> _saveContactsToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactStrings =
        contactList.map((contact) => jsonEncode(contact.toJson())).toList();
    await prefs.setStringList('contactList', contactStrings);
  }
}
