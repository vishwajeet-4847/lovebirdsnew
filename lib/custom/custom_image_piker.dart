import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  static Future<String?> pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);

      if (image != null) {
        return image.path;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<XFile>> pickMultipleVideos(ImageSource imageSource) async {
    final picker = ImagePicker();
    List<XFile> videos = [];

    bool keepPicking = true;

    while (keepPicking) {
      try {
        final video = await picker.pickVideo(source: imageSource);

        if (video != null) {
          videos.add(video);
        } else {
          // User cancelled → stop picking
          keepPicking = false;
        }
      } catch (e) {
        keepPicking = false;
      }
    }

    return videos;
  }

  // static Future<String?> pickVideo(ImageSource imageSource) async {
  //   try {
  //     final video = await ImagePicker().pickVideo(source: imageSource);
  //
  //     if (video != null) {
  //       return video.path;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
