import 'package:flutter/material.dart';
import 'chapter_list.dart';
import '../../models/novel_manager.dart';

class ShowChapterListDialog {
  final BuildContext context;
  final ChapterModel chapterModel;

  ShowChapterListDialog({
    required this.context,
    required this.chapterModel,
  });

  void show() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'ChapterList',
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const SizedBox.shrink();
      },
      barrierColor: Colors.black54.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final CurvedAnimation curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return AnimatedBuilder(
          animation: curvedAnimation,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: Tween<double>(
                    begin: -MediaQuery.of(context)
                        .size
                        .width, // Start off-screen on the right
                    end: 0, // Stick to the right edge of the screen
                  ).animate(curvedAnimation).value,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SafeArea(
                    child: ChapterList(chapterModel: chapterModel),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// Function to initialize and call ShowChapterListDialog
void showChapterListDialog(BuildContext context) {
  final ChapterModel chapterModel = ChapterModel(
    novelTitle: 'A fascinating journey',
    novelImageUrl: 'https://i.pinimg.com/enabled_hi/564x/6a/6c/06/6a6c069505e5d71bf2aeeec9f2de1ca5.jpg',
    currentChapter: 3,
    chapters: List.generate(10, (index) => 'Chapter ${index + 1}'),
  );

  ShowChapterListDialog(
    context: context,
    chapterModel: chapterModel,
  ).show();
}
