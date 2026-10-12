import 'package:url_launcher/url_launcher.dart';

/// Opens a CV document URL through a platform-compatible mechanism.
///
/// Only absolute HTTP(S) URLs are considered viewable. Storage paths
/// and other backend-internal references are never treated as public
/// URLs. Returns false (never throws) when the document cannot be
/// opened so the UI can show localized feedback instead.
class CvDocumentViewer {
  const CvDocumentViewer._();

  static bool isViewable(String? url) {
    final trimmed = url?.trim() ?? '';
    if (trimmed.isEmpty) return false;
    final uri = Uri.tryParse(trimmed);
    if (uri == null) return false;
    if (uri.scheme != 'http' && uri.scheme != 'https') return false;
    return uri.host.isNotEmpty;
  }

  static Future<bool> open(String? url) async {
    if (!isViewable(url)) return false;
    try {
      return await launchUrl(
        Uri.parse(url!.trim()),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      return false;
    }
  }
}
