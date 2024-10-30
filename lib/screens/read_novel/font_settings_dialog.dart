import 'package:flutter/material.dart';
import '../../models/theme_manager.dart';
import 'theme_picker.dart';
import 'font_size_picker.dart';
import 'font_picker.dart';

class FontSettingsDialog extends StatefulWidget {
  final String selectedFont;
  final double fontSize;
  final ValueChanged<String> onFontChanged;
  final ValueChanged<double> onFontSizeChanged;
  final ValueChanged<ThemeData> onThemeChanged;

  const FontSettingsDialog({
    Key? key,
    required this.selectedFont,
    required this.fontSize,
    required this.onFontChanged,
    required this.onFontSizeChanged,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  _FontSettingsDialogState createState() => _FontSettingsDialogState();
}

class _FontSettingsDialogState extends State<FontSettingsDialog> {
  late String _currentFont;
  late double _currentFontSize;

  @override
  void initState() {
    super.initState();
    _currentFont = widget.selectedFont;
    _currentFontSize = widget.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Font Settings",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),

        // Widget chọn theme
        ThemePicker(onThemeChanged: widget.onThemeChanged),
        const SizedBox(height: 20),

        // Widget chọn kích thước chữ
        FontSizePicker(
          currentFontSize: _currentFontSize,
          onFontSizeChanged: (newSize) {
            setState(() {
              _currentFontSize = newSize;
            });
            widget.onFontSizeChanged(newSize);
          },
        ),
        const SizedBox(height: 20),

        // Widget chọn font chữ
        FontPicker(
          currentFont: _currentFont,
          onFontChanged: (newFont) {
            setState(() {
              _currentFont = newFont;
            });
            widget.onFontChanged(newFont);
          },
        ),
      ],
    );
  }
}
