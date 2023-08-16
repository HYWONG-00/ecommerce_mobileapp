import '../import.dart';

class WTextWidget extends StatelessWidget{
  final String content;
  final int? fontWeight;
  final double? fontSize, height;
  final Color? color;

  const WTextWidget(this.content, {
    super.key,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.height
  });
  
   

  @override
  Widget build(BuildContext context) {
    FontWeight weight = FontWeight.w500;
    TextAlign align = TextAlign.left;

    switch (fontWeight){
      case 1:
        weight = FontWeight.w100;
        break;
      case 2:
        weight = FontWeight.w200;
        break;
      case 3:
        weight = FontWeight.w300;
        break;
      case 4:
        weight = FontWeight.w400;
        break;
      case 5:
        weight = FontWeight.w500;
        break;
      case 6:
        weight = FontWeight.w600;
        break;
      case 7:
        weight = FontWeight.w700;
        break;
      case 8:
        weight = FontWeight.w800;
        break;
      case 9:
        weight = FontWeight.w900;
        break;
      default: 
        break;
    }   

    return Text(
      content,
      style: TextStyle(
        color: color ?? text1,
        fontSize: fontSize ?? 13,
        height: height ?? 1,
        fontWeight: weight
      ),
    );
  }
  
}