import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/loading_screen.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/models/api_feedback_model.dart';
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
  bool isLoading = true; // Untuk status loading
  String? errorMessage; // Untuk status error
  bool showDraggableSheet = false;

  List<FeedbackModelResult> comments = [];
  TextEditingController commentController = TextEditingController();

  void handleFeedbackActions(String actionName) async {
    if (actionName == 'doc') {
      downloadFileFromUrl(
          widget.data.dokumen.url, widget.data.dokumen.filename);
    }
    if (actionName == 'like') {
      await CopService().likePostCop(widget.data.id);
      await fetchFeedbackPanel();
    }
    if (actionName == 'dislike') {
      await CopService().dislikePostCop(widget.data.id);
      await fetchFeedbackPanel();
    }
    if (actionName == 'comment') {
      showCommentSheet();
    }
  }

  // Fungsi untuk menambah komentar
  void addComment(String comment, StateSetter modalSetState) async {
    Map payload = {
      "forum": {"id": widget.data.id},
      "parent_komentar": {"id": widget.data.id},
      "komentar": comment
    };
    var result = (await CopService().commentPostCop(payload));

    if (result != null) {
      setState(() {
        commentCount += 1;
      });
      // Memperbarui state di dalam modal
      modalSetState(() {
        comments.insert(0, result);
      });
    }

    commentController.clear();
  }

  // Fungsi untuk menampilkan Bottom Sheet
  void showCommentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  // decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        controller:
                            scrollController, // Kontrol scroll di BottomSheet
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return commentTile(comment);
                        },
                      )),
                      const Divider(),
                      commentInputField(commentController, (text) {
                        addComment(text, setState);
                      }),
                    ],
                  ),
                );
              },
            );
          },
        );
      }, // Untuk memperluas height BottomSheet
    );
  }

  Future<void> fetchFeedbackPanel() async {
    try {
      var result = await CopService().getFeedbackPanelCop(widget.data.id);

      setState(() {
        comments = result.komentar.results;
        likeCount = result.like.count;
        dislikeCount = result.dislike.count;
        commentCount = result.komentar.count;
        isLoading = false; // Matikan loading setelah data diterima
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString(); // Tangani error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFeedbackPanel();
  }

  @override
  Widget build(BuildContext context) {
    //RchangeStatusColor(Colors.transparent);
    if (isLoading) {
      return LoadingScreen(); // Tampilkan screen loading
    }

    if (errorMessage != null) {
      return ErrorScreen(errorMessage!); // Tampilkan error screen
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
  }
}
