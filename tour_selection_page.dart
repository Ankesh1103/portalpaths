import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class TourSelectionPage extends StatelessWidget {
  final String tourId;

  const TourSelectionPage({Key? key, required this.tourId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Tour'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('tours').doc(tourId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var tour = snapshot.data!;
          var videoUrl = tour['videoUrl'];
          return Column(
            children: [
              Text('Name: ${tour['name']}'),
              Text('Description: ${tour['description']}'),
              // If you don't need the video service, comment out the next line
              VideoPlayerWidget(videoUrl: videoUrl),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TourDetailsPage(tourId: tour.id),
                    ),
                  );
                },
                child: const Text('View Details'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class TourDetailsPage extends StatelessWidget {
  final String tourId;

  const TourDetailsPage({Key? key, required this.tourId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with more detailed tour info as needed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Details'),
      ),
      body: Center(
        child: Text('Details for tour: $tourId'),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Updated to use VideoPlayerController.networkUrl instead of the deprecated network method.
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
