import 'dart:math';

import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/floating_lottie_widget.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_path_painter.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapListWidget extends StatefulWidget {
  const RoadmapListWidget({super.key, required this.nodes});

  final List<RoadmapNode> nodes;

  /// Available Lottie animation assets for roadmap decoration
  static const List<String> lottieAssets = [
    'assets/lottie/graduation_hat.json',
    'assets/lottie/books_1.lottie.json',
    'assets/lottie/books_2.lottie.json',
  ];

  /// Normalized scale factors for each asset to maintain balanced visual footprint
  static const Map<String, double> assetScaleFactors = {
    'assets/lottie/graduation_hat.json': 2,
    'assets/lottie/books_1.lottie.json': 2,
    'assets/lottie/books_2.lottie.json': 2,
  };

  @override
  State<RoadmapListWidget> createState() => _RoadmapListWidgetState();
}

class _RoadmapListWidgetState extends State<RoadmapListWidget> {
  final GlobalKey _stackKey = GlobalKey();
  List<GlobalKey> _circleKeys = [];
  List<Offset> _nodeCenters = [];

  void _syncKeys(int count) {
    if (_circleKeys.length != count) {
      _circleKeys = List.generate(count, (_) => GlobalKey());
    }
  }

  void _updateNodeCenters() {
    if (!mounted) return;
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null || _circleKeys.isEmpty) return;

    final List<Offset> newCenters = [];
    for (final key in _circleKeys) {
      final circleBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (circleBox != null) {
        final localCenter = stackBox.globalToLocal(
          circleBox.localToGlobal(
            Offset(circleBox.size.width / 2, circleBox.size.height / 2),
          ),
        );
        newCenters.add(localCenter);
      }
    }

    if (newCenters.length == _circleKeys.length) {
      bool changed = _nodeCenters.length != newCenters.length;
      if (!changed) {
        for (int i = 0; i < newCenters.length; i++) {
          if ((_nodeCenters[i] - newCenters[i]).distance > 0.5) {
            changed = true;
            break;
          }
        }
      }
      if (changed) {
        setState(() {
          _nodeCenters = newCenters;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _syncKeys(widget.nodes.length);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateNodeCenters();
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final maxOffset = (screenWidth * 0.28).clamp(60.0.w, 120.0.w);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 16.w),
            child: Stack(
              key: _stackKey,
              clipBehavior: Clip.none,
              children: [
                // Layer 1: Old-map path CustomPaint
                Positioned.fill(
                  child: CustomPaint(
                    painter: RoadmapPathPainter(nodeCenters: _nodeCenters),
                  ),
                ),

                // Layer 2 & 3: Lottie Decorations & Task Nodes
                Column(
                  children: List.generate(widget.nodes.length, (index) {
                    final node = widget.nodes[index];
                    final horizontalShift = _calculateOrganicOffset(
                      index,
                      maxOffset,
                    );
                    final lottieWidget = _buildLottieDecoration(
                      index: index,
                      horizontalShift: horizontalShift,
                      maxOffset: maxOffset,
                      screenWidth: screenWidth,
                    );

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          // Task Node positioned along organic path
                          Transform.translate(
                            offset: Offset(horizontalShift, 0),
                            child: Center(
                              child: RoadmapTaskNode(
                                node: node,
                                circleKey: _circleKeys[index],
                                onTap: () => _onNodeTap(context, node),
                              ),
                            ),
                          ),

                          // Floating Lottie decoration in negative space
                          ?lottieWidget,
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Calculates a smooth, organic horizontal offset for each task node.
  double _calculateOrganicOffset(int index, double maxOffset) {
    final t = index.toDouble();
    final rawOffset = 0.65 * sin(t * 0.85) + 0.35 * sin(t * 0.45 + 0.8);
    final clamped = rawOffset.clamp(-1.0, 1.0);
    return clamped * maxOffset;
  }

  /// Builds a decorative Lottie animation centered in empty horizontal negative space.
  Widget? _buildLottieDecoration({
    required int index,
    required double horizontalShift,
    required double maxOffset,
    required double screenWidth,
  }) {
    final minSpaceThreshold = maxOffset * 0.35;
    if (horizontalShift.abs() < minSpaceThreshold) {
      return null;
    }

    if (index % 2 != 1 && index % 5 != 0) {
      return null;
    }

    final assetPath = RoadmapListWidget
        .lottieAssets[(index ~/ 2) % RoadmapListWidget.lottieAssets.length];
    final scaleFactor = RoadmapListWidget.assetScaleFactors[assetPath] ?? 1.0;

    final lottieSize = (screenWidth * 0.18).clamp(65.0.r, 88.0.r);

    final screenCenter = screenWidth / 2;
    final taskCenterX = screenCenter + horizontalShift;
    final taskHalfWidth = 70.0.w;

    double lottieLeft;

    if (horizontalShift > 0) {
      final taskLeftEdge = (taskCenterX - taskHalfWidth).clamp(
        0.0,
        screenWidth,
      );
      final emptySpaceCenter = taskLeftEdge / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    } else {
      final taskRightEdge = (taskCenterX + taskHalfWidth).clamp(
        0.0,
        screenWidth,
      );
      final emptySpaceCenter = (taskRightEdge + screenWidth) / 2;
      lottieLeft = emptySpaceCenter - (lottieSize / 2);
    }

    final minMargin = 12.w;
    final maxMargin = screenWidth - lottieSize - 12.w;
    lottieLeft = lottieLeft.clamp(minMargin, maxMargin);

    return Positioned(
      left: lottieLeft,
      child: IgnorePointer(
        child: FloatingLottieWidget(
          assetPath: assetPath,
          size: lottieSize,
          scaleFactor: scaleFactor,
        ),
      ),
    );
  }

  void _onNodeTap(BuildContext context, RoadmapNode node) {
    if (node.status == RoadmapTaskStatus.locked) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Complete the previous task first to unlock!',
            style: TextStyle(fontSize: 14.sp),
          ),
          backgroundColor: AppColors.secondary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) {
        return SkillDetailsSheet(node: node);
      },
    );
  }
}
