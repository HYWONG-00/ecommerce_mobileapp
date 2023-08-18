import '../../import.dart';

class ErrorReloadWidget extends StatelessWidget{
  final VoidCallback action;
  final double? height, width;
  ErrorReloadWidget({super.key, required this.action, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () => action(),
      child: Ink(
                height: height ?? deviceHeight,
                width: width ?? deviceWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.refresh,
                      color: primary1,
                      size: 35,
                    ),
                    WTextWidget(
                      "Try again",
                    )
                  ],
                ),
              ),
    );
  }
}