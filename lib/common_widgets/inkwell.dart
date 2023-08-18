import '../import.dart';

class WInkWellWidget extends StatelessWidget{
  Function action;
  Widget content;

  //FocusNode
  WInkWellWidget(this.action, {required this.content});

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        action();
      },
      child: Ink(
        child: content,
      ),
    );
  }
}