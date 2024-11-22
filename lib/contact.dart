class Contact {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String date;

  Contact({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'date': date,
    };
  }

  static Contact fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      date: json['date'],
    );
  }
}
