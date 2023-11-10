import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quokka_news/core/constants/constants.dart';
import 'package:quokka_news/features/Home/Data/news_model.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({
    super.key,
    required this.article,
  });
  final Article? article;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: size.height * .25,
                width: size.width,
                fit: BoxFit.cover,
                imageUrl: article?.urlToImage ?? "",
                placeholder: (context, url) => placeholderImage(size),
                errorWidget: (context, url, error) => placeholderImage(size),
              ),
            ),
          ),
          ExpansionTile(
            backgroundColor: Colors.purple.shade200.withOpacity(.3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              "${article?.title}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                dateFormatter2.format(article?.publishedAt ?? DateTime.now())),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "${article?.description}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${article?.source?.name}",
                          style: TextStyle(
                              color: Colors.purple.shade900, fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.open_in_new_rounded,
                          color: Colors.purple.shade900,
                          size: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Image placeholderImage(Size size) {
    return Image.asset(
      "assets/images/placeholder.png",
      height: size.height * .25,
      width: size.width,
      fit: BoxFit.cover,
    );
  }
}
