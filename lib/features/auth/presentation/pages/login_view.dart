import 'package:MatchIn/features/auth/presentation/widgets/login/login_footer.dart';
import 'package:MatchIn/features/auth/presentation/widgets/login/login_form.dart';
import 'package:MatchIn/features/auth/presentation/widgets/login/login_header.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = S.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.login,
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          children: [
            const LoginHeader(),
            SizedBox(height: 32.h),
            LoginForm(),
            SizedBox(height: 16.h),
            const LoginFooter(),
          ],
        ),
      ),
    );
  }
}
