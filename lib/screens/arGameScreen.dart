import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';

import '../screens/seekerScreen.dart';

class ArGameScreen extends StatefulWidget {
  
  @override
  _ArGameScreenState createState() => _ArGameScreenState();
}

class _ArGameScreenState extends State<ArGameScreen> {
  
  void popScreen(BuildContext ctx){
  Navigator.of(ctx).pop(ctx);
}

    void seekerScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return SeekerScreen();
  },),);
}
// for managing the configurations of session, parameters, and events
late ARSessionManager arSessionManager;

// manage all node actions
late ARObjectManager arObjectManager;

// for the position of the object
ARNode? localObjectNode;

ARNode? webObjectNode;

void onARViewCreated(
  
   ARSessionManager arSessionManager,
   ARObjectManager arObjectManager,
   ARAnchorManager arAnchorManager,
   // to get the current location of the device
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
    return Scaffold(
         appBar: AppBar(
        title: Text('Object Hunt'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: ARView(
                  onARViewCreated: onARViewCreated,
                  permissionPromptDescription: '',
                ),
              ),
            ),
            
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        popScreen(context); 
                        seekerScreen(context);},
                      child: const Text('End Turn')),
                ),
                const SizedBox(
                  width: 10,
                ),
              
              ],
            ),
          
        ),
      
    );
  }
}