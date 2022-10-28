import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';

class ArGameScreen extends StatefulWidget {
  
  @override
  _ArGameScreenState createState() => _ArGameScreenState();
}

class _ArGameScreenState extends State<ArGameScreen> {
late ARSessionManager arSessionManager;

late ARObjectManager arObjectManager;

ARNode? localObjectNode;

ARNode? webObjectNode;

void onARViewCreated(
   ARSessionManager arSessionManager,
   ARObjectManager arObjectManager,
   ARAnchorManager arAnchorManager,
   ARLocationManager arLocationManager) {
 // 1
 this.arSessionManager = arSessionManager;
 this.arObjectManager = arObjectManager;
 // 2
 this.arSessionManager.onInitialize(
       showFeaturePoints: false,
       showPlanes: true,
      //  customPlaneTexturePath: "triangle.png",
       showWorldOrigin: true,
       handleTaps: false,
     );
 // 3
 this.arObjectManager.onInitialize();
} 

  @override
  Widget build(BuildContext context) {
    return ARView(
 onARViewCreated: onARViewCreated,
);
  }
}