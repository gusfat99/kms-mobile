import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FeedbackPanelWidget extends StatelessWidget {
  final int like;
  final int dislike;
  final int comment;
  final Function(String) onPressedFeedback;

  const FeedbackPanelWidget(
      {super.key,
      required this.like,
      required this.dislike,
      required this.comment,
      required this.onPressedFeedback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 49,
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
                onPressedFeedback('like');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.transparent, // Jarak di sekitar konten tombol
              ),
              child: Column(
                children: [
                  const Icon(Icons.thumb_up, color: Colors.black, size: 18),
                  const SizedBox(height: 4), // Spasi antara ikon dan teks
                  Text('$like', style: secondaryTextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 49,
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
                onPressedFeedback('dislike');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.transparent, // Jarak di sekitar konten tombol
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.thumb_down, color: Colors.black, size: 18),
                  const SizedBox(height: 4), // Spasi antara ikon dan teks
                  Text('$dislike',
                      style: secondaryTextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
                onPressedFeedback('doc');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.transparent, // Jarak di sekitar konten tombol
              ),
              child: Column(
                children: [
                  const Icon(Icons.attach_file, color: Colors.black, size: 18),
                  const SizedBox(height: 4), // Spasi antara ikon dan teks
                  Text('Dokumen',
                      style: secondaryTextStyle(color: Colors.black, size: 12)),
                ],
              ),
            ),
          ),
          // const SizedBox(
          //     height: 30, child: VerticalDivider(color: Colors.black)),

          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
                onPressedFeedback('comment');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.transparent, // Jarak di sekitar konten tombol
              ),
              child: Column(
                children: [
                  const Icon(Icons.chat, color: Colors.black, size: 18),
                  const SizedBox(height: 4), // Spasi antara ikon dan teks
                  Text('$comment Diskusi',
                      style: secondaryTextStyle(color: Colors.black, size: 12)),
                ],
              ),
            ),
          ),
        ],
      ).paddingOnly(left: 16, right: 16),
    );
  }
}
