import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:MatchIn/core/utils/app_colors.dart';

///\* Generic reusable in-app WebView component located in `core/widgets/`.
class AppWebView extends StatefulWidget {
  const AppWebView({super.key, required this.url, this.title});

  final String url;
  final String? title;

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  InAppWebViewController? _webViewController;
  double _progress = 0.0;
  bool _hasError = false;
  String _errorMessage = '';

  Future<void> _openInBrowser() async {
    try {
      final uri = WebUri(widget.url);
      await InAppBrowser.openWithSystemBrowser(url: uri);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not open browser for ${widget.url}',
            style: TextStyle(fontSize: 14.sp),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _reloadPage() {
    setState(() {
      _hasError = false;
      _errorMessage = '';
      _progress = 0.0;
    });
    _webViewController?.reload();
  }

  @override
  Widget build(BuildContext context) {
    final displayTitle = widget.title ?? 'Resource';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondary,
            size: 20.r,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          displayTitle,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: 'Open in Browser',
            icon: Icon(
              Icons.open_in_browser_rounded,
              color: AppColors.secondary,
              size: 22.r,
            ),
            onPressed: _openInBrowser,
          ),
        ],
        bottom: _progress < 1.0 && !_hasError
            ? PreferredSize(
                preferredSize: Size.fromHeight(3.h),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: AppColors.surfaceVariant,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              )
            : null,
      ),
      body: SafeArea(child: _hasError ? _buildErrorView() : _buildWebView()),
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.url)),
      initialSettings: InAppWebViewSettings(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        javaScriptEnabled: true,
      ),
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onProgressChanged: (controller, progress) {
        if (!mounted) return;
        setState(() {
          _progress = progress / 100;
        });
      },
      onReceivedError: (controller, request, error) {
        if (!mounted) return;
        if (request.isForMainFrame == true) {
          setState(() {
            _hasError = true;
            _errorMessage = error.description;
          });
        }
      },
      onReceivedHttpError: (controller, request, response) {
        if (!mounted) return;
        if (request.isForMainFrame == true &&
            (response.statusCode ?? 0) >= 400) {
          setState(() {
            _hasError = true;
            _errorMessage = 'HTTP Error ${response.statusCode}';
          });
        }
      },
    );
  }

  Widget _buildErrorView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: const BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 48.r,
                color: AppColors.error,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Unable to load this page',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              _errorMessage.isNotEmpty
                  ? _errorMessage
                  : 'Please check your internet connection.',
              style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: _reloadPage,
                  icon: Icon(Icons.refresh_rounded, size: 18.r),
                  label: const Text('Try Again'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondary,
                    side: const BorderSide(color: AppColors.secondary),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                ElevatedButton.icon(
                  onPressed: _openInBrowser,
                  icon: Icon(Icons.open_in_new_rounded, size: 18.r),
                  label: const Text('Open in Browser'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.textSecondary,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
