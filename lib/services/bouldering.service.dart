import 'package:life/services/events.service.dart';

class BoulderingService extends EventsService {
  BoulderingService() : super();

  setHighestGrade(String documentId, String grade) {
    setMeta(documentId, {"highestGrade": grade});
  }
}
