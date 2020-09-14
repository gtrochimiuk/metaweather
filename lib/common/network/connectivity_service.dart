import 'package:data_connection_checker/data_connection_checker.dart';

class ConnectivityService {
  Future<bool> get hasConnection => DataConnectionChecker().hasConnection;
}
