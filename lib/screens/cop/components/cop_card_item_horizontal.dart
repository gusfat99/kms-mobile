import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/date_converter.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_cop_model.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class CopCardItemHorizontal extends StatelessWidget {
  late CopResult model;

  CopCardItemHorizontal(this.model, int pos, {super.key});

  @override
  Widget build(BuildContext context) {
    var w = context.width();

    return Container(
      margin: const EdgeInsets.only(left: 16),
      width: w * 0.75,
      decoration: boxDecoration(
          radius: 16, showShadow: true, bgColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
                child: CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(
                        BuildContext, String)?,
                    imageUrl: model.gambar.url,
                    height: w * 0.4,
                    width: w * 0.75,
                    fit: BoxFit.cover),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          text: model.createdBy.username != ""
                              ? model.createdBy.username
                              : "null" + ",",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(13),
                            color: mainColor,
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            TextSpan(
                                text: " Diperbarui ${convertDateInfo(model.createdAt)}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: grayColor,
                                  fontWeight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                      text(model.judul, textColor: textColor, maxLine: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}