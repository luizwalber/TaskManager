// More advanced TableCalendar configuration (using Builders & Styles)
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/Service/task_service.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/redux/actions/change_selected_day_action.dart';
import 'package:task_manager/utils/enums.dart';

class Calendar extends StatefulWidget {
  final Map<String, List<Task>> monthlyTasks;
  final List<TaskSchema> taskSchemas;

  Calendar({Key key, this.monthlyTasks, this.taskSchemas}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
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
    return TableCalendar(
      rowHeight: 50,
      //TODO bug, is overflowing when the month has more than 4 weeks
      locale: I18n.localeStr,
      calendarController: _calendarController,
      events: extractEvents(),
      calendarStyle: _calendarStyle(),
      headerStyle: _calendarHeaderStyle(),
      builders: calendarBuilders(),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onMonthChange,
    );
  }

  void _onMonthChange(DateTime first, DateTime last, CalendarFormat format) {
    TaskService.instance //TODO
        .changeMonth(first.year, first.month, widget.taskSchemas);
  }

  CalendarBuilders calendarBuilders() {
    return CalendarBuilders(
      selectedDayBuilder: _onSelectDay,
      todayDayBuilder: _todayBuilder,
      markersBuilder: _markersBuilder,
      weekendDayBuilder: _weekendDayBuilder,
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
    //TODO
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
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.pinkAccent));
  }

  Map<DateTime, List<Task>> extractEvents() {
    Map<DateTime, List<Task>> events = {};

    widget.monthlyTasks?.forEach((dayHash, tasks) {
      final DateTime date = DateTime.parse(dayHash);
      events[date] = tasks;
    });

    return events;
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
    store.dispatch(ChangeSelectedDayAction(selectedDay: day));

    _animationController.forward(from: 0.0);
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
}
