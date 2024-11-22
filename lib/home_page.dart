import 'package:flutter/material.dart';
import 'save_data_page.dart';
import 'view_data_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'To Do List App',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        color: Colors.deepOrange.shade100,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Heading before the buttons
              const Text(
                'Raapyd Employee App !',
                style: TextStyle(
                  fontSize: 47,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontStyle: FontStyle
                      .italic, // Use fontStyle here instead of fontFamily
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Text(
                      'This app allows users to manage a simple to-do list '
                          'by saving their contact information, including name, '
                          'email, phone number, address, and a selected date. Users can add new contacts, '
                          'view all saved data, and easily navigate between pages for adding or viewing information.'
                          ' The app stores data locally using shared preferences for persistence.',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 22
                  ),
                  ),
                ],
              ),

              const SizedBox(height: 300), // Space between heading and buttons

              // Row to align buttons horizontally
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // Equal space between buttons
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SaveDataPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      elevation: 15,
                      shadowColor: Colors.deepOrange.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                    ),
                    child: const Text('Save The Data'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewDataPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      elevation: 15,
                      shadowColor: Colors.deepOrange.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                    ),
                    child: const Text('Show All Data'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
