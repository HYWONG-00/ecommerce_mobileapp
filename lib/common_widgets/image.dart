import 'package:lottie/lottie.dart';

import '../../import.dart';

enum ImageType { asset, network, lottieAsset, lottieNetwork }

class WImageWidget extends StatelessWidget {
  const WImageWidget(
      {required this.imageType, required this.image, this.height, this.boxfit, super.key});

  final ImageType imageType;
  final String image;
  final double? height;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    Widget image = SizedBox();

    switch (imageType) {
      case ImageType.asset:
        image = Image.asset(this.image, height: height, fit: boxfit,
            errorBuilder: (context, error, stackTrace) {
         return Image.asset('assets/images/no_image.png');
        });
        break;
      case ImageType.network:
        image = Image.network(this.image, height: height, fit: boxfit,
            errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/no_image.png');
        });
        break;
      case ImageType.lottieAsset:
        image = Lottie.asset(this.image, height: height, fit: boxfit,
            errorBuilder: (context, error, stackTrace) {
          return Lottie.asset('assets/lotties/no_image.json');
        });
        break;
      case ImageType.lottieNetwork:
        image = Lottie.network(this.image, height: height, fit: boxfit,
            errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/lotties/no_image.json');
        });
        break;
    }

    return image;
  }
}