import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'guide_selection_page.dart';

class GuidePage extends StatelessWidget {
  final String tourId;

  const GuidePage({Key? key, required this.tourId}) : super(key: key); // Added const and key parameter

  @override
  Widget build(BuildContext context) {
    final CollectionReference guides = FirebaseFirestore.instance.collection('guides');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Guide'), // Added const
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: guides.where('tourId', isEqualTo: tourId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator()); // Added const
          }
          final guidesList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: guidesList.length,
            itemBuilder: (context, index) {
              var guide = guidesList[index];
              return ListTile(
                title: Text(guide['name']),
                subtitle: Text(guide['bio']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideSelectionPage(guideId: guide.id)),
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
