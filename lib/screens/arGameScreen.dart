import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArGameScreen extends StatefulWidget {
  
  @override
  _ArGameScreenState createState() => _ArGameScreenState();
}

class _ArGameScreenState extends State<ArGameScreen> {
  
   ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
          enableUpdateListener:true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {


    arCoreController = controller;
    arCoreController!.onNodeTap = (name) => onTapHandler(name);
    arCoreController!.onPlaneTap = _handleOnPlaneTap;
    
  }
  void _addSphere() {
    final material = ArCoreMaterial(
      color: Colors.yellow,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final sphereNode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    arCoreController?.addArCoreNode(sphereNode);
  }

   void onTapHandler(String name) {
  arCoreController?.removeNode(nodeName: '$name');
    
  }

void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
      for(int i=0;i<10;i++){
    print('Ahmed');
    }

    final hit = hits.first;
    final material = ArCoreMaterial(
      color: Colors.red,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final sphereNode = ArCoreNode(
      shape: sphere,
      position: hit.pose.translation + vector.Vector3(0, 0, 0),
    );
    arCoreController?.addArCoreNode(sphereNode);


    
    
    final moonMaterial = ArCoreMaterial(color: Colors.blue);
    
    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );
    
    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final earthMaterial = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244),);
    
    final earthShape = ArCoreCube(
      materials: [earthMaterial],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    
    final earth = ArCoreNode(
        shape: earthShape,
        children: [moon],
        position: hit.pose.translation + vector.Vector3(0.0, 1.0, 0.0),
        rotation: hit.pose.rotation);

    arCoreController!.addArCoreNodeWithAnchor(earth);
    arCoreController!.addArCoreNode(earth);
    arCoreController!.addArCoreNodeWithAnchor(moon);
    arCoreController!.addArCoreNode(moon);
    arCoreController?.addArCoreNode(earth);
    arCoreController?.addArCoreNode(moon);
  }

  

  @override
  void dispose() {
    arCoreController!.dispose();
    super.dispose();
  }
}