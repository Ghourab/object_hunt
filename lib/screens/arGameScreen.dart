import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:object_hunt/screens/leaderBoardScreen.dart';
import 'package:object_hunt/screens/readyScreen.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArGameScreen extends StatefulWidget {
  
  @override
  _ArGameScreenState createState() => _ArGameScreenState();
}

class _ArGameScreenState extends State<ArGameScreen> {
  
    void readyScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return ReadyScreen();
  },),);
}
    void leaderBoardScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return LeaderBoard();
  },),);
}

void popScreen(BuildContext ctx){
  Navigator.of(ctx).pop(ctx);
}
 
   ArCoreController? arCoreController;
  var role='Hider';
  int score=0;
  bool _isVisible = false;
  List<dynamic> locations=[0];
  
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        
        body: ArCoreView(
          onArCoreViewCreated: role=='Hider'?_onArCoreViewCreated:_onArCoreViewCreated2,
          enableTapRecognizer: true,
          enableUpdateListener:true,
        ),
        bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Visibility(visible: _isVisible, child: Container(height: 50.0, child:Row(children:[Text('Score ${score.toString()}'),]))),
      ),
        floatingActionButton: FloatingActionButton(onPressed: role=='Hider'?(){role='Seeker'; readyScreen(context); _isVisible=true;
     }:(){leaderBoardScreen(context);},child: Center(child: Text('End Turn')),),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    
  }

  void _onArCoreViewCreated(ArCoreController controller) {

    
    arCoreController = controller;
  
    arCoreController!.onPlaneTap = _handleOnPlaneTap;
    arCoreController!.onNodeTap = (name) => onTapHandler(name);
  }
  void _onArCoreViewCreated2(ArCoreController controller) {

    
    arCoreController = controller;
  
    arCoreController!.onNodeTap = (name) => onTapHandler(name);
    
  }
     void onTapHandler(String name) {
      if(role=='Seeker'){
  arCoreController?.removeNode(nodeName: '$name');
  score+=10;
      }
    setState((){});
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

   

void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
      if(role=='Hider'){
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
      position: hit.pose.translation,
    );
    arCoreController?.addArCoreNode(sphereNode);
    locations.add(hit.pose.translation);
    
      }
    
    // final moonMaterial = ArCoreMaterial(color: Colors.blue);
    
    // final moonShape = ArCoreSphere(
    //   materials: [moonMaterial],
    //   radius: 0.03,
    // );
    
    // final moon = ArCoreNode(
    //   shape: moonShape,
    //   position: vector.Vector3(0.2, 0, 0),
    //   rotation: vector.Vector4(0, 0, 0, 0),
    // );

    // final earthMaterial = ArCoreMaterial(
    //     color: Color.fromARGB(120, 66, 134, 244),);
    
    // final earthShape = ArCoreCube(
    //   materials: [earthMaterial],
    //   size: vector.Vector3(0.5, 0.5, 0.5),
    // );
    
    // final earth = ArCoreNode(
    //     shape: earthShape,
    //     children: [moon],
    //     position: hit.pose.translation + vector.Vector3(0.0, 1.0, 0.0),
    //     rotation: hit.pose.rotation);

    // arCoreController!.addArCoreNodeWithAnchor(earth);
    // arCoreController!.addArCoreNode(earth);
    // arCoreController!.addArCoreNodeWithAnchor(moon);
    // arCoreController!.addArCoreNode(moon);
    // arCoreController?.addArCoreNode(earth);
    // arCoreController?.addArCoreNode(moon);
  }

}