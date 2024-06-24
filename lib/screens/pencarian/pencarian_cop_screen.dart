import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/providers/search_cop_provider.dart';
import 'package:kms_bpkp_mobile/providers/search_provider.dart';
import 'package:kms_bpkp_mobile/screens/cop/components/cop_card_item_vertical.dart';
import 'package:kms_bpkp_mobile/screens/cop/cop_detail_screen.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/components/knowledge_card_item_vertical.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/knowledge_center_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class PencarianCOPScreen extends StatefulWidget {
  const PencarianCOPScreen({super.key, required this.keySearch});
  final String keySearch;
  @override
  State<PencarianCOPScreen> createState() => _PencarianCOPScreenState();
}

class _PencarianCOPScreenState extends State<PencarianCOPScreen> {
  final ScrollController _scrollController = ScrollController();
  final searchController = TextEditingController();
  Future<void> _onRefresh() async {
    context.read<SearchCopProvider>().refresh(searchController.text);
  }

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && context.read<SearchCopProvider>().hasMore) {
      context.read<SearchCopProvider>().fetchSearchValue(widget.keySearch);
    }
  }

  @override
  void initState() {
    context.read<SearchCopProvider>().fetchSearchValue(widget.keySearch);
    super.initState();
    _scrollController.addListener(onScroll);
    searchController.text = widget.keySearch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Consumer<SearchCopProvider>(builder: (_, state, __) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(26)),
                        boxShadow: defaultBoxShadow(
                            shadowColor: grayColorL2,
                            blurRadius: 13,
                            offset: const Offset(0.0, 5.0))),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: white,
                                hintText: "Pencarian COP",
                                contentPadding: const EdgeInsets.only(
                                    left: 26.0, bottom: 8.0, right: 50.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: white, width: 0.5),
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: white, width: 0.5),
                                  borderRadius: BorderRadius.circular(26),
                                ))),
                        GestureDetector(
                          onTap: _onRefresh,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(Icons.search, color: grayColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.copResults.length > 0)
                  ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasMore
                          ? state.copResults.length + 1
                          : state.copResults.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index < state.copResults.length) {
                          return CopCardItemVertical(
                                  state.copResults[index], index)
                              .onTap(() {
                            CopDetailScreen(
                                    data: state.copResults[index])
                                .launch(context);
                          });
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(15),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          );
                        }
                      }),
                Center(
            child: emptyScreen(
                title: 'Pencarian',
                subTitle: 'Data  pencarian tidak ditemukan.',
                image: 'assets/images/empty.png'))
              ],
            ),
          );
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      toolbarHeight: 80.0,
      leading: BackButton(
        color: whiteClr,
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: defaultBoxShadow(
                shadowColor: grayColorL2,
                blurRadius: 13,
                offset: const Offset(0.0, 5.0)),
            image: const DecorationImage(
                image: AssetImage('assets/images/back_header.png'),
                fit: BoxFit.fill)),
      ),
      backgroundColor: whiteColor,
      title: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Pencarian COP",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).expand(),
              // Container(
              //   margin: const EdgeInsets.only(top: 0),
              //   child: IconBtnWithCounter(
              //     svgSrc: "assets/icons/bell2.svg",
              //     numOfitem: "10", //notifCounter,
              //     press: () {
              //       Navigator.pushNamed(context, notificationRoute);
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
