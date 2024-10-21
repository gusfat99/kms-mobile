import 'package:flutter/material.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({super.key});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  @override
  Widget build(BuildContext context) {
    
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: fetchComments(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error loading comments"));
                        } else if (snapshot.hasData) {
                          comments = snapshot.data!;
                          return ListView.builder(
                            controller:
                                scrollController, // Kontrol scroll di BottomSheet
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return _buildCommentTile(comment);
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  Divider(),
                  _buildCommentInputField(),
                ],
              ),
            );
          },
        );
     
}
