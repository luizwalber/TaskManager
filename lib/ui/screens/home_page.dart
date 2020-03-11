import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/ui/widgets/task_list.dart';
import 'package:task_manager/utils/date_utils.dart';
import 'package:task_manager/utils/enums.dart';

// TODO show day in the middle of the divider between the calendar and the tasks
class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DateTime _selectedDay;

  AnimationController _animationController;
  CalendarController _calendarController;

  static const String _weeklyGoals = 'Weekly Goals';
  static const String _dailyGoals = 'Daily Goals';
  static const String _settings = 'Settings';

  void initState() {
    super.initState();
    _selectedDay = DateTime.now(); //TODO set state in the case?

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendarWithBuilders(),
          Divider(height: 30, thickness: 3, color: Colors.black12),
          _taskList(context)
        ],
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return TableCalendar(
            rowHeight: 50,
            locale: 'pt_br',
            calendarController: _calendarController,
            events: extractEvents(state),
            calendarStyle: _calendarStyle(),
            headerStyle: _calendarHeaderStyle(),
            builders: calendarBuilders(),
            onDaySelected: _onDaySelected,
            onVisibleDaysChanged: _onMonthChange,
          );
        });
  }

  void _onMonthChange(DateTime first, DateTime last, CalendarFormat format) {
    /// I couldn't find any method to trigger the month change event, I could only update the monthly tasks
    /// using the method that is called when the visible days is changed, but if the calendar shows
    /// outside months in the visible days will get the wrong month, the code bellow fix that
    int month = last.day < 7 ? last.month - 1 : last.month;
//    StoreProvider.of<AppState>(context).dispatch(LoadTaskAction(month));
  }

  CalendarBuilders calendarBuilders() {
    return CalendarBuilders(
      //dayBuilder: _dayBuilder,
      selectedDayBuilder: _onSelectDay,
      todayDayBuilder: _todayBuilder,
      markersBuilder: _markersBuilder,
      weekendDayBuilder: _weekendDayBuilder,
    );
  }

  StoreConnector<AppState, AppState> _taskList(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Expanded(
              child: TaskList(
                  selectedTasks: state.monthlyTasks != null
                      ? state.monthlyTasks[dateDayHash(_selectedDay)]
                      : null,
                  selectedDay: _selectedDay));
        });
  }

  AppBar _appBar() {
    return AppBar(
        title: new Center(
            child: new Text(widget.title, textAlign: TextAlign.center)),
        actions: <Widget>[_popupMenu()]);
  }

  PopupMenuButton<String> _popupMenu() {
    return PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return [_weeklyGoals, _dailyGoals, _settings].map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  List<Widget> _markersBuilder(context, date, tasks, holidays) {
    return _buildMarkers(tasks, date);
  }

  Widget _todayBuilder(context, date, _) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[300],
        ),
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget _weekendDayBuilder(context, date, _) {
    return Center(
      child: Container(
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget _dayBuilder(context, date, _) {
    return Center(
      child: Container(
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget _onSelectDay(context, date, _) {
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red[100],
            ),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          ),
        ));
  }

  HeaderStyle _calendarHeaderStyle() {
    return HeaderStyle(
      centerHeaderTitle: true,
      formatButtonVisible: false,
    );
  }

  CalendarStyle _calendarStyle() {
    return CalendarStyle(
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(color: Colors.pinkAccent));
  }

  Map<DateTime, List<Task>> extractEvents(AppState state) {
    Map<DateTime, List<Task>> events = {};

    state.monthlyTasks?.forEach((dayHash, tasks) {
      final DateTime date = DateTime.parse(dayHash);
      events[date] = tasks;
    });

    return events;
  }

  Widget _buildTaskCounter(DateTime date, List tasks) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${tasks.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskStatusFlag(DateTime date, List<Task> tasks) {
    Color color = Colors.transparent;
    Map<TaskStatus, List<Task>> map =
        groupBy(tasks, (Task task) => task.status);

    if (map[TaskStatus.DONE] != null &&
        map[TaskStatus.PARTIALLY] == null &&
        map[TaskStatus.NOT_DONE] == null) {
      if (map[TaskStatus.EMPTY] != null)
        color = Colors.orange;
      else
        color = Colors.green;
    } else if (map[TaskStatus.PARTIALLY] != null) {
      color = Colors.orange;
    } else if (map[TaskStatus.NOT_DONE] != null) {
      color = Colors.red;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), color: color),
      width: 16.0,
      height: 16.0,
    );
  }

  List<Widget> _buildMarkers(List tasks, DateTime date) {
    final children = <Widget>[];

    if (tasks.isNotEmpty) {
      children.add(
        Positioned(
          right: 1,
          bottom: 1,
          child: _buildTaskCounter(date, tasks),
        ),
      );
      children.add(
        Positioned(
          right: 1,
          top: 1,
          child: _buildTaskStatusFlag(date, tasks),
        ),
      );
    }

    return children;
  }

  void _onDaySelected(DateTime day, List tasks) {
    setState(() {
      _selectedDay = day;
    });

    _animationController.forward(from: 0.0);
  }

  void choiceAction(String choice) {
    if (choice == _weeklyGoals) {
      print('_weeklyGoals');
    } else if (choice == _dailyGoals) {
      print('_dailyGoals');
    } else if (choice == _settings) {
      print('_settings');
    }
  }
}
