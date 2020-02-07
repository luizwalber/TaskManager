class Weekdays {
  List<bool> _selectedDays;

  List<bool> get selectedDays => _selectedDays;

  // I created 7 columns to represent the weekdays because didn't know any other easier way by now (part to improve)
  static String mondayCol = "monday";
  static String tuesdayCol = "tuesday";
  static String wednesdayCol = "wednesdday";
  static String thursdayCol = "thursday";
  static String fridayCol = "friday";
  static String saturdayCol = "saturday";
  static String sundayCol = "sunday";

  Weekdays(this._selectedDays);

  Map<String, bool> toMap() {
    return _selectedDays != null
        ? {
            sundayCol: _selectedDays[0],
            mondayCol: _selectedDays[1],
            tuesdayCol: _selectedDays[2],
            wednesdayCol: _selectedDays[3],
            thursdayCol: _selectedDays[4],
            fridayCol: _selectedDays[5],
            saturdayCol: _selectedDays[6]
          }
        : null;
  }

  Weekdays.fromMap(Map<String, dynamic> map) {
    if (map == null)
      _selectedDays = [false, false, false, false, false, false, false];
    else {
      _selectedDays = [
        map[sundayCol] != 0,
        map[mondayCol] != 0,
        map[tuesdayCol] != 0,
        map[wednesdayCol] != 0,
        map[thursdayCol] != 0,
        map[fridayCol] != 0,
        map[saturdayCol] != 0
      ];
    }
  }
}
