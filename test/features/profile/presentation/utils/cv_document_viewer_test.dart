import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/cv_widgets/cv_document_viewer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CvDocumentViewer.isViewable', () {
    test('accepts http and https URLs', () {
      expect(
        CvDocumentViewer.isViewable('https://cdn.example.com/cv.pdf'),
        isTrue,
      );
      expect(
        CvDocumentViewer.isViewable('http://cdn.example.com/cv.docx'),
        isTrue,
      );
    });

    test('rejects missing or blank URLs', () {
      expect(CvDocumentViewer.isViewable(null), isFalse);
      expect(CvDocumentViewer.isViewable(''), isFalse);
      expect(CvDocumentViewer.isViewable('   '), isFalse);
    });

    test('rejects storage paths and non-web schemes', () {
      expect(CvDocumentViewer.isViewable('cvs/user-1/cv.pdf'), isFalse);
      expect(CvDocumentViewer.isViewable('/var/storage/cv.pdf'), isFalse);
      expect(
        CvDocumentViewer.isViewable('ftp://cdn.example.com/cv.pdf'),
        isFalse,
      );
      expect(CvDocumentViewer.isViewable('file:///cv.pdf'), isFalse);
    });
  });

  group('CvDocumentViewer.open', () {
    test('returns false without attempting launch for unusable URLs', () async {
      expect(await CvDocumentViewer.open(null), isFalse);
      expect(await CvDocumentViewer.open('cvs/user-1/cv.pdf'), isFalse);
    });
  });
}
