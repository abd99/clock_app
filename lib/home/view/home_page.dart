import 'package:clock_app/alarm/alarm.dart';
import 'package:clock_app/clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBController dbController = DBController();
  List<AlarmTime> savedAlarms = [];

  @override
  void initState() {
    super.initState();
    dbController.open('alarm.db');
    Future.delayed(Duration(seconds: 1), () {
      retrieveAlarms();
    });
  }

  @override
  void dispose() {
    dbController.close();
    super.dispose();
  }

  Future<void> retrieveAlarms() async {
    var list = await dbController.getSavedAlarms();
    setState(() {
      savedAlarms = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ChangeNotifierProvider(
                  create: (context) => ClockPreference(),
                  child: ClockView(),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Column(
                  children: [
                    Text(
                      'Alarms',
                      style: textTheme.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        // var data = snapshot.data;

                        if (savedAlarms == null || savedAlarms.length == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: Text('Saved alarms will appear here'),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              children: List.generate(
                                savedAlarms.length,
                                (index) {
                                  var item = savedAlarms[index];
                                  return ListTile(
                                    title: Text(
                                      '${item.month}/${item.day.toString()} ${item.hour}:${item.minute}',
                                      style: textTheme.subtitle1,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () async {
          var _selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 30)),
          );
          TimeOfDay _selectedTime;
          if (_selectedDate != null) {
            _selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
          }
          if (_selectedDate != null && _selectedTime != null) {
            final _alarmTime = AlarmTime(
              year: _selectedDate.year,
              month: _selectedDate.month,
              day: _selectedDate.day,
              hour: _selectedTime.hour,
              minute: _selectedTime.minute,
            );
            await dbController.saveAlarm(_alarmTime);
            retrieveAlarms();
          }
        },
        label: Text('Add Alarm'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
