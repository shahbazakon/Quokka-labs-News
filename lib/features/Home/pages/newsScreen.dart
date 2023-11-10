import 'package:flutter/material.dart';
import 'package:quokka_news/core/widget/news_list_tile.dart';
import 'package:quokka_news/core/widget/news_list_tile2_dart.dart';
import 'package:quokka_news/features/Home/Data/new_data_source.dart';
import 'package:quokka_news/features/Home/Data/news_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen(
      {super.key, this.showSearchBar = false, this.isListTileColumn = true});
  final bool showSearchBar;
  final bool isListTileColumn;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ValueNotifier<String> searchValue = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: NewsDataSource().fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return newsList(listData: snapshot.data!);
            } else {
              return const Center(
                child: Text("Something Went Wrong"),
              );
            }
          },
        ),
      ),
    );
  }

  // News List
  Widget newsList({required NewsModel listData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Visibility(visible: widget.showSearchBar, child: searchBar()),
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: searchValue,
            builder: (context, value, child) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listData.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    Article? article = listData.articles?[index];
                    if (article!.title!
                        .toLowerCase()
                        .startsWith(value.toLowerCase())) {
                      return widget.isListTileColumn
                          ? NewsListTile(article: listData.articles?[index])
                          : NewsListTile2(article: listData.articles?[index]);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return TextField(
      decoration: InputDecoration(
          label: const Text("Search"),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          suffixIcon: const Icon(Icons.search_sharp)),
      onChanged: (String value) {
        searchValue.value = value;
        searchValue.notifyListeners();
      },
    );
  }
}
