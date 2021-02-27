import 'package:flutter/material.dart';

class NumbersList extends StatefulWidget {
  final int numbermin;
  final int numbermax;
  /*final ValueChanged onPeriodLengthChanged;*/

  const NumbersList({
    Key key,
    @required this.numbermax,
    @required this.numbermin,
    /*this.onPeriodLengthChanged*/
  }) : super(key: key);

  @override
  _NumbersListState createState() => _NumbersListState();
}

class _NumbersListState extends State<NumbersList> {
  int _selectedItemIndex = 0;
  bool isSelected = false;
  Color color = Colors.grey[500];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: 250,
          alignment: Alignment.center,
          child: Container(
            height: 50,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.pink[300],
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Colors.pink[300],
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: new ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 250,
            ),
            child: new ListWheelScrollView.useDelegate(
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 100,
              itemExtent: 50,
              onSelectedItemChanged: (index) => setState(() {
                _selectedItemIndex = index;
                /*widget.onPeriodLengthChanged(_selectedItemIndex);*/
              }),
              childDelegate: ListWheelChildLoopingListDelegate(
                children: List.generate(
                  widget.numbermax - widget.numbermin + 1,
                  (index) => Container(
                    width: width,
                    child: Center(
                      child: Text(
                        '${index + widget.numbermin}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: _selectedItemIndex == index
                                ? Colors.pink[300]
                                : color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
