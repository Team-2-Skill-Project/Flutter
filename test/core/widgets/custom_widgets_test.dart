import 'package:MatchIn/core/widgets/custom_app_bar.dart';
import 'package:MatchIn/core/widgets/custom_button.dart';
import 'package:MatchIn/core/widgets/custom_loading_widget.dart';
import 'package:MatchIn/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrapWithScreenUtil(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MaterialApp(
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('CustomButton Tests', () {
    testWidgets('renders text and responds to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        _wrapWithScreenUtil(
          CustomButton(
            text: 'Submit',
            onPressed: () => tapped = true,
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
      await tester.tap(find.text('Submit'));
      expect(tapped, isTrue);
    });

    testWidgets('displays loading indicator and ignores tap when isLoading is true', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        _wrapWithScreenUtil(
          CustomButton(
            text: 'Submit',
            isLoading: true,
            onPressed: () => tapped = true,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Submit'), findsNothing);
      await tester.tap(find.byType(CustomButton));
      expect(tapped, isFalse);
    });
  });

  group('CustomTextField Tests', () {
    testWidgets('renders label and hint, and toggles password visibility', (tester) async {
      final controller = TextEditingController(text: 'secret123');

      await tester.pumpWidget(
        _wrapWithScreenUtil(
          CustomTextField(
            controller: controller,
            labelText: 'Password',
            hintText: 'Enter password',
            isPassword: true,
          ),
        ),
      );

      expect(find.text('Password'), findsOneWidget);
      // Initially obscured -> shows visibility_off icon
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      // Tap visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pumpAndSettle();

      // Now revealed -> shows visibility icon
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });
  });

  group('CustomAppBar Tests', () {
    testWidgets('renders title and back button', (tester) async {
      await tester.pumpWidget(
        _wrapWithScreenUtil(
          const CustomAppBar(
            title: 'Verify Code',
          ),
        ),
      );

      expect(find.text('Verify Code'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);
    });
  });

  group('CustomLoadingWidget Tests', () {
    testWidgets('renders loading indicator and optional message', (tester) async {
      await tester.pumpWidget(
        _wrapWithScreenUtil(
          const CustomLoadingWidget(
            message: 'Loading data...',
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading data...'), findsOneWidget);
    });
  });
}
