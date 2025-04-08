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

  Future<XFile?> getImage({required bool fromGallery}) async {
    return _picker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 50,
    );
  }
}
