import 'dart:async';

import 'package:esense_flutter/esense.dart';
import 'package:flutter/foundation.dart';

class EarableState extends ChangeNotifier {
  String name = "eSense-0414";
  String deviceStatus = '';
  bool sampling = false;
  bool connected = false;

  Map<String, List<int>> acceptGesture = {"x": [], "y": [], "z": []};
  Map<String, List<int>> declineGesture = {"x": [], "y": [], "z": []};

  Future listenToESense() async {
    // if you want to get the connection events when connecting,
    // set up the listener BEFORE connecting...
    ESenseManager().connectionEvents.listen((event) {
      print('CONNECTION event: $event');

      // when we're connected to the eSense device, we can start listening to events from it
      if (event.type == ConnectionType.connected) _listenToESenseEvents();

      connected = false;
      switch (event.type) {
        case ConnectionType.connected:
          deviceStatus = 'connected';
          connected = true;
          break;
        case ConnectionType.unknown:
          deviceStatus = 'unknown';
          break;
        case ConnectionType.disconnected:
          deviceStatus = 'disconnected';
          break;
        case ConnectionType.device_found:
          deviceStatus = 'device_found';
          break;
        case ConnectionType.device_not_found:
          deviceStatus = 'device_not_found';
          break;
      }
      notifyListeners();
    });
  }

  Future connectToESense() async {
    print('connecting... connected: $connected');
    if (!connected) connected = await ESenseManager().connect(name);

    deviceStatus = connected ? 'connecting' : 'connection failed';
    notifyListeners();
  }

  void _listenToESenseEvents() async {
    ESenseManager().eSenseEvents.listen((event) {
      print('ESENSE event: $event');
    });

    _getESenseProperties();
  }

  void _getESenseProperties() async {
    // get the battery level every 10 secs
    Timer.periodic(
      Duration(seconds: 10),
      (timer) async =>
          (connected) ? await ESenseManager().getBatteryVoltage() : null,
    );

    // wait 2, 3, 4, 5, ... secs before getting the name, offset, etc.
    // it seems like the eSense BTLE interface does NOT like to get called
    // several times in a row -- hence, delays are added in the following calls
    Timer(Duration(seconds: 2),
        () async => await ESenseManager().getDeviceName());
    Timer(Duration(seconds: 3),
        () async => await ESenseManager().getAccelerometerOffset());
    Timer(
        Duration(seconds: 4),
        () async =>
            await ESenseManager().getAdvertisementAndConnectionInterval());
    Timer(Duration(seconds: 5),
        () async => await ESenseManager().getSensorConfig());
    notifyListeners();
  }

  StreamSubscription subscription;

  void startListenToSensorEvents({bool recording, String gesture}) async {
    // subscribe to sensor event from the eSense device
    subscription = ESenseManager().sensorEvents.listen((event) {
      if (recording) {
        var destination;
        if (gesture == "accept") {
          destination = acceptGesture;
        } else if (gesture == "decline") {
          destination = declineGesture;
        }
        destination["x"].add(event.gyro[0]);
        destination["y"].add(event.gyro[1]);
        destination["z"].add(event.gyro[2]);
      } else {
        print('SENSOR event: $event');
      }
    });
    sampling = true;
    notifyListeners();
  }

  void pauseListenToSensorEvents() async {
    if (sampling) {
      subscription.cancel();
      sampling = false;
    }
    notifyListeners();
  }

  Future<void> changeEarable(String name) async {
    this.name = name;
    ESenseManager().disconnect();
    await ESenseManager().connect(name);
    notifyListeners();
  }

  void dispose() {
    pauseListenToSensorEvents();
    ESenseManager().disconnect();
    super.dispose();
  }
}
