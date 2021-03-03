import 'package:flutter/material.dart';
import 'package:menstruating/constants.dart';
import 'package:menstruating/models/user.dart';
import 'package:menstruating/pages/components/boxdialog.dart';
import 'package:menstruating/pages/components/colordot.dart';
import 'package:menstruating/pages/components/numbersList.dart';
import 'package:menstruating/services/database.dart';

class Question2 extends StatefulWidget {
  final int pageIndex;
  final ValueChanged<int> onPageChanged;
  final PageController pageController;

  const Question2(
      {Key key, this.pageIndex, this.onPageChanged, this.pageController})
      : super(key: key);
  @override
  _Question2State createState() => _Question2State();
}

class _Question2State extends State<Question2>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;
  int _numbermin = 15;
  void _refresh(bool _isSelected) {
    setState(() => selectedIndex = _isSelected ? 1 : 0);
  }

  _onPeriodCycleChanged(int index, User user) async {
    await DataBaseService(uid: user.uid)
        .updateUserData(periodCycle: index + _numbermin);
  }

  buildBodyScreen(int selectedIndex, double height) {
    switch (selectedIndex) {
      case 0:
        return Container(
          height: height * 0.65,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Text(
                        "On average, how long is your period cycle?",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Container(
                      child: BoxwDialog(
                        listBody: ListBody(
                          children: [
                            Text(
                              "Cycle lenght means the duration of two dates of period start, usually 21 to 36 days.",
                              textAlign: TextAlign.justify,
                            ),
                            Divider(),
                            Text(
                              "The cycle lenght you selected will be used to predict your next cycle lenght.",
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NumbersList(
                onChanged: _onPeriodCycleChanged,
                numbermax: 100,
                numbermin: _numbermin,
              ),
            ],
          ),
        );
        break;
      case 1:
        return Container(
          height: height * 0.65,
          child: Center(
            child: Text(
              "Answered.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.pink[300],
                fontSize: 16,
              ),
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          buildBodyScreen(selectedIndex, height),
          Padding(
            padding: const EdgeInsets.all(KDefaultPaddin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorDot(
                  refresh: _refresh,
                ),
                Text("I don't know")
              ],
            ),
          ),
          Container(
            height: height * 0.075,
            width: width * 0.8,
            child: RaisedButton(
              color: Colors.pink[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: BorderSide(color: Colors.pink[300]),
              ),
              onPressed: () {
                widget.pageController.jumpToPage(widget.pageIndex + 1);
                widget.onPageChanged(widget.pageIndex + 1);
              },
              child: Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
