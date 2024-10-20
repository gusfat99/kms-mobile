import 'package:flutter/material.dart';

// Widget untuk menampilkan tile komentar
Widget commentTile(Map<String, dynamic> comment) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Icon(Icons.person),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment['username'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(comment['timestamp'],
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  Text(comment['comment']),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {},
                      ),
                      Text("${comment['likes']}"),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.thumb_down),
                        onPressed: () {},
                      ),
                      Text("${comment['dislikes']}"),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text("Reply"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (comment['replies'].isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              children: List.generate(comment['replies'].length, (index) {
                final reply = comment['replies'][index];
                return replyTile(reply);
              }),
            ),
          ),
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
