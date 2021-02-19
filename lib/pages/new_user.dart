import 'package:flutter/material.dart';
import 'package:menstruating/constants.dart';
import 'package:menstruating/pages/components/boxdialog.dart';
import 'package:menstruating/pages/components/colordot.dart';
import 'package:menstruating/pages/components/numbersList.dart';

class NewUser extends StatefulWidget {
  final int pageIndex;
  final ValueChanged<int> onPageChanged;
  final PageController pageController;

  const NewUser(
      {Key key, this.pageIndex, this.onPageChanged, this.pageController})
      : super(key: key);

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  int selectedIndex = 0;

  void _refresh(bool _isSelected) {
    setState(() => selectedIndex = _isSelected ? 1 : 0);
  }

  buildPageScreen(selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(KDefaultPaddin),
              child: Center(
                child: Text(
                  "To predict period accurately,\n it would be better if you answer 3 questions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink[400],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 18),
                    child: Text(
                      "On average, how long is your period?",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: BoxwDialog(
                      listBody: ListBody(
                        children: [
                          Text(
                              "Period lenght means bleeding days, which usually lasts between 3-7 days."),
                          Divider(),
                          Text(
                            "The period lenght you selected will be used to predict your next period lenght.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            NumbersList(
              numbermax: 14,
              numbermin: 2,
            ),
          ],
        );
        break;
      case 1:
        return Container(
          margin: EdgeInsets.all(KDefaultPaddin),
          child: Center(
            child: Text(
              "Answered.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.pink[400],
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            buildPageScreen(selectedIndex),
            Padding(
              padding: const EdgeInsets.all(KDefaultPaddin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorDot(refresh: _refresh),
                  Text("I don't know"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(KDefaultPaddin),
              height: height * 0.075,
              width: width * 0.8,
              child: RaisedButton(
                color: Colors.pink[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                  side: BorderSide(
                    color: Colors.pink[400],
                  ),
                ),
                onPressed: () {
                  widget.pageController.jumpToPage(widget.pageIndex + 1);
                  widget.onPageChanged(widget.pageIndex + 1);
                }

                /*Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => NewUser2()),
                ),*/
                ,
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: WTextColor,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
