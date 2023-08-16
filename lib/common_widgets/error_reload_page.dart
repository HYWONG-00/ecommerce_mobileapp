import '../../import.dart';

class ErrorReloadPageWidget extends StatelessWidget{
  final VoidCallback action;
  
  ErrorReloadPageWidget({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () => action(),
      child: Ink(
                height: deviceHeight,
                width: deviceWidth,
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