import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/novel.dart';
import '../../models/chapter.dart';
import '../../manager/novels_manager.dart';
import '../../manager/chapter_manager.dart';
import 'read_novel_content.dart';
import 'read_novel_appbar.dart';
import 'read_novel_bottomnavbar.dart';
import 'font_settings_dialog.dart';
import 'chapter_list_dialog.dart';
import 'comment_chapter.dart';
import '../../manager/theme_manager.dart';
import '../../manager/current_chapter_manager.dart';

class ReadNovel extends StatefulWidget {
  final String id;
  final Novel novel;

  const ReadNovel({super.key, required this.id, required this.novel});

  @override
  State<ReadNovel> createState() => _ReadNovelState();
}

class _ReadNovelState extends State<ReadNovel> {
  bool _isVisible = true;
  Chapter? chapter;
  late ScrollController _scrollController;
  bool _isLoadingNextChapter = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChapter(widget.id);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadChapter(String chapterId) {
    final chapterManager = context.read<ChapterManager>();
    chapter = chapterManager.getChapterById(chapterId);

    if (chapter != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        chapterManager.incrementViewCount(chapter!.id!);
        context
            .read<NovelsManager>()
            .fetchNovelByIdAndReplace(widget.novel.id!);

        context.read<CurrentChapterManager>().setCurrentChapter(chapter!);

        setState(() {});
      });
    }
  }

  Future<void> _loadNextChapter() async {
    if (_isLoadingNextChapter) return;

    final chapterManager = context.read<ChapterManager>();
    final nextIndex = chapterManager.getChapterIndexById(chapter!.id!) + 1;

    if (nextIndex < chapterManager.chapters.length) {
      setState(() {
        _isLoadingNextChapter = true;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        chapter = chapterManager.chapters[nextIndex];
        _isLoadingNextChapter = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        chapterManager.incrementViewCount(chapter!.id!);
        context.read<CurrentChapterManager>().setCurrentChapter(chapter!);
      });

      _scrollController.jumpTo(0);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoadingNextChapter) {
      _loadNextChapter();
    }
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _showFontSettings() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const FontSettingsDialog();
      },
    );
  }

  void _showCommentDialog() {
    if (chapter != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.67,
            child: CommentChapter(
              chapter: chapter!,
              novel: widget.novel,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var fontThemeManager = Provider.of<FontThemeManager>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: _toggleVisibility,
              child: chapter != null
                  ? NovelContent(
                      fontSize: fontThemeManager.fontSize,
                      selectedFont: fontThemeManager.fontFamily,
                      currentTheme: fontThemeManager.currentTheme,
                      chapter: chapter!,
                      scrollController: _scrollController,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            AppBarWidget(
              novel: widget.novel,
              isVisible: _isVisible,
              toggleVisibility: _toggleVisibility,
              showChapterListDialog: () =>
                  showChapterListDialog(context, widget.novel, chapter!),
            ),
            BottomNavBar(
              isVisible: _isVisible,
              showFontSettings: _showFontSettings,
              showComment: _showCommentDialog,
            ),
          ],
        ),
      ),
    );
  }
}
