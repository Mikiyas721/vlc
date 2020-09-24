import 'package:rxdart/rxdart.dart';
import '../core/repository.dart';
import '../model/media.dart';

class AudioRepo extends ItemRepo<MediaModel> {
  AudioRepo(BehaviorSubject<MediaModel> subject) : super(subject);
}
