import '../import.dart';

class WInputTextWidget extends StatelessWidget{
  TextEditingController controller;
  EdgeInsets? padding;
  IconData? iconBefore, iconAfter;
  String? hintText;
  Color? color;

  //FocusNode
  WInputTextWidget(this.controller, {
    this.padding,
    this.iconBefore,
    this.iconAfter,
    this.hintText,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: ShapeDecoration(
        color: text2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      padding: padding ?? EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText != null ? hintText : "",
          prefixIcon: iconBefore != null ? Icon(iconBefore) : null,
          suffixIcon: iconAfter != null ? Icon(iconAfter) : null,
        ),
        
      ),
    );
  }
}