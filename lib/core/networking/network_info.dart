import 'dart:async';
import 'dart:io';

///* abstract class to get information about the network
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

///* implementation of NetworkInfo
///* Checks connectivity by trying to resolve multiple well-known hosts.
///* Using a fallback list avoids relying on a single host (e.g. google.com
///* may be blocked in some regions). Each attempt has a 5-second timeout.
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    const hosts = ['google.com', 'cloudflare.com', 'apple.com'];

    for (final host in hosts) {
      try {
        final result = await InternetAddress.lookup(host)
            .timeout(const Duration(seconds: 5));

        if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException {
        continue;
      } on TimeoutException {
        continue;
      }
    }

    return false;
  }
}
