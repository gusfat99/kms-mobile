import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/apis/shared.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/routes.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/menu.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 90.0,
        backgroundColor: whiteColor,
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).expand(),
                // Container(
                //   margin: const EdgeInsets.only(top: 0),
                //   child: IconBtnWithCounter(
                //     svgSrc: "assets/icons/bell.svg",
                //     numOfitem: "10", //notifCounter,
                //     press: () {
                //       Navigator.pushNamed(context, notificationRoute);
                //     },
                //   ),
                // ),
              ],
            ),
            10.height,
          ],
        ),
      ),
      body: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder<User>(
            future: getProfileShared(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                User? userProfile = snapshot.data;
                return Column(
                  children: <Widget>[
                    Info(
                      image: userProfile!.foto.url != ""
                          ? userProfile.foto.url
                          : "",
                      placeholder: "assets/images/avatar_male.png",
                      name: userProfile.namaLengkap,
                      email: userProfile.jabatan,
                    ),
                    20.height,
                    ProfileMenuItem(
                      icon: const Icon(Icons.person_outline, color: mainColor),
                      title: "Pengaturan Profil",
                      press: () {
                        Navigator.pushNamed(context, pengaturanProfileRoute);
                      },
                    ),
                    ProfileMenuItem(
                      icon: const Icon(Icons.file_present_outlined,
                          color: mainColor),
                      title: "Dokumen",
                      press: () {
                        Navigator.pushNamed(context, dokumenRoute);
                      },
                    ),
                    ProfileMenuItem(
                      icon: const Icon(Icons.settings, color: mainColor),
                      title: "Ubah Kata Sandi",
                      press: () {
                        Navigator.pushNamed(context, ubahSandiRoute);
                      },
                    ),
                    ProfileMenuItem(
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: mainColor,
                      ),
                      title: "Keluar",
                      press: () {
                        doLogout(context);
                      },
                    ),
                  ],
                );
              }
              return loadingIndicator(context);
            }));
  }

  void doLogout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Keluar", style: boldTextStyle(color: Colors.black)),
          content: Text(
            "Apakah anda yakin ingin keluar dari aplikasi?",
            style: secondaryTextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              child:
                  Text("Batal", style: primaryTextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Keluar",
                style: primaryTextStyle(color: mainColor),
              ),
              onPressed: () {
                logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', false);
    prefs.clear();
    finish(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(signinRoute, (Route<dynamic> route) => false);
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.name,
    required this.email,
    required this.image,
    required this.placeholder,
  });
  final String name, email, image, placeholder;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfiguration.defaultSize;
    return SizedBox(
      height: defaultSize * 25, // 210
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                image != ""
                    ? CachedNetworkImage(
                        imageUrl: image,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.only(bottom: defaultSize), //10
                          height: defaultSize * 14, //140
                          width: defaultSize * 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: defaultSize * 0.8, //8
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          margin: EdgeInsets.only(bottom: defaultSize), //10
                          height: defaultSize * 14, //140
                          width: defaultSize * 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: defaultSize * 0.8, //8
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(placeholder),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          margin: EdgeInsets.only(bottom: defaultSize), //10
                          height: defaultSize * 14, //140
                          width: defaultSize * 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: defaultSize * 0.8, //8
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(placeholder),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: defaultSize), //10
                        height: defaultSize * 14, //140
                        width: defaultSize * 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: defaultSize * 0.8, //8
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(placeholder),
                          ),
                        ),
                      ),

                Text(
                  name,
                  style: TextStyle(
                    fontSize: defaultSize * 2.2, // 22
                    color: textColor,
                  ),
                ),
                SizedBox(height: defaultSize / 2), //5
                Text(
                  email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
                SizedBox(height: defaultSize / 2), //5
              ],
            ),
          )
        ],
      ),
    );
  }
}
