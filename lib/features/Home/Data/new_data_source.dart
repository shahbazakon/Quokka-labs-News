import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:quokka_news/core/constants/constants.dart';
import 'package:quokka_news/features/Home/Data/news_model.dart';

class NewsDataSource {
  Future<NewsModel> fetchNews() async {
    final dio = Dio();
    String fromDate = dateFormatter1.format(DateTime.now());
    try {
      final response = await dio.get(
        "$baseURL/everything?q=tesla&from=$fromDate&sortBy=publishedAt&apiKey=$apiKey",
      );
      NewsModel data = NewsModel.fromJson(response.data);
      return data;
    } catch (error) {
      log("NewsDataSource", error: "$error");
      rethrow;
    }
  }
}
