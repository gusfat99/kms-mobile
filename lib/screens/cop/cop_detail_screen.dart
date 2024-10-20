import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/loading_screen.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/page_detail_cop_model.dart';
import 'package:kms_bpkp_mobile/screens/cop/api/cop_api.dart';
import 'package:kms_bpkp_mobile/screens/error/error_screen.dart';
import 'package:kms_bpkp_mobile/wigets/comment_input.dart';
import 'package:kms_bpkp_mobile/wigets/comment_tile.dart';
import 'package:kms_bpkp_mobile/wigets/feedback_panel_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CopDetailScreen extends StatefulWidget {
  final CopResult data;
  const CopDetailScreen({super.key, required this.data});

  @override
  State<CopDetailScreen> createState() => _CopDetailScreenState();
}

class _CopDetailScreenState extends State<CopDetailScreen> {
  int likeCount = 0;
  int dislikeCount = 0;
  int commentCount = 0;
  List<Map<String, dynamic>> comments = [];
  TextEditingController commentController = TextEditingController();

  void handleFeedbackActions(String actionName) async {
    if (actionName == 'doc') {
      downloadFileFromUrl(
          widget.data.dokumen.url, widget.data.dokumen.filename);
    }
    if (actionName == 'like') {
      await CopService().likePostCop(widget.data.id);
      setState(() {
        likeCount += 1;
      });
    }
    if (actionName == 'dislike') {
      await CopService().dislikePostCop(widget.data.id);
      setState(() {
        dislikeCount += 1;
      });
    }
    if (actionName == 'comment') {
      showCommentSheet();
    }
  }

  Future<List<Map<String, dynamic>>> fetchComments() async {
    // Simulasi pengambilan komentar dari API
    await Future.delayed(Duration(seconds: 2));
    return [
      {
        "username": "User1",
        "comment": "Great video! Really enjoyed the content.",
        "likes": 5,
        "dislikes": 0,
        "timestamp": "1 day ago",
        "replies": [],
      },
      {
        "username": "User2",
        "comment": "I totally agree with what you said.",
        "likes": 2,
        "dislikes": 1,
        "timestamp": "2 hours ago",
        "replies": [
          {
            "username": "User3",
            "comment": "Thanks for sharing your thoughts!",
            "timestamp": "1 hour ago",
          }
        ],
      }
    ];
  }

  // Fungsi untuk menambah komentar
  void addComment(String comment) {
    setState(() {
      comments.add({
        "username": "CurrentUser",
        "comment": comment,
        "likes": 0,
        "dislikes": 0,
        "timestamp": "Just now",
        "replies": [],
      });
    });
    commentController.clear();
  }

  // Fungsi untuk menampilkan Bottom Sheet
  void showCommentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Untuk memperluas height BottomSheet
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
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
                              return commentTile(comment);
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  const Divider(),
                  commentInputField(commentController, (text) {
                    addComment(text);
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //RchangeStatusColor(Colors.transparent);
    return FutureBuilder<PageDetailCopModel>(
        future: CopService().getFeedbackPanelCop(widget.data.id),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            likeCount = snapshot.data?.like.count ?? 0;
            dislikeCount = snapshot.data?.dislike.count ?? 0;
            commentCount = snapshot.data?.komentar.count ?? 0;

            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      titleSpacing: 0,
                      backgroundColor: mainColor,
                      actionsIconTheme: const IconThemeData(opacity: 0.0),
                      leading: IconButton(
                          icon: const Icon(Icons.arrow_back, color: white),
                          onPressed: () {
                            finish(context);
                          }),
                      centerTitle: false,
                      title: Text("Forum COP",
                          style: boldTextStyle(color: white, size: 22)),
                      flexibleSpace: FlexibleSpaceBar(
                          background: CachedNetworkImage(
                        placeholder: placeholderWidgetFn() as Widget Function(
                            BuildContext, String)?,
                        imageUrl: widget.data.gambar.url,
                        fit: BoxFit.fill,
                      )),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Text(widget.data.judul, style: boldTextStyle(size: 18)),
                        const SizedBox(height: 16),
                        Html(
                          style: {
                            "body": Style(
                                fontSize: FontSize(14.0),
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.justify,
                                color: Colors.black87,
                                margin: Margins.all(0)),
                          },
                          data: widget.data.deskripsi,
                          onLinkTap: (url, attributes, element) async {
                            await launchUrl(Uri.parse(url!));
                          },
                        ),
                        const SizedBox(height: 30),
                        FeedbackPanelWidget(
                          like: likeCount,
                          dislike: dislikeCount,
                          comment: commentCount,
                          onPressedFeedback: handleFeedbackActions,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorScreen(snapshot.toString());
          }
          return LoadingScreen();
        });
  }
}
