import 'package:get_it/get_it.dart';
import '../dataSource/audioDataSource.dart';
import '../core/utils/disposable.dart';
import '../model/media.dart';

class AudioBloc extends Disposable {
  AudioRepo _audioRepo = GetIt.instance.get();

  onAudioUrlEntered(String newValue) {
    _audioRepo.updateStream(MediaModel(mediaPath: newValue));
  }

  String get currentUrl => _audioRepo.subjectValue.mediaPath;

  @override
  void dispose() {}
}
