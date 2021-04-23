import 'package:clock_app/alarm/alarm.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBController {
  Database db;

  Future open(String path) async {
    db = await openDatabase(
      join(await getDatabasesPath(), path),
      version: 1,
      onCreate: (Database db, int version) async {
        print('Run create table........');
        await db.execute(
            '''create table alarm (year INTEGER not null, month INTEGER not null, day INTEGER not null, hour INTEGER not null, minute INTEGER not null)''');
      },
    );
  }

  Future<void> saveAlarm(AlarmTime alarmTime) async {
    print('Insert calling....');
    await db.insert(
      'alarm',
      alarmTime.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Insert called');
  }

  Future<List<AlarmTime>> getSavedAlarms() async {
    print('Read calling....');
    final List<Map<String, dynamic>> maps = await db.query('alarm');
    print('Read called');

    var alarmList = List.generate(maps.length, (i) {
      return AlarmTime(
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
        hour: maps[i]['hour'],
        minute: maps[i]['minute'],
      );
    });
    return alarmList;
  }

  Future close() async => db.close();
}
