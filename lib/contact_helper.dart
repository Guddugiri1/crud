// void _saveContact() async {
//   String name = nameController.text.trim();
//   String email = emailController.text.trim();
//   String phone = phoneController.text.trim();
//   String address = addressController.text.trim();
//
//   if (name.isNotEmpty &&
//       email.isNotEmpty &&
//       phone.isNotEmpty &&
//       address.isNotEmpty) {
//     setState(() {
//       nameController.clear();
//       emailController.clear();
//       phoneController.clear();
//       addressController.clear();
//       _saveContactHelper.saveContact(
//         name: name,
//         email: email,
//         phone: phone,
//         address: address,
//         selectedDate: selectedDate,
//         contactList: contactList,
//       );
//       selectedDate = null;
//     });
//   }
// }