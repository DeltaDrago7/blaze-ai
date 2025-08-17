import 'package:blazemobile/widgets/level-map/paint/level_map_painter.dart';
import 'package:blazemobile/widgets/level-map/utils/load_ui_image_to_draw.dart';

import 'package:flutter/material.dart';

import 'model/current_level_painter.dart';
import 'model/images_to_paint.dart';
import 'model/level_map_params.dart';



class LevelMap extends StatelessWidget {
  final LevelMapParams levelMapParams;
  final Color backgroundColor;
  final bool scrollToCurrentLevel;
  final Widget Function(int level, bool isCompleted, bool isCurrent)? checkpointBuilder;
  final Size checkpointSize;

  const LevelMap({
    Key? key,
    required this.levelMapParams,
    this.backgroundColor = Colors.transparent,
    this.scrollToCurrentLevel = true,
    this.checkpointBuilder,
    this.checkpointSize = const Size(40, 40),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = LevelMapPainter(params: levelMapParams);
        final checkpointOffsets = painter.getCheckpointOffsets(
            Size(constraints.maxWidth, levelMapParams.levelCount * levelMapParams.levelHeight));

        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            controller: ScrollController(
                initialScrollOffset: (((scrollToCurrentLevel
                    ? (levelMapParams.levelCount -
                    levelMapParams.currentLevel +
                    2)
                    : levelMapParams.levelCount)) *
                    levelMapParams.levelHeight) -
                    constraints.maxHeight),
            child: ColoredBox(
              color: backgroundColor,
              child: FutureBuilder<ImagesToPaint?>(
                future: loadImagesToPaint(
                  levelMapParams,
                  levelMapParams.levelCount,
                  levelMapParams.levelHeight,
                  constraints.maxWidth,
                ),
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      CustomPaint(
                        size: Size(constraints.maxWidth,
                            levelMapParams.levelCount * levelMapParams.levelHeight),
                        painter: LevelMapPainter(
                          params: levelMapParams,
                          imagesToPaint: snapshot.data,
                        ),
                      ),
                      if (checkpointBuilder != null)
                        ...checkpointOffsets.asMap().entries.map((entry) {
                          final level = entry.key + 1;
                          final offset = entry.value;
                          final isCompleted = levelMapParams.currentLevel > level;
                          final isCurrent = level == levelMapParams.currentLevel.floor() &&
                              levelMapParams.currentLevel % 1 == 0;
                          return Positioned(
                            left: offset.dx - checkpointSize.width / 2,
                            bottom: -offset.dy - checkpointSize.height / 2,
                            child: checkpointBuilder!(level, isCompleted, isCurrent),
                          );
                        }).toList(),
                      IgnorePointer(
                        ignoring: true, // Ignore touch events
                        child: CustomPaint(
                          size: Size(constraints.maxWidth,
                              levelMapParams.levelCount * levelMapParams.levelHeight),
                          painter: CurrentLevelPainter(
                            params: levelMapParams,
                            imagesToPaint: snapshot.data,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;
}