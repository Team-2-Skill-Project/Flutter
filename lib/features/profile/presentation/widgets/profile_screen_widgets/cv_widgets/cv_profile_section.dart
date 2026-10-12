import 'package:MatchIn/core/services/file_picker_service.dart';
import 'package:MatchIn/core/services/services_locator.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_document_entity.dart';
import 'package:MatchIn/features/profile/domain/entities/cv_upload_input.dart';
import 'package:MatchIn/features/profile/presentation/cubits/cv_cubit/cv_upload_cubit.dart';
import 'package:MatchIn/features/profile/presentation/cubits/cv_cubit/cv_upload_state.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:MatchIn/features/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/cv_widgets/cv_document_viewer.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/cv_widgets/cv_file_validator.dart';
import 'package:MatchIn/features/profile/presentation/widgets/profile_screen_widgets/cv_widgets/cv_profile_card.dart';
import 'package:MatchIn/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bridges the Main Profile CV card with the upload flow.
///
/// The displayed CV metadata always comes from [cvDocument] (Main
/// Profile state, remote + cache). [CvUploadCubit] only tracks the
/// upload request itself, so a failed replacement never disturbs
/// the existing card.
class CvProfileSection extends StatelessWidget {
  const CvProfileSection({required this.cvDocument, super.key});

  final CvDocumentEntity? cvDocument;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickAndUpload(BuildContext context) async {
    final cubit = context.read<CvUploadCubit>();
    if (cubit.state is CvUploading) return;
    final locale = S.of(context);

    final file = await getIt<FilePickerService>().pickCvBytes();
    if (!context.mounted) return;
    // User dismissed the picker: stay silent.
    if (file == null) return;

    final error = CvFileValidator.validate(
      fileName: file.name,
      sizeBytes: file.bytes.length,
      hasContent: file.bytes.isNotEmpty,
      unsupportedMessage: locale.cvUnsupportedFileType,
      tooLargeMessage: locale.cvFileTooLarge,
      emptyMessage: locale.cvEmptyFile,
    );
    if (error != null) {
      _showMessage(context, error);
      return;
    }

    await cubit.upload(
      CvUploadInput(
        fileName: file.name,
        extension: CvFileValidator.extensionOf(file.name),
        sizeBytes: file.bytes.length,
        bytes: file.bytes,
      ),
    );
  }

  Future<void> _view(BuildContext context, String? url) async {
    if (!CvDocumentViewer.isViewable(url)) {
      _showMessage(context, S.of(context).cvViewFailed);
      return;
    }
    final opened = await CvDocumentViewer.open(url);
    if (!context.mounted) return;
    if (!opened) {
      _showMessage(context, S.of(context).cvViewFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CvUploadCubit>(
      create: (_) => getIt<CvUploadCubit>(),
      child: Builder(
        builder: (context) => BlocConsumer<CvUploadCubit, CvUploadState>(
          listener: (context, state) async {
            final locale = S.of(context);
            if (state is CvUploadFailure) {
              final message = state.message.trim().isEmpty
                  ? locale.somethingWentWrong
                  : state.message;
              _showMessage(context, message);
              return;
            }
            if (state is CvUploadSuccess) {
              _showMessage(context, locale.cvUploadSuccessful);
              await context.read<ProfileCubit>().getCandidateProfile();
              if (!context.mounted) return;
              if (context.read<ProfileCubit>().state is ProfileFailure) {
                _showMessage(context, locale.cvRefreshFailed);
              }
            }
          },
          builder: (context, state) {
            final uploading = state is CvUploading;
            final document = cvDocument;
            return CvProfileCard(
              hasCv: document?.fileName != null || document?.fileUrl != null,
              fileName: document?.fileName,
              status: document?.status,
              updatedText: document?.updatedAt,
              onUpload: uploading ? null : () => _pickAndUpload(context),
              onView: uploading
                  ? null
                  : () => _view(context, document?.fileUrl),
              onReplace: uploading ? null : () => _pickAndUpload(context),
            );
          },
        ),
      ),
    );
  }
}
