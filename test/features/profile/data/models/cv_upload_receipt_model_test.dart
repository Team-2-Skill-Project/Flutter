import 'package:MatchIn/features/profile/data/models/cv_upload_receipt_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CvUploadReceiptModel.tryParseReceipt', () {
    test('parses a complete upload receipt', () {
      final receipt = CvUploadReceiptModel.tryParseReceipt({
        'message': 'CV uploaded successfully.',
        'data': {'id': 2, 'version': 2, 'status': 'processing'},
      });

      expect(receipt, isNotNull);
      expect(receipt!.id, 2);
      expect(receipt.version, 2);
      expect(receipt.status, 'processing');
    });

    test('returns null when data is missing', () {
      expect(CvUploadReceiptModel.tryParseReceipt({'message': 'ok'}), isNull);
    });

    test('returns null when id is missing or invalid', () {
      expect(
        CvUploadReceiptModel.tryParseReceipt({
          'data': {'version': 1},
        }),
        isNull,
      );
      expect(
        CvUploadReceiptModel.tryParseReceipt({
          'data': {'id': 0},
        }),
        isNull,
      );
    });

    test('returns null for non-map responses', () {
      expect(CvUploadReceiptModel.tryParseReceipt(null), isNull);
      expect(CvUploadReceiptModel.tryParseReceipt('ok'), isNull);
    });
  });
}
