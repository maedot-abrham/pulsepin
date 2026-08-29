import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'theme.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PulsePinTheme.background,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('createdAt', descending: true)
            .limit(50)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: PulsePinTheme.primary));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.explore, size: 70, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No pins yet', style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text('Be the first to post! ✨', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          final posts = snapshot.data!.docs;
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: posts.length,
            itemBuilder: (context, index) => _buildPostCard(posts[index]),
          );
        },
      ),
    );
  }

  Widget _buildPostCard(QueryDocumentSnapshot post) {
    final data = post.data() as Map<String, dynamic>;
    final mediaUrl = data['mediaUrl'] ?? '';
    final isVideo = data['isVideo'] ?? false;
    final username = data['username'] ?? 'user';
    final caption = data['caption'] ?? '';
    final likes = data['likes'] ?? 0;
    final saves = data['saves'] ?? 0;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: PulsePinTheme.surface,
      child: Stack(
        fit: StackFit.expand,
        children: [
          isVideo
              ? const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white))
              : Image.network(mediaUrl, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 120,
            child: Column(
              children: [
                _buildActionButton(Icons.favorite, '$likes'),
                const SizedBox(height: 20),
                _buildActionButton(Icons.comment, '89'),
                const SizedBox(height: 20),
                _buildActionButton(Icons.bookmark_add, '$saves'),
                const SizedBox(height: 20),
                _buildActionButton(Icons.share, 'Share'),
              ],
            ),
          ),
          Positioned(
            left: 15,
            bottom: 80,
            right: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('@$username', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                const SizedBox(height: 8),
                Text(caption, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

