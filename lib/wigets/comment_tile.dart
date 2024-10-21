import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/helpers/date_converter.dart';
import 'package:kms_bpkp_mobile/models/api_feedback_model.dart';

// Widget untuk menampilkan tile komentar
Widget commentTile(FeedbackModelResult comment) {
  String? photoUrl = comment.user.foto.url;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                  ? NetworkImage(photoUrl) // Jika ada URL foto
                  : null, // Jika tidak ada, tampilkan child
              child: (photoUrl == null || photoUrl.isEmpty)
                  ? const Icon(
                      Icons.person) // Jika tidak ada foto, gunakan Icon default
                  : null, // Jika ada foto, child dihilangkan
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.user.namaLengkap,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(timeAgoOrDate(DateTime.parse(comment.createdAt)),
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(comment.komentar ?? ''),
                ],
              ),
            ),
          ],
        ),
        // if (comment['replies'].isNotEmpty)
        //   Padding(
        //     padding: const EdgeInsets.only(left: 40.0),
        //     child: Column(
        //       children: List.generate(comment['replies'].length, (index) {
        //         final reply = comment['replies'][index];
        //         return replyTile(reply);
        //       }),
        //     ),
        //   ),
      ],
    ),
  );
}

// Widget untuk menampilkan tile balasan komentar
Widget replyTile(Map<String, dynamic> reply) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Icon(Icons.person),
          radius: 15,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reply['username'],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(reply['timestamp'], style: TextStyle(color: Colors.grey)),
              SizedBox(height: 5),
              Text(reply['comment']),
            ],
          ),
        ),
      ],
    ),
  );
}
