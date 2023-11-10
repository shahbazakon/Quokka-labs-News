import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quokka_news/core/constants/constants.dart';
import 'package:quokka_news/features/Home/Data/news_model.dart';

class NewsListTile2 extends StatelessWidget {
  const NewsListTile2({
    super.key,
    required this.article,
  });
  final Article? article;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .3,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: size.height * .2,
                  width: size.width * .5,
                  fit: BoxFit.cover,
                  imageUrl: article?.urlToImage ?? "",
                  placeholder: (context, url) => placeholderImage(size),
                  errorWidget: (context, url, error) => placeholderImage(size),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                child: Text(
                  "${article?.source?.name}",
                  style: TextStyle(color: Colors.purple.shade900, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(dateFormatter2
                    .format(article?.publishedAt ?? DateTime.now())),
              )
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${article?.title}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    "${article?.description}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black87),
                  ),
                )
              ],
            ),
          )
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
