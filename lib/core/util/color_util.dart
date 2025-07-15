import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorUtil {
  static Future<Color> getDominantColor(imageUrl) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
          NetworkImage(imageUrl),
          maximumColorCount: 20,
        );
    return paletteGenerator.dominantColor?.color ?? Colors.black;
  }

  static Color getContrastingTextColor(Color bgColor) {
    return bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
