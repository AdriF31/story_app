import 'package:alice/alice.dart';

import '../core/app/app.dart';

class AliceSetup {
  AliceSetup() {
    alice = Alice(
      showNotification: true,
      showInspectorOnShake: true,
      maxCallsCount: 1000,
    );
  }
}
