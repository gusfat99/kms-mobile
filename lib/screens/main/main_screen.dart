import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/screens/akun/akun_screen.dart';
import 'package:kms_bpkp_mobile/screens/berbagi/berbagi_screen.dart';
import 'package:kms_bpkp_mobile/screens/cop/cop_screen.dart';
import 'package:kms_bpkp_mobile/screens/home/home_screen.dart';
import 'package:kms_bpkp_mobile/screens/knowledge/knowledge_screen.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:nb_utils/nb_utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String notifCounter = '0';
  int currentTab = 0;
  late Widget currentScreen;
  final PageStorageBucket bucket = PageStorageBucket();

  String menuHome = "Home";
  String menuKnowledge = "Knowledge";
  String menuBerbagi = "Berbagi";
  String menuCOP = "C.O.P";
  String menuAkun = "Akun";
  @override
  void initState() {
    super.initState();
    currentScreen =
        HomeScreen(goToKnowledge: goToKnowledgeScreen, goToCOP: goToCOPScreen);
  }

  void goToKnowledgeScreen() {
    setState(() {
      currentScreen = const KnowledgeScreen();
      currentTab = 1;
    });
  }

  void goToCOPScreen() {
    setState(() {
      currentScreen = const CopScreen();
      currentTab = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfiguration().init(context);
    return Scaffold(
        body: PageStorage(bucket: bucket, child: currentScreen),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  color: whiteColor,
                  notchMargin: 6.0,
                  child: SizedBox(
                      height: getProportionateScreenHeight(75),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          menuBottom(
                              0,
                              HomeScreen(
                                  goToKnowledge: goToKnowledgeScreen,
                                  goToCOP: goToCOPScreen),
                              Icons.grid_view_outlined,
                              menuHome),
                          menuBottom(1, const KnowledgeScreen(),
                              Icons.local_library_outlined, menuKnowledge),
                          menuBottom(2, const BerbagiScreen(),
                              Icons.note_add_outlined, menuBerbagi),
                          menuBottom(3, const CopScreen(), Icons.feed_outlined,
                              menuCOP),
                          menuBottom(4, const AkunScreen(),
                              Icons.person_2_outlined, menuAkun),
                          SizedBox(
                            width: getProportionateScreenWidth(1),
                          ),
                        ],
                      )))),
        ));
  }

  MaterialButton menuBottom(index_, currentScreen_, icon_, menuAkun_) {
    return MaterialButton(
      minWidth: getProportionateScreenWidth(50),
      onPressed: () {
        setState(() {
          currentScreen = currentScreen_;
          currentTab = index_;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon_,
            color: currentTab == index_ ? mainColor : grayColor,
          ),
          Text(
            menuAkun_,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(10),
              color: currentTab == index_ ? mainColor : grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
