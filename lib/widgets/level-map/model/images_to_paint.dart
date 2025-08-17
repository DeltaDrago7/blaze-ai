
import 'bg_image.dart';
import 'image_details.dart';

class ImagesToPaint {
  final List<BGImage>? bgImages;
  final ImageDetails? startLevelImage;
  final ImageDetails currentLevelImage;
  final ImageDetails? pathEndImage;

  ImagesToPaint({
    required this.currentLevelImage,
    this.bgImages,
    this.startLevelImage,
    this.pathEndImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesToPaint &&
          runtimeType == other.runtimeType &&
          bgImages == other.bgImages &&
          startLevelImage == other.startLevelImage &&
          currentLevelImage == other.currentLevelImage &&
          pathEndImage == other.pathEndImage;

  @override
  int get hashCode =>
      bgImages.hashCode ^
      startLevelImage.hashCode ^
      currentLevelImage.hashCode ^
      pathEndImage.hashCode;
}
