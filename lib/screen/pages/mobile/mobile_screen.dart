import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'widgets/drawer_mobile.dart';

class MobileScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return Scaffold(
          key: scaffoldKey,
          drawer: const DrawerMobile(),
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(Icons.menu),
            ),
            title: const Text("Dashboard"),
            actions: const [
              Icon(Icons.more_vert),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _upgradeToProWidget(),
                FutureBuilder(
                  // Fetch data from Firestore here
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return _row2by2Widget(
                        sizingInformation,
                        snapshot.data,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _upgradeToProWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.indigo,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upgrade\nto PRO",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "For more Profile Control",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset("assets/pro.png"),
          )
        ],
      ),
    );
  }

  Widget _row2by2Widget(
      SizingInformation sizingInformation, Map<String, dynamic>? data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _singleItemQuickStats(
                  title: "Total Bookings",
                  value: data?['totalBookings'] ?? '0',
                  width: sizingInformation.screenSize.width / 2.6,
                  icon: Icons.book_online,
                  iconColor: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _singleItemQuickStats(
                  title: "Pending Bookings",
                  value: data?['pendingBookings'] ?? '0',
                  icon: Icons.pending_actions,
                  iconColor: Colors.black,
                  width: sizingInformation.screenSize.width / 2.6,
                  textColor: Colors.red,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _singleItemQuickStats(
                  title: "My Bookings",
                  value: data?['myBookings'] ?? '0',
                  width: sizingInformation.screenSize.width / 2.6,
                  icon: Icons.book_online,
                  iconColor: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _singleItemQuickStats({
    required String title,
    Color textColor = Colors.black,
    required String value,
    required IconData icon,
    required double width,
    required Color iconColor,
  }) {
    return Container(
      width: width,
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            spreadRadius: 2,
            offset: const Offset(0.5, 0.5),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          icon == null
              ? Text(
                  value,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      icon,
                      color: iconColor,
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> fetchData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('your_collection')
        .doc('your_document_id')
        .get();
    //replace 'your_collection' with the actual name of your Firestore collection and 'your_document_id' with the ID of the document containing the data.

    return snapshot.data() ?? {};
  }
}
