import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_picker_service.g.dart';

@riverpod
MediaPickerService mediaPicker(Ref ref) {
  final picker = ImagePicker();
  return MediaPickerService(picker: picker);
}

class MediaPickerService {
  const MediaPickerService({required ImagePicker picker}) : _picker = picker;
  final ImagePicker _picker;

  Future<XFile?> getImage([
    MenoImageSource source = MenoImageSource.gallery,
  ]) async {
    return _picker.pickImage(
      imageQuality: 50,
      source: switch (source) {
        MenoImageSource.camera => ImageSource.camera,
        MenoImageSource.gallery => ImageSource.gallery,
      },
    );
  }
}

/// Specifies the source where the picked image should come from.
enum MenoImageSource {
  /// Opens up the device camera, letting the user to take a new picture.
  camera,

  /// Opens the user's photo gallery.
  gallery,
}

extension MenoImageSourceX on MenoImageSource {
  String get name {
    return switch (this) {
      MenoImageSource.camera => 'Camera',
      MenoImageSource.gallery => 'Gallery',
    };
  }
}
