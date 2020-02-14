import 'package:flutter/material.dart';

/// TODO add theme to widget (and all the app by the way)
class WeekdaySelector extends StatefulWidget {
  static const sunday = 0;
  static const monday = 1;
  static const tuesday = 2;
  static const wednesday = 3;
  static const thursday = 4;
  static const friday = 5;
  static const saturday = 6;

  final Color color;
  final Color pressedColor;
  final Function(int) onPressed;

  const WeekdaySelector(
      {Key key, this.color, this.pressedColor, this.onPressed})
      : super(key: key);

  @override
  WeekdaySelectorState createState() => WeekdaySelectorState();
}

class WeekdaySelectorState extends State<WeekdaySelector> {
  List<bool> _selectedDays;

  @override
  void initState() {
    setState(() {
      _selectedDays = [false, false, false, false, false, false, false];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final days = <Widget>[];
    Map<int, String> daysHash = {
      WeekdaySelector.sunday: "D",
      WeekdaySelector.monday: "S",
      WeekdaySelector.tuesday: "T",
      WeekdaySelector.wednesday: "Q",
      WeekdaySelector.thursday: "Q",
      WeekdaySelector.friday: "S",
      WeekdaySelector.saturday: "S",
    };
    daysHash.forEach((value, label) {
      print("value $value");
      final Widget day = _Day(
          color: widget.color,
          pressedColor: Colors.yellow,
          label: label,
          selected: _selectedDays[value],
          position: value,
          onPressed: widget.onPressed(value));
      days.add(day);
    });
    print(daysHash);
    return Row(children: days, mainAxisAlignment: MainAxisAlignment.start);
  }
}

class _Day extends StatelessWidget {
  final Color color;
  final Color pressedColor;
  final bool selected;
  final String label;
  final int position;
  final Function(int) onPressed;

  const _Day(
      {Key key,
      this.color,
      this.pressedColor,
      this.label,
      this.selected = false,
      this.position,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderColor = Colors.black;
    return RawMaterialButton(
      onPressed: () {
        print("position $position");
        this.onPressed(position);
      },
      elevation: selected ? 4 : 2,
      constraints: BoxConstraints(minWidth: 25, minHeight: 25),
      fillColor: selected ? pressedColor : color,
      child: Text(label),
      shape: CircleBorder(
          side: selected
              ? BorderSide(color: borderColor, width: 1)
              : BorderSide.none),
    );
  }
}
