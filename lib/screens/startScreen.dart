import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/editProfile.dart';
import '../screens/instructionsScreen.dart';
import '../screens/leaderBoardScreen.dart';
import '../widgets/drawer_wid.dart';
// import '../widgets/darkmode.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  void instructionScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return InstructionScreen();
        },
      ),
    );
  }

  void editProfileScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return EditProfile();
        },
      ),
    );
  }

  void leaderBoardScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return LeaderBoard();
        },
      ),
    );
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
     Users player=Users(username:'',email: '',image: '',dob: '');
      final data=ref.watch(newUserDataProivder)??player;
    return AdvancedDrawer(
      backdropColor: Colors.black,
      controller: _advancedDrawerController,
      drawer: Menu(),
      child: Scaffold(
        backgroundColor: Colors.white,
       
        // AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.menu),
        //     onPressed: () => _advancedDrawerController.toggleDrawer(),
        //   ),
        //   backgroundColor: Colors.teal[200],
        //   centerTitle: true,
        //   title: const Text('Welcome to Object Hunt'),
        //   actions: [Switch(value: false, onChanged: (MyThemes) {})],
        // ),
        body:AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.red,
          Colors.redAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          Colors.redAccent,
          Colors.red,
        ],
        child:  ScaffoldLayoutBuilder(
          backgroundColorAppBar:
            const ColorBuilder(Colors.transparent, Colors.red),
        textColorAppBar: const ColorBuilder(Colors.white),
        appBarBuilder: _appBar,
          child: SingleChildScrollView(
            
             
                  child:Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.black,borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),

                    ), ),
                        child: Center(
                            
        child: Column(
          children: [
            SizedBox(height: 30,),
            AnimatedIconButton(
              size: 100,
              onPressed: () {},
              duration: const Duration(milliseconds: 500),
              splashColor: Colors.transparent,
              icons: const <AnimatedIconItem>[
                AnimatedIconItem(
                  icon: Icon(Icons.circle_rounded, color: Colors.red,),
                ),
                AnimatedIconItem(
                  icon: Icon(Icons.hide_source, color: Colors.red),
                ),
              ],
            ),
            
          
           DefaultTextStyle(
             style: const TextStyle(
               fontSize: 30.0,
               fontFamily: 'Agne',
             ),
             child: AnimatedTextKit(
               animatedTexts: [
                 TypewriterAnimatedText('Hi '+data.username+'!'),
                
               ],
               onTap: () {
                 print("Tap Event");
               },
             ),
           ),
          ],
        ),
        // AnimatedIconButton
      ),
                      ),
              
        
             
              Padding(
                padding: const EdgeInsets.fromLTRB(130.0,200,100,0),
                child: Container(
                  child: Column(children: [SizedBox(height: 100,),ElevatedButton(onPressed: ()=>instructionScreen(context), child: Text('Play Game'),style: ElevatedButton.styleFrom(backgroundColor: Colors.black)),ElevatedButton(onPressed: ()=>leaderBoardScreen(context), child: Text('Score Board'),style: ElevatedButton.styleFrom(backgroundColor: Colors.black)),]),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.36,
                  ),
                  height: 450,
                  decoration: const BoxDecoration(
                    
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    
                  ),
                ),
              ),
         
  

                   
                    ],
                  ),
              
              ),
          
          ),
      ), 
        
        
        
        
       
        ),
      
    );
  }
  Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
    return AppBar(
      backgroundColor: colorAnimated.background,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,50,0),
        child: Center(
          child: Text(
            "Object Hunt",
            style: TextStyle(
              color: colorAnimated.color,
            ),
          ),
        ),
      ),
      leading: IconButton(
          onPressed: ()=>_advancedDrawerController.toggleDrawer(),
        icon:Icon(Icons.menu),
        color: colorAnimated.color,
      ),
      
    );
  }

}
