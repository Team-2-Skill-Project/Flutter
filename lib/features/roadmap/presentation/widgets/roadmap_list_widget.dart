import 'dart:math';

import 'package:MatchIn/core/utils/app_colors.dart';
import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/manager/roadmap_cubit/roadmap_cubit.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/floating_lottie_widget.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/roadmap_path_painter.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/skill_details_sheet.dart';
import 'package:MatchIn/features/roadmap/presentation/widgets/treasure_box_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoadmapListWidget extends StatefulWidget {
  const RoadmapListWidget({
    super.key,
    required this.nodes,
    this.collectedTreasures = const {},
  });

  final List<RoadmapNode> nodes;
  final Set<int> collectedTreasures;

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

class _RoadmapItem {
  _RoadmapItem.node(this.node, this.taskIndex)
      : milestoneIndex = null,
        targetNodeIndex = null;
  _RoadmapItem.treasure(this.milestoneIndex, this.targetNodeIndex)
      : node = null,
        taskIndex = null;

  final RoadmapNode? node;
  final int? taskIndex;
  final int? milestoneIndex;
  final int? targetNodeIndex;

  bool get isTreasure => milestoneIndex != null;
}

class _RoadmapListWidgetState extends State<RoadmapListWidget> {
  final GlobalKey _stackKey = GlobalKey();
  List<GlobalKey> _circleKeys = [];
  List<Offset> _nodeCenters = [];

  List<_RoadmapItem> _buildRoadmapItems(List<RoadmapNode> nodes) {
    final List<_RoadmapItem> items = [];
    for (int i = 0; i < nodes.length; i++) {
      items.add(_RoadmapItem.node(nodes[i], i));
      if ((i + 1) % 5 == 0) {
        final milestoneIndex = (i + 1) ~/ 5;
        items.add(_RoadmapItem.treasure(milestoneIndex, i));
      }
    }
    return items;
  }

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
    final items = _buildRoadmapItems(widget.nodes);
    _syncKeys(items.length);

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
                // Layer 1: Lighter theme path CustomPaint
                Positioned.fill(
                  child: CustomPaint(
                    painter: RoadmapPathPainter(nodeCenters: _nodeCenters),
                  ),
                ),

                // Layer 2 & 3: Lottie Decorations, Task Nodes & Treasure Milestones
                Column(
                  children: List.generate(items.length, (itemIndex) {
                    final item = items[itemIndex];
                    final horizontalShift = _calculateOrganicOffset(
                      itemIndex,
                      maxOffset,
                    );
                    final lottieWidget = _buildLottieDecoration(
                      index: itemIndex,
                      horizontalShift: horizontalShift,
                      maxOffset: maxOffset,
                      screenWidth: screenWidth,
                    );

                    Widget childWidget;
                    if (item.isTreasure) {
                      final milestoneIndex = item.milestoneIndex!;
                      final targetIndex = item.targetNodeIndex!;
                      final isUnlocked = targetIndex < widget.nodes.length &&
                          widget.nodes[targetIndex].status ==
                              RoadmapTaskStatus.completed;
                      final isClaimed = widget.collectedTreasures
                          .contains(milestoneIndex);

                      childWidget = TreasureBoxNodeWidget(
                        milestoneIndex: milestoneIndex,
                        isUnlocked: isUnlocked,
                        isClaimed: isClaimed,
                        circleKey: _circleKeys[itemIndex],
                        onClaimSuccess: () => _onTreasureClaimSuccess(
                          context: context,
                          milestoneIndex: milestoneIndex,
                        ),
                        onLockedTap: () => _onTreasureLockedTap(
                          context: context,
                          targetNodeIndex: targetIndex,
                        ),
                      );
                    } else {
                      final node = item.node!;
                      childWidget = RoadmapTaskNode(
                        node: node,
                        circleKey: _circleKeys[itemIndex],
                        onTap: () => _onNodeTap(context, node),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          // Item positioned along organic path
                          Transform.translate(
                            offset: Offset(horizontalShift, 0),
                            child: Center(
                              child: childWidget,
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

  /// Calculates a smooth, organic horizontal offset for each item along the curve.
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

  void _onTreasureClaimSuccess({
    required BuildContext context,
    required int milestoneIndex,
  }) {
    // Grant reward in Cubit & persistence
    try {
      context.read<RoadmapCubit>().claimTreasureReward(milestoneIndex);
    } catch (_) {}

    // Show SnackBar ONCE upon initial successful collection
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.card_giftcard_rounded, color: Colors.white, size: 20.r),
            SizedBox(width: 8.w),
            Text(
              '🎉 Milestone Claimed! +50 XP Added!',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  void _onTreasureLockedTap({
    required BuildContext context,
    required int targetNodeIndex,
  }) {
    final requiredNodeNumber = targetNodeIndex + 1;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.lock_rounded, color: Colors.white, size: 20.r),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Complete task #$requiredNodeNumber to unlock this +50 XP milestone!',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
