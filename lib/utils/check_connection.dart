import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  Connectivity connectivity = Connectivity();
  ConnectivityResult connection = await connectivity.checkConnectivity();
  print(connection);
  if (connection == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
