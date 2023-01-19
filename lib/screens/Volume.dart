import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class Volume extends StatefulWidget {
  @override
  _VolumeState createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  double _volumeListenerValue = 0;
  double _setVolumeValue = 0;

  @override
  void initState() {
    super.initState();
    // Listen to system volume change
    VolumeController().listener((volume) {
      setState(() => _volumeListenerValue = volume);
    });

    VolumeController().getVolume().then((volume) => _setVolumeValue = volume);
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(' Game Volume '),
          backgroundColor: Colors.limeAccent,
        ),
        body: Column(
          children: [
            Text('Current volume: $_volumeListenerValue'),
            Row(
              children: [
                Text('Set Volume:'),
                Flexible(
                  child: Slider(
                    min: 0,
                    max: 1,
                    onChanged: (double value) {
                      _setVolumeValue = value;
                      VolumeController().setVolume(_setVolumeValue);
                      setState(() {});
                    },
                    value: _setVolumeValue,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () => VolumeController().muteVolume(),
              child: Text('Mute Volume'),
            ),
            TextButton(
              onPressed: () => VolumeController().maxVolume(),
              child: Text('Max Volume'),
            ),
          ],
        ),
      ),
    );
  }
}
