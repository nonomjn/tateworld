import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../manager/novels_manager.dart';
import './novels/novel_card.dart';
import './novels/section_title.dart';
import '../models/novel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchNovelLatest;

  @override
  void initState() {
    super.initState();
    _fetchNovelLatest = context.read<NovelsManager>().fetchNovelLates();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tate World'),
        ),
        body: FutureBuilder(
          future: _fetchNovelLatest,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<NovelsManager>(
              builder: (ctx, novelsManager, _) {
                final novels = novelsManager.getNovels();
                return HomeScreenBody(novels: novels);
              },
            );
          },
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  final List<Novel> novels;

  const HomeScreenBody({super.key, required this.novels});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Truyện mới cập nhật'),
            const SizedBox(height: 8),
            buildNovelList(context, novels),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildNovelList(BuildContext context, List<Novel> novels) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: novels.length,
        itemBuilder: (context, index) {
          return NovelCard(novel: novels[index]);
        },
      ),
    );
  }
}
