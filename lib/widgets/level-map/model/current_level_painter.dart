import 'package:blazemobile/widgets/level-map/utils/image_offset_extension.dart';
import 'package:flutter/material.dart';

import '../model/image_details.dart';
import '../model/images_to_paint.dart';
import '../model/level_map_params.dart';

class CurrentLevelPainter extends CustomPainter {
  final LevelMapParams params;
  final ImagesToPaint? imagesToPaint;
  final double _nextLevelFraction;

  CurrentLevelPainter({required this.params, this.imagesToPaint})
      : _nextLevelFraction =
  params.currentLevel.remainder(params.currentLevel.floor());

  @override
  void paint(Canvas canvas, Size size) {
    if (imagesToPaint == null || imagesToPaint!.currentLevelImage == null) return;

    canvas.save();
    canvas.translate(0, size.height);

    final double _centerWidth = size.width / 2;
    double _p2_dx_VariationFactor =
        params.firstCurveReferencePointOffsetFactor!.dx;
    double _p2_dy_VariationFactor =
        params.firstCurveReferencePointOffsetFactor!.dy;

    for (int thisLevel = 0; thisLevel < params.levelCount; thisLevel++) {
      final Offset p1 = Offset(_centerWidth, -(thisLevel * params.levelHeight));
      final Offset p2 = _getP2OffsetBasedOnCurveSide(thisLevel,
          _p2_dx_VariationFactor, _p2_dy_VariationFactor, _centerWidth);
      final Offset p3 = Offset(_centerWidth,
          -((thisLevel * params.levelHeight) + params.levelHeight));

      final int _flooredCurrentLevel = params.currentLevel.floor();
      double _curveFraction;
      if (_flooredCurrentLevel - 1 == thisLevel && _nextLevelFraction <= 0.5) {
        _curveFraction = 0.5 + _nextLevelFraction;
      } else if (_flooredCurrentLevel - 1 == thisLevel - 1 && _nextLevelFraction > 0.5) {
        _curveFraction = _nextLevelFraction - 0.5;
      } else {
        if (params.enableVariationBetweenCurves) {
          _p2_dx_VariationFactor = _p2_dx_VariationFactor +
              params.curveReferenceOffsetVariationForEachLevel[thisLevel].dx;
          _p2_dy_VariationFactor = _p2_dy_VariationFactor +
              params.curveReferenceOffsetVariationForEachLevel[thisLevel].dy;
        }
        continue;
      }

      final Offset _offsetToPaintCurrentLevelImage = Offset(
          _compute(_curveFraction, p1.dx, p2.dx, p3.dx),
          _compute(_curveFraction, p1.dy, p2.dy, p3.dy));
      _paintImage(
          canvas,
          imagesToPaint!.currentLevelImage!,
          _offsetToPaintCurrentLevelImage
              .toBottomCenter(imagesToPaint!.currentLevelImage!.size));

      if (params.enableVariationBetweenCurves) {
        _p2_dx_VariationFactor = _p2_dx_VariationFactor +
            params.curveReferenceOffsetVariationForEachLevel[thisLevel].dx;
        _p2_dy_VariationFactor = _p2_dy_VariationFactor +
            params.curveReferenceOffsetVariationForEachLevel[thisLevel].dy;
      }
    }

    canvas.restore();
  }

  Offset _getP2OffsetBasedOnCurveSide(
      int thisLevel,
      double p2_dx_VariationFactor,
      double p2_dy_VariationFactor,
      double centerWidth) {
    final double clamped_dxFactor = p2_dx_VariationFactor.clamp(
        params.minReferencePositionOffsetFactor.dx,
        params.maxReferencePositionOffsetFactor.dx);
    final double clamped_dyFactor = p2_dy_VariationFactor.clamp(
        params.minReferencePositionOffsetFactor.dy,
        params.maxReferencePositionOffsetFactor.dy);
    final double p2_dx = thisLevel.isEven
        ? centerWidth * (1 - clamped_dxFactor)
        : centerWidth + (centerWidth * clamped_dxFactor);
    final double p2_dy = -((thisLevel * params.levelHeight) +
        (params.levelHeight *
            (thisLevel.isEven ? clamped_dyFactor : 1 - clamped_dyFactor)));
    return Offset(p2_dx, p2_dy);
  }

  void _paintImage(Canvas canvas, ImageDetails imageDetails, Offset offset) {
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(offset.dx, offset.dy, imageDetails.size.width,
            imageDetails.size.height),
        image: imageDetails.imageInfo.image);
  }

  double _compute(double t, double p1, double p2, double p3) {
    return (((1 - t) * (1 - t) * p1) + (2 * (1 - t) * t * p2) + (t * t) * p3);
  }

  @override
  bool shouldRepaint(covariant CurrentLevelPainter oldDelegate) =>
      oldDelegate.imagesToPaint != imagesToPaint ||
          oldDelegate.params.currentLevel != params.currentLevel;
}