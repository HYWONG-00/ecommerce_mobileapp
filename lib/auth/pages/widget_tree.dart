import 'package:firebase_flutter/home/controllers/home_ctrl.dart';

import '../../import.dart';

import '../auth.dart';

class WidgetTree extends StatefulWidget{
  @override
  State<WidgetTree> createState() => _WidgetTreeState();

}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: AuthCtrl().authStateChanges,
      builder:(context, snapshot) {
        //if there is user in snapshot
        if(snapshot.hasData){
          appDebugLog("Logger is working! ${snapshot}");
          
          Get.put(HomeCtrl());
          return HomePage();
        } else{
          appErrorLog(snapshot);
          return const LoginPage();
        }
      },
    );
  }
}