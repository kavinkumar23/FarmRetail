// import 'package:flutter/material.dart';
// import 'package:login_system/admin/Login.dart';
// import 'package:login_system/configurations/AppColors.dart';
// import 'package:login_system/models/Authentication.dart';
// import 'package:login_system/pages/ItemsPage.dart';
// import 'package:login_system/pages/MyAccountPage.dart';
// import 'package:login_system/pages/UsersPage.dart';
// import 'package:login_system/pages/add_product_page.dart';

// class MainPage extends StatefulWidget {
//   MainPage({
//     Key? key,

//   }) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   bool isAdding = false;
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descController = TextEditingController();
// int pageIndex=0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // floatingActionButton: widget.pageIndex == 0
//         //     ? FloatingActionButton(
//         //         onPressed: () {
//         //           showModalBottomSheet(
//         //               context: context,
//         //               builder: (BuildContext context) => Container(
//         //                     // width: ,

//         //                     padding: EdgeInsets.all(20),
//         //                     //  alignment: Alignment.centerLeft,

//         //                     color: Colors.white,
//         //                     child: Column(
//         //                       crossAxisAlignment: CrossAxisAlignment.start,
//         //                       children: [
//         //                         Row(
//         //                           mainAxisAlignment:
//         //                               MainAxisAlignment.spaceBetween,
//         //                           children: [
//         //                             BigText(
//         //                               text: "Add New Item",
//         //                               isCentre: false,
//         //                             ),
//         //                             IconButton(
//         //                                 onPressed: () {
//         //                                   Navigator.pop(context);
//         //                                 },
//         //                                 icon: Icon(Icons.cancel))
//         //                           ],
//         //                         ),
//         //                         SizedBox(
//         //                           height: 10,
//         //                         ),
//         //                         PlaneTextField(
//         //                             isEnabled: isAdding == true ? false : true,
//         //                             placeholder: "Enter item title",
//         //                             controller: titleController,
//         //                             icon: Icons.title,
//         //                             onChange: () {}),
//         //                         PlaneTextField(
//         //                             isEnabled: isAdding == true ? false : true,
//         //                             minLines: 2,
//         //                             maxLines: 3,
//         //                             placeholder: "Enter item description",
//         //                             controller: descController,
//         //                             icon: Icons.title,
//         //                             onChange: () {}),
//         //                         PrimaryButton(
//         //                             TapAction: () async {
//         //                               if (descController.text == "" ||
//         //                                   titleController.text == "") {
//         //                                 Fluttertoast.showToast(
//         //                                     msg: "Some of Fields are empty");
//         //                               } else {
//         //                                 setState(() {
//         //                                   isAdding = true;
//         //                                 });

//         //                                 await AddNewItem(titleController.text,
//         //                                     descController.text);

//         //                                 setState(() {
//         //                                   isAdding = false;
//         //                                   titleController.text = "";
//         //                                   descController.text = "";
//         //                                 });

//         //                                 Navigator.pop(context);

//         //                                 Fluttertoast.showToast(
//         //                                     msg: "New Item Added successfully");
//         //                               }
//         //                             },
//         //                             text: "Add Item",
//         //                             color: AppColors.PrimaryColor,
//         //                             icon: Icons.add)
//         //                       ],
//         //                     ),
//         //                   ));
//         //           // showDialog(
//         //           //     context: context,
//         //           //     builder: (BuildContext context) => Container(
//         //           //           // width: 100,
//         //           //           height: 200,
//         //           //           color: Colors.white,
//         //           //           child: Center(child: BigText(text: "This is Text")),
//         //           //         ));
//         //         },
//         //         backgroundColor: AppColors.PrimaryColor,
//         //         child: Icon(
//         //           Icons.add,
//         //           color: Colors.white,
//         //         ),
//         //       )
//         //     : SizedBox(),
//         bottomNavigationBar: BottomNavigationBar(
//             selectedItemColor: AppColors.PrimaryColor,
//             onTap: (value) {
//               setState(() {
//                pageIndex = value;
//               });
//             },
//             currentIndex:pageIndex,
//             items: const [
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.home,
//                   ),
//                   label: "Home"),
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.message,
//                   ),
//                   label: "Messages"),
//                    BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.message,
//                   ),
//                   label: "Messages"),

//               BottomNavigationBarItem(
//                   icon: Icon(Icons.account_circle), label: "Account"),

//             ]),
//         appBar: AppBar(
//           backgroundColor: AppColors.PrimaryColor,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // SmallText(
//               //   text: widget.pageIndex == 0
//               //       ? "List of Items"
//               //       : widget.pageIndex == 1
//               //           ? "All Users"
//               //           : "Add items",
//               //   color: Colors.white,
//               // ),
//               IconButton(
//                   onPressed: () async {
//                     await logOut();
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: ((context) => Login())));
//                   },
//                   icon: Icon(Icons.logout))
//             ],
//           ),
//         ),
//         body: pageIndex == 0
//             ? ItemsPage()
//             : pageIndex == 1
//                 ? UsersPage()
//                 : pageIndex == 2
//                     ? AddProductPage()
//                     : pageIndex == 3
//                         ? UsersPage()
//                         : MyAccountPage()
//                         );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/pages/ItemsPage.dart';
import 'package:login_system/pages/MyAccountPage.dart';
import 'package:login_system/pages/UsersPage.dart';
import 'package:login_system/pages/add_product_page.dart';

import 'admin/Login.dart';
import 'models/Authentication.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
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
                onPressed: () async {
                  await logOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => Login())));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            ItemsPage(),
            UsersPage(),
            AddProductPage(),
            UsersPage(),
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
          type: BottomNavigationBarType.fixed,
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
                  Icons.message,
                ),
                label: "Messages"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_sharp), label: "Sell"),
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
