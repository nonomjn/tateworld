import 'package:flutter/material.dart';
import 'read_novel_content.dart';
import 'read_novel_appbar.dart';
import 'read_novel_bottomnavbar.dart';
import 'font_settings_dialog.dart';
import 'chapter_list_dialog.dart';
import '../../models/theme_manager.dart';

class ReadNovel extends StatefulWidget {
  final String id;
  const ReadNovel({Key? key,required this.id}) : super(key: key);

  @override
  State<ReadNovel> createState() => _ReadNovelState();
}

class _ReadNovelState extends State<ReadNovel> {
  bool _isVisible = true;
  Duration _duration = const Duration(milliseconds: 500);

  double _fontSize = 16; // Default size for body text
  String _selectedFont = 'Serif'; // Default font
  ThemeData _currentTheme = Themes.lightTheme; // Default theme

  final String novelContent = '''
It was a dark and stormy night when a young adventurer named Lila found herself standing at the entrance of a long-forgotten temple.
Her heart pounded in her chest as she stared at the towering gates, which were covered in ancient runes that glowed faintly in the moonlight. She had traveled far to get here, overcoming countless obstacles along the way, but now, standing at the threshold of the unknown, she couldn't help but feel a sense of dread. The air was thick with the promise of danger, and yet, Lila knew she couldn't turn back. The treasure she sought was said to be hidden deep within these walls.
As she took a deep breath, Lila pushed open the heavy stone doors. A loud creak echoed through the temple as the doors slowly gave way. Inside, a long, narrow corridor stretched out before her, illuminated only by the faint light from the full moon outside. She could barely make out the shapes of the ancient statues that lined the walls, their faces worn and weathered by time.
With each step, the air grew colder. Her breath came out in small clouds of mist as she ventured further into the temple. Lila could feel her heart beating faster, each thump resonating in her ears. The floor beneath her feet was uneven, and she stumbled a few times as she navigated through the dark.
Suddenly, the corridor opened up into a vast chamber. In the center of the room was a large pedestal, and atop it sat a small, glowing artifact. This had to be the treasure she had come for. But just as she stepped forward to claim it, she heard a low growl behind her. Lila spun around, her hand instinctively reaching for the sword at her side.
Standing in the shadows, its eyes glowing a menacing red, was a creature unlike any she had ever seen. It was tall and covered in dark, matted fur. Its long claws scraped against the stone floor as it slowly approached. The creature's snarl echoed through the chamber, sending a chill down Lila's spine.
She had come prepared for a challenge, but nothing could have prepared her for this. Lila tightened her grip on her sword, readying herself for the battle that was about to unfold. The creature lunged forward, and Lila barely had time to react, her sword clashing against its claws in a shower of sparks.
The battle was fierce. Lila dodged and weaved, narrowly avoiding the creature's deadly attacks. But with every strike of her sword, the creature only seemed to grow more enraged. The fight carried on for what felt like hours, the two combatants locked in a deadly dance of survival. Lila could feel her strength waning, but she couldn't give up now. Not when she was so close to her goal.
Finally, with a final, desperate strike, Lila managed to plunge her sword deep into the creature's chest. It let out a deafening roar before collapsing to the ground, lifeless. Lila stood there, panting, her body trembling from the exertion. She had won, but just barely. The treasure was hers, but at what cost?
Exhausted, she limped toward the pedestal and carefully picked up the glowing artifact. As soon as her fingers touched it, a blinding light filled the room, and Lila was overcome with a sense of peace. She had done it. The journey had been long and perilous, but she had finally succeeded.
'''; // Novel content

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _showFontSettings() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FontSettingsDialog(
          selectedFont: _selectedFont,
          fontSize: _fontSize,
          onFontChanged: (String newFont) {
            setState(() {
              _selectedFont = newFont;
            });
          },
          onFontSizeChanged: (double newSize) {
            setState(() {
              _fontSize = newSize;
            });
          },
          onThemeChanged: (ThemeData newTheme) {
            setState(() {
              _currentTheme = newTheme;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleVisibility,
            child: NovelContent(
              fontSize: _fontSize,
              selectedFont: _selectedFont,
              currentTheme: _currentTheme,
              novelContent: novelContent,
            ),
          ),
          AppBarWidget(
            isVisible: _isVisible,
            toggleVisibility: _toggleVisibility,
            showChapterListDialog: () => showChapterListDialog(context),
          ),
          BottomNavBar(
            isVisible: _isVisible,
            showFontSettings: _showFontSettings,
          ),
        ],
      ),
    );
  }
}
