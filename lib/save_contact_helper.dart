import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'contact.dart';

class SaveContactHelper {
  // Method to save a contact
  Future<void> saveContact({
    required String name,
    required String email,
    required String phone,
    required String address,
    required DateTime? selectedDate,
    required List<Contact> contactList,
  }) async {
    String date = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate)
        : DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Add the new contact to the list
    contactList.add(Contact(
      name: name,
      email: email,
      phone: phone,
      address: address,
      date: date,
    ));

    // Save the updated list to SharedPreferences
    await _saveContactsToSharedPreferences(contactList);
  }

  // Method to save contacts list to SharedPreferences
  Future<void> _saveContactsToSharedPreferences(List<Contact> contactList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactStrings =
    contactList.map((contact) => jsonEncode(contact.toJson())).toList();
    await prefs.setStringList('contactList', contactStrings);
  }

  // Method to load contacts from SharedPreferences
  Future<List<Contact>> loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? contactStrings = prefs.getStringList('contactList');

    if (contactStrings != null) {
      return contactStrings
          .map((contactString) => Contact.fromJson(jsonDecode(contactString)))
          .toList();
    } else {
      return [];
    }
  }
}

