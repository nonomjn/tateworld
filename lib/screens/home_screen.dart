import 'package:flutter/material.dart';
import './novels/novels_manager.dart';
import './novels/novel_card.dart';
import './novels/section_title.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const HomeScreen({
    super.key,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    final novels = NovelsManager().getNovels();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tate World'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Đề xuất truyện hay'),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: novels.length,
                  itemBuilder: (context, index) {
                    return NovelCard(novel: novels[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Truyện đã hoàn thành'),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: novels.length,
                  itemBuilder: (context, index) {
                    return NovelCard(novel: novels[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Truyện đang theo dõi'),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: novels.length,
                  itemBuilder: (context, index) {
                    return NovelCard(novel: novels[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
