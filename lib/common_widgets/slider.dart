import '../import.dart';

class WSliderWidget extends StatelessWidget{
  final bool scrollVertical;
  final List<Widget> children;

  const WSliderWidget({
    this.scrollVertical = true,//0 = vertical, 1 = horizontal
    required this.children
  });
  

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollVertical ? Axis.vertical : Axis.horizontal,
      children: children,
    );
  }
}