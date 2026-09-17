import 'package:flutter/material.dart';
import 'package:MatchIn/core/extensions/context_extensions.dart';
import 'package:MatchIn/core/widgets/empty/app_empty.dart';

class AiChatView extends StatelessWidget {
  const AiChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.chatBot)),
      body: AppEmptyWidget(
        icon: Icons.smart_toy_rounded,
        title: context.l10n.chatBot,
        message: 'AI Assistant feature is coming soon!',
      ),
    );
  }
}
