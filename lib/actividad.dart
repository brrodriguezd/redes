import 'dart:async';
import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart'
    as ar;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyecto/prueba.dart';

class ActivityRecognitionApp extends StatefulWidget {
  final bool prueba;
  const ActivityRecognitionApp({super.key, this.prueba = true});

  @override
  State<ActivityRecognitionApp> createState() => _ActivityRecognitionAppState();
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/datos.csv');
}

Future<File> writeCounter(ar.ActivityEvent evento) async {
  final file = await _localFile;
  final lt = Platform.lineTerminator;
  final location = await Geolocator.getCurrentPosition();
  final String addendum =
      '${DateUtils.dateOnly(evento.timeStamp)},${evento.timeStamp.weekday},${evento.timeStamp.hour}:${evento.timeStamp.minute},${evento.type},${evento.confidence},${location.latitude},${location.longitude},${location.accuracy},$lt';
  // Write the file
  return file.writeAsString(addendum, mode: FileMode.writeOnlyAppend);
}

class _ActivityRecognitionAppState extends State<ActivityRecognitionApp> {
  StreamSubscription<ar.ActivityEvent>? activityStreamSubscription;
  final List<ar.ActivityEvent> _events = [];
  ar.ActivityRecognition activityRecognition = ar.ActivityRecognition();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    activityStreamSubscription?.cancel();
    super.dispose();
  }

  void _init() async {
    // Android requires explicitly asking permission
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        if (await Permission.location.request().isGranted) {
          if (await Permission.locationAlways.request().isGranted) {
            _startTracking();
          } else {
            dispose();
            return;
          }
        } else {
          return;
        }
      }
    }
    // iOS does not
    else {
      _startTracking();
    }
  }

  Future<void> _startTracking() async {
    //TODO: Añadir que verifique que hayan pasado dos semanas o si se encuentra un cambio significativo en la rutina
    if (widget.prueba) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Prueba()));
    }
    activityStreamSubscription = activityRecognition
        .activityStream(runForegroundService: true)
        .listen(onData, onError: onError);
  }

  Future<void> onData(ar.ActivityEvent activityEvent) async {
    setState(() {
      _events.add(activityEvent);
    });
    await writeCounter(activityEvent);
  }

  void onError(Object error) {
    if (kDebugMode) {
      print('ERROR - $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Recognition'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _events.length,
            reverse: true,
            itemBuilder: (_, int idx) {
              final activity = _events[idx];
              return ListTile(
                leading: _activityIcon(activity.type),
                title: Text(
                    '${activity.type.toString().split('.').last} (${activity.confidence}%)'),
                trailing: Text(activity.timeStamp
                    .toString()
                    .split(' ')
                    .last
                    .split('.')
                    .first),
              );
            }),
      ),
    );
  }

  Icon _activityIcon(ar.ActivityType type) {
    switch (type) {
      case ar.ActivityType.WALKING:
        return const Icon(Icons.directions_walk);
      case ar.ActivityType.IN_VEHICLE:
        return const Icon(Icons.car_rental);
      case ar.ActivityType.ON_BICYCLE:
        return const Icon(Icons.pedal_bike);
      case ar.ActivityType.ON_FOOT:
        return const Icon(Icons.directions_walk);
      case ar.ActivityType.RUNNING:
        return const Icon(Icons.run_circle);
      case ar.ActivityType.STILL:
        return const Icon(Icons.cancel_outlined);
      case ar.ActivityType.TILTING:
        return const Icon(Icons.redo);
      default:
        return const Icon(Icons.device_unknown);
    }
  }
}
