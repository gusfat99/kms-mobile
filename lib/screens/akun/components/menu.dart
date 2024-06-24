import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.press,
  });
  final String title;
  final Icon icon;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfiguration.defaultSize;
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
        width: context.width(),
        height: 70,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: defaultBoxShadow(
                shadowColor: grayColorL2,
                blurRadius: 13,
                offset: const Offset(0.0, 5.0))),
        child: Row(
          children: <Widget>[
            15.width,
            icon,
            SizedBox(width: defaultSize * 2),
            Text(
              title,
              style: TextStyle(
                fontSize: defaultSize * 1.6, //16
                color: textLightColor,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: defaultSize * 2.0,
              color: textLightColor,
            ),
            15.width
          ],
        ),
      ),
    );
  }
}
