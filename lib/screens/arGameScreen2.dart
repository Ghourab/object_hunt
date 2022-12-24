
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';

class ArGameScreen2 extends StatefulWidget {
  final List value;
  const ArGameScreen2({Key? key, required this.value}) : super(key: key);
  @override
  _ArGameScreen2State createState() => _ArGameScreen2State(this.value);
}

class _ArGameScreen2State extends State<ArGameScreen2> {

  void popScreen(BuildContext ctx){
  Navigator.of(ctx).pop(ctx);
}

   List value;
   int score=0;
  _ArGameScreen2State(this.value);
   ArCoreController? arCoreController;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: ArCoreView(

          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
          enableUpdateListener:true,
        ),
        bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0, child:Row(children:[Text('score: 10'),])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    

      );
  }
  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

      final material = ArCoreMaterial(
      color: Colors.yellow,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
     final sphereNode = ArCoreNode(
      shape: sphere,
      position: value[1],
    );
    arCoreController?.addArCoreNode(sphereNode);
    
    arCoreController!.onNodeTap = (name) => onTapHandler(name);
    
    
  }
     void onTapHandler(String name) {
  arCoreController?.removeNode(nodeName: '$name');
  score+=10;
    
  }
}