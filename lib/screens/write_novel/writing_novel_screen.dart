import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/novels_manager.dart';
import '../../manager/chapter_manager.dart';

class WritingNovelScreen extends StatefulWidget {
  const WritingNovelScreen({
    super.key,
  });

  @override
  State<WritingNovelScreen> createState() => _WritingNovelScreenState();
}

class _WritingNovelScreenState extends State<WritingNovelScreen> {
  late Future<void> _fetchNovelDraft;

  @override
  void initState() {
    super.initState();
    _fetchNovelDraft = context.read<NovelsManager>().fetchDraftNovel();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Viết truyện'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Navigate to CreateNovelScreen
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Đã đăng tải'),
                Tab(text: 'Bản thảo'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  NovePostedListView(),
                  NovelDraftListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NovelDraftListView extends StatelessWidget {
  const NovelDraftListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<NovelsManager>().fetchDraftNovel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return NovelDraftGridView();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class NovelDraftGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final novels = context.watch<NovelsManager>().getNovels();

    return ListView.builder(
      itemCount: novels.length,
      itemBuilder: (context, index) {
        final novel = novels[index];
        final chapterManager =
            Provider.of<ChapterManager>(context, listen: false);

        return FutureBuilder(
          future: context.read<ChapterManager>().fetchChapters(novel.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      novel.urlImageCover,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            novel.novelName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Số chương đã đăng: ${chapterManager.totalChapterPublished}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            '${chapterManager.totalChapterDrafts} bản thảo',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      color: Colors.white,
                      icon: const Icon(Icons.more_vert_sharp),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            child: Text('Xem trước'),
                          ),
                          const PopupMenuItem(
                            child: Text('Xóa'),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}

class NovePostedListView extends StatelessWidget {
  const NovePostedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<NovelsManager>().fetchCompleteNovel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return NovelPostedGridView();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class NovelPostedGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final novels = context.watch<NovelsManager>().getNovels();
    return ListView.builder(
      itemCount: novels.length,
      itemBuilder: (context, index) {
        final novel = novels[index];
        final chapterManager =
            Provider.of<ChapterManager>(context, listen: false);
        return FutureBuilder(
          future: context.read<ChapterManager>().fetchChapters(novel.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      novel.urlImageCover,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            novel.novelName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Số chương đã đăng: ${chapterManager.totalChapterPublished}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            '${chapterManager.totalChapterDrafts} bản thảo',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      color: Colors.white,
                      icon: const Icon(Icons.more_vert_sharp),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            child: Text('Xem trước'),
                          ),
                          const PopupMenuItem(
                            child: Text('Xóa'),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
