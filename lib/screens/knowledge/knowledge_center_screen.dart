import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_pengetahuan_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowledgeCenterScreen extends StatefulWidget {
  final PengetahuanResult data;
  const KnowledgeCenterScreen({super.key, required this.data});

  @override
  State<KnowledgeCenterScreen> createState() => _KnowledgeCenterScreenState();
}

class _KnowledgeCenterScreenState extends State<KnowledgeCenterScreen> {
  @override
  Widget build(BuildContext context) {
    //RchangeStatusColor(Colors.transparent);
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
                  background: widget.data.thumbnail.url != ""
                      ? CachedNetworkImage(
                          placeholder: placeholderWidgetFn() as Widget Function(
                              BuildContext, String)?,
                          imageUrl: widget.data.thumbnail.url,
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
                  data: widget.data.ringkasan,
                  onLinkTap: (url, attributes, element) async {
                    await launchUrl(Uri.parse(url!));
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.thumb_up,
                              color: Colors.black, size: 18),
                          Text('Like',
                              style: secondaryTextStyle(color: Colors.black)),
                        ],
                      ),
                      const SizedBox(
                          height: 30,
                          child: VerticalDivider(color: Colors.black)),
                      Column(
                        children: [
                          const Icon(Icons.thumb_down,
                              color: Colors.black, size: 18),
                          Text('Dislike',
                              style: secondaryTextStyle(color: Colors.black)),
                        ],
                      ),
                      const SizedBox(
                          height: 30,
                          child: VerticalDivider(color: Colors.black)),
                      Column(
                        children: [
                          const Icon(Icons.attach_file,
                              color: Colors.black, size: 18),
                          Text('File Dokumen',
                              style: secondaryTextStyle(color: Colors.black)),
                        ],
                      ),
                      const SizedBox(
                          height: 30,
                          child: VerticalDivider(color: Colors.black)),
                      Column(
                        children: [
                          const Icon(Icons.chat, color: Colors.black, size: 18),
                          Text('Diskusi',
                              style: secondaryTextStyle(color: Colors.black)),
                        ],
                      ),
                    ],
                  ).paddingOnly(left: 16, right: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}