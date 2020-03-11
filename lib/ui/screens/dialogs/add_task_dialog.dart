import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:task_manager/model/app_state.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/model/task_schema.dart';
import 'package:task_manager/redux/actions/actions.dart';
import 'package:task_manager/ui/widgets/weekday_selector.dart';
import 'package:task_manager/utils/date_utils.dart';
import 'package:task_manager/utils/enums.dart';
import 'package:task_manager/utils/styles.dart';

/// TODO class???
/// TODO know bug -> when adding a task in the front the task doesn't have an ID, this will be a problem when using the database
void addTaskDialog(BuildContext context, DateTime selectedDay, {Task task}) {
  Dialog dialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Text(
                "Add Task Dialog",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            AddTaskForm(selectedDay: selectedDay, task: task),
          ],
        ),
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => dialog);
}

// TODO bugs conhecidos, mudar a frequancia faz focar o titulo
class AddTaskForm extends StatefulWidget {
  final DateTime selectedDay;
  final Task task;

  const AddTaskForm({this.selectedDay, this.task});

  @override
  AddTaskFormState createState() => AddTaskFormState();
}

class AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();

  bool _repeat;
  bool _useLocation;
  TaskFrequency _currentFrequency;
  List<DropdownMenuItem<TaskFrequency>> _frequencyMenuItems;

  List<bool> _selectedDays;

  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  @override
  void dispose() {
    controllerTitle.dispose();
    controllerDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _repeat = false;
    _useLocation = false;

    _currentFrequency = TaskFrequency.DAILY;
    _selectedDays = [false, false, false, false, false, false, false];
    _frequencyMenuItems = getDropDownMenuItems();
    print(_frequencyMenuItems);

    if (widget.task != null) {
      controllerTitle.text = widget.task.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _titleWidget(),
            _repeatWidget(),
            _frequencyWidget(),
            _daySelectorWidget(),
            _useLocationWidget(),
            _descriptionWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Divider(height: 30, thickness: 3, color: Colors.black12),
            ),
            _submitWidget()
          ],
        ));
  }

  Padding _titleWidget() {
    return Padding(
      padding: edgesBtweenForm,
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.assignment),
          hintText: 'What is the title of your task?',
          labelText: 'Title *',
        ),
        validator: _validatorTitle,
        onSaved: _onSavedTitle,
        controller: controllerTitle,
      ),
    );
  }

  Padding _repeatWidget() {
    return Padding(
      padding: edgesBtweenForm,
      child: MergeSemantics(
        child: ListTile(
            title: Text('Repeat'),
            trailing:
                CupertinoSwitch(value: _repeat, onChanged: _onChangedRepeat)),
      ),
    );
  }

  Visibility _frequencyWidget() {
    return Visibility(
      visible: _repeat,
      child: Column(
        children: <Widget>[
          Center(child: Text("Frequencia")),
          Padding(
              padding: edgesBtweenForm,
              child: DropdownButton(
                value: _currentFrequency,
                items: _frequencyMenuItems,
                onChanged: _onChangedFrequency,
              )),
        ],
      ),
    );
  }

  Visibility _daySelectorWidget() {
    return Visibility(
      visible: _currentFrequency == TaskFrequency.CUSTOM,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: WeekdaySelector(),
      ),
    );
  }

  Padding _useLocationWidget() {
    return Padding(
      padding: edgesBtweenForm,
      child: MergeSemantics(
        child: ListTile(
            title: Text('Use Location'),
            trailing: CupertinoSwitch(
                value: _useLocation, onChanged: _onChangedUseLocation)),
      ),
    );
  }

  Padding _descriptionWidget() {
    return Padding(
      padding: edgesBtweenForm,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        controller: controllerDescription,
        maxLines: null,
        decoration: const InputDecoration(
          icon: Icon(Icons.assignment),
          hintText: 'What is the description of your task?',
          labelText: 'Description',
        ),
        onSaved: _onSavedTitle,
      ),
    );
  }

  Align _submitWidget() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return RaisedButton(
              color: Colors.blue,
              onPressed: () => _submit(state.selectedDays),
              child: Text(
                'Add Task',
                style: submitButtonTextStyle,
              ),
            );
          }),
    );
  }

  List<DropdownMenuItem<TaskFrequency>> getDropDownMenuItems() {
    List<DropdownMenuItem<TaskFrequency>> items = new List();

    TaskFrequency.values.forEach((frequency) {
      items.add(new DropdownMenuItem(
          value: frequency, child: new Text(frequency.toString())));
    });

    return items;
  }

  void _onChangedUseLocation(bool value) {
    setState(() {
      _useLocation = value;
    });
  }

  void _onPressedDayOfWeek(position) {
    setState(() {
      _selectedDays[position] = !_selectedDays[position];
    });
    print("position:$position : ${_selectedDays[position]}");
  }

  void _onSavedTitle(String value) {
    //optional
  }

  String _validatorTitle(title) {
    if (title.isEmpty) return 'Please enter some text';
    return null;
  }

  void _onChangedRepeat(bool value) {
    setState(() {
      _repeat = value;
      if (!_repeat) _currentFrequency = TaskFrequency.DAILY;
    });
  }

  void _onChangedFrequency(selected) {
    setState(() {
      _currentFrequency = selected;
    });
  }

  void _submit(List<bool> selectedDays) {
    if (_formKey.currentState.validate()) {
      TaskSchema task = TaskSchema(
        title: controllerTitle.text,
        createdDay: widget.selectedDay,
        useLocation: _useLocation,
        description: controllerDescription.text,
        frequency: null,
        selectedDays: null,
        useAlarm: false,
        alarmTime: "",
      );

      if (widget.task == null) {
        task.processedInMonths = {dateMonthHash(widget.selectedDay): true};

        StoreProvider.of<AppState>(context).dispatch(AddTaskSchemaAction(task));
      } else {
        task.id = widget.task.id;
        task.alarmTime = widget.task.alarmTime;
        task.location = widget.task.location;
//        task.createdDay = widget.task.createdDay TODO think about a better solution
        StoreProvider.of<AppState>(context)
            .dispatch(UpdateTaskSchemaAction(task));
      }
      Navigator.of(context).pop();
    }
  }
}
