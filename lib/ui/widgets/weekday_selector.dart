import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:task_manager/model/app_state.dart';

/// TODO add theme to widget (and all the app by the way)
class WeekdaySelector extends StatefulWidget {
  static const sunday = 0;
  static const monday = 1;
  static const tuesday = 2;
  static const wednesday = 3;
  static const thursday = 4;
  static const friday = 5;
  static const saturday = 6;

  const WeekdaySelector();

  @override
  WeekdaySelectorState createState() => WeekdaySelectorState();
}

class WeekdaySelectorState extends State<WeekdaySelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Row(
              children: buildDays(state.selectedDays),
              mainAxisAlignment: MainAxisAlignment.start);
        });
  }
}

List<Widget> buildDays(List<bool> selectedDays) {
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
    final Widget day =
        _Day(label: label, position: value, selected: selectedDays[value]);
    days.add(day);
  });
  print(daysHash);
  return days;
}

class _Day extends StatelessWidget {
  final String label;
  final int position;
  final bool selected;

  const _Day({Key key, this.label, this.position, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderColor = Colors.black;
    return RawMaterialButton(
      onPressed: () {},
      elevation: selected ? 4 : 2,
      constraints: BoxConstraints(minWidth: 25, minHeight: 25),
      fillColor: selected ? Colors.green : Colors.red,
      child: Text(label),
      shape: CircleBorder(
          side: selected
              ? BorderSide(color: borderColor, width: 1)
              : BorderSide.none),
    );
  }
}
