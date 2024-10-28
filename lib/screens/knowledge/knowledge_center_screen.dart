import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kms_bpkp_mobile/apis/request.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_feedback_model.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:kms_bpkp_mobile/screens/cop/api/cop_api.dart';
import 'package:kms_bpkp_mobile/screens/error/error_screen.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/api/knowledge_api.dart';
import 'package:kms_bpkp_mobile/wigets/comment_input.dart';
import 'package:kms_bpkp_mobile/wigets/comment_tile.dart';
import 'package:kms_bpkp_mobile/wigets/feedback_panel_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowledgeCenterScreen extends StatefulWidget {
  final PengetahuanResult data;
  const KnowledgeCenterScreen({super.key, required this.data});

  @override
  State<KnowledgeCenterScreen> createState() => _KnowledgeCenterScreenState();
}

class _KnowledgeCenterScreenState extends State<KnowledgeCenterScreen> {
  int likeCount = 0;
  int dislikeCount = 0;
  int commentCount = 0;
  late PengetahuanResult pengetahuan;
  bool isLoading = true; // Untuk status loading
  String? errorMessage; // Untuk status error
  List<FeedbackModelResult> comments = [];
  TextEditingController commentController = TextEditingController();

  void handleFeedbackActions(
      String actionName, PengetahuanResult pengetahuan) async {
    if (actionName == 'doc') {
      if (pengetahuan.dokumen?[0].url != null) {
        downloadFileFromUrl(
            pengetahuan.dokumen![0].url, pengetahuan.dokumen![0].nama);
      }
    }
    if (actionName == 'like') {
      await KnowledgeService().likePostPengetahuan(widget.data.id);
      await fetchPengetahuanDetail();
    }
    if (actionName == 'dislike') {
      await KnowledgeService().dislikePostPengetahuan(widget.data.id);
      await fetchPengetahuanDetail();
    }
    if (actionName == 'comment') {
      showCommentSheet();
    }
  }

  // Fungsi untuk menambah komentar
  void addComment(String comment, StateSetter modalSetState) async {
    Map payload = {
      "pengetahuan": {"id": widget.data.id},
      "komentar": comment
    };
    var result = await CopService().commentPostCop(
        payload); //ambil fungsi post komentar yyg udh exist di cop

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

  Future<void> fetchPengetahuanDetail() async {
    try {
      var result =
          await KnowledgeService().getPengetahuanDetail(widget.data.id);
      var pengetahuanResult = result.pengetahuanModel.pengetahuanResults;
      var fbResult = result.feedbackModel.results;
      setState(() {
        comments = fbResult;
        likeCount = pengetahuanResult[0].statistik.like;
        dislikeCount = pengetahuanResult[0].statistik.dislike;
        commentCount = pengetahuanResult[0].statistik.komentar;
        pengetahuan = pengetahuanResult[0];
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
    fetchPengetahuanDetail();
  }

  @override
  Widget build(BuildContext context) {
    //RchangeStatusColor(Colors.transparent);
    if (isLoading) {
      return loadingIndicator(context); //Tampilkan screen loading
    }

    if (errorMessage != null) {
      return ErrorScreen(errorMessage!); // Tampilkan error screen
    }
    var w = context.width();
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
              title: Text("Knowledge Center",
                  style: boldTextStyle(color: white, size: 22)),
              flexibleSpace: FlexibleSpaceBar(
                  background: pengetahuan.thumbnail.url != ""
                      ? CachedNetworkImage(
                          placeholder: placeholderWidgetFn() as Widget Function(
                              BuildContext, String)?,
                          imageUrl: pengetahuan.thumbnail.url,
                          fit: BoxFit.fill,
                        )
                      : Image.asset('assets/images/placeholder.png',
                          height: w * 0.4, width: w, fit: BoxFit.cover)),
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
                Text(pengetahuan.judul, style: boldTextStyle(size: 18)),
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
                  data: pengetahuan.ringkasan,
                  onLinkTap: (url, attributes, element) async {
                    await launchUrl(Uri.parse(url!));
                  },
                ),
                const SizedBox(height: 30),
                FeedbackPanelWidget(
                    like: pengetahuan.statistik.like,
                    dislike: pengetahuan.statistik.dislike,
                    comment: pengetahuan.statistik.komentar,
                    onPressedFeedback: (actionName) {
                      handleFeedbackActions(actionName, pengetahuan);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
