import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tour_selection_page.dart';

class ToursPage extends StatelessWidget {
  const ToursPage({Key? key}) : super(key: key); // Added const and key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tours'), // Added const
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tours').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator()); // Added const
          }
          final toursList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: toursList.length,
            itemBuilder: (context, index) {
              var tour = toursList[index];
              return ListTile(
                title: Text(tour['name']),
                subtitle: Text(tour['description']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TourSelectionPage(tourId: tour.id)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
