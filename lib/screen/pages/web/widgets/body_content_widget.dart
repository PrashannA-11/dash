import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BodyContentWidget extends StatefulWidget {
  final SizingInformation sizingInformation;

  const BodyContentWidget({required Key key, required this.sizingInformation})
      : super(key: key);

  @override
  _BodyContentWidgetState createState() => _BodyContentWidgetState();
}

class _BodyContentWidgetState extends State<BodyContentWidget> {
  final int _rowCurrentBtnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.sizingInformation.screenSize.width / 1.4,
        child: Column(children: [
          _headerWidget(),
        ]));
  }

  _headerWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Welcome Back", style: TextStyle(fontSize: 18)),
            ],
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: const Text(
                "Customise Blocks",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  Widget _quickStatsWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Stats",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          widget.sizingInformation.screenSize.width / 1.4 <= 860
              ? _row2by2Widget()
              : _row4Widget()
        ],
      ),
    );
  }

  Widget _row4Widget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _singleItemQuickStats(
          title: "Total Bookings",
          value: "28,345",
          width: widget.sizingInformation.screenSize.width / 3.1,
          iconColor: Colors.black,
          icon: Icons.check_box,
        ),
        _singleItemQuickStats(
            title: "Pending Approval",
            value: "180",
            width: widget.sizingInformation.screenSize.width / 3.1,
            iconColor: Colors.black,
            icon: Icons.pending,
            textColor: Colors.red),
        _singleItemQuickStats(
            title: "New Clients This Month",
            value: "810",
            width: widget.sizingInformation.screenSize.width / 3.1,
            icon: Icons.arrow_upward,
            iconColor: Colors.green),
        _singleItemQuickStats(
            title: "Returning Clients",
            value: "20%",
            width: widget.sizingInformation.screenSize.width / 3.1,
            icon: Icons.arrow_downward,
            iconColor: Colors.red),
      ],
    );
  }

  Widget _row2by2Widget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _singleItemQuickStats(
              title: "Total Bookings",
              value: "28,345",
              width: widget.sizingInformation.screenSize.width / 3.1,
              icon: Icons.check_box,
              iconColor: Colors.black,
            ),
            _singleItemQuickStats(
                title: "Pending Approval",
                value: "180",
                icon: Icons.pending,
                iconColor: Colors.black,
                width: widget.sizingInformation.screenSize.width / 3.1,
                textColor: Colors.red),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _singleItemQuickStats(
                title: "New Clients This Month",
                value: "810",
                icon: Icons.arrow_upward,
                iconColor: Colors.green,
                width: widget.sizingInformation.screenSize.width / 3.1),
            _singleItemQuickStats(
                title: "Returning Clients",
                value: "20%",
                icon: Icons.arrow_downward,
                width: widget.sizingInformation.screenSize.width / 3.1,
                iconColor: Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _singleItemQuickStats(
      {required String title,
      Color textColor = const Color.fromARGB(255, 3, 0, 0),
      required String value,
      required IconData icon,
      required double width,
      required Color iconColor}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.2),
              spreadRadius: 2,
              offset: const Offset(0.5, 0.5),
              blurRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          icon == null
              ? Text(
                  value,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 28,
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
}
