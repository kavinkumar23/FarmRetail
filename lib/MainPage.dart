import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/pages/ItemsPage.dart';
import 'package:login_system/pages/profilePage.dart';
import 'package:login_system/pages/usersPage.dart';
import 'package:login_system/pages/add_product_page.dart';
import 'controllers/auth_controller.dart';
import 'pages/home_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  final AuthController authController = Get.put(AuthController());

  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  String getAppBarTitle() {
    switch (selectedIndex) {
      case 0:
        return 'List of items';
      case 1:
        return 'All users';
      case 2:
        return 'Add products';
      case 3:
        return 'Search';
      case 4:
        return 'My account';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          selectedIndex = 0;
          setState(() {});
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: selectedIndex == 0
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  )),
          centerTitle: true,
          backgroundColor: AppColors.PrimaryColor,
          title: Text(getAppBarTitle()),
          actions: [
            IconButton(
                onPressed: ()  {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Are you sure ?"),
                            content: const Text(
                                "Click Confirm if you want to Log out of the app"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    authController.logOut();
                                  

                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Confirm",
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            HomeScreen(),
            UsersPage(),
            AddProductPage(),
            ItemsPage(),
            MyAccountPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.7),
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          type: BottomNavigationBarType.shifting,
          selectedLabelStyle: GoogleFonts.exo(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
          unselectedLabelStyle: GoogleFonts.exo(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.watch_later_rounded,
                ),
                label: "Users"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_sharp), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Account")
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
