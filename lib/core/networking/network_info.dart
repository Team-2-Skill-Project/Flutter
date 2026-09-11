import 'dart:io';

///* abstract class to get information about the network
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// implementation of NetworkInfo
class NetworkInfoImpl implements NetworkInfo {
  /// check if the device is connected to the internet
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}
