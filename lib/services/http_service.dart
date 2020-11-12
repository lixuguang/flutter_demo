import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_common/models/article_model.dart';

class HttpService {
  Dio _dio = new Dio();
  static String _ip = '10.237.188.45';
  static String _port = '3400';
  String _address = 'http://$_ip:$_port';

  HttpService._internal();

  static HttpService _singleton = new HttpService._internal();

  factory HttpService() => _singleton;

  Future<bool> signin({String user, String password}) async {
    final response = await _dio
        .post('$_address/signin', data: {'user': user, 'password': password});
    final data = response.data;
    if (data['status'] == 'SUCCESS') {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ArticleModel>> getArticles() async {
    final response = await _dio.get('$_address/articles');
    final data = response.data;
    if (data['status'] == 'SUCCESS') {
      return data['articles']
          .map<ArticleModel>((data) => ArticleModel.fromJson(data))
          .toList();
    } else {
      return []
          .map<ArticleModel>((data) => ArticleModel.fromJson(data))
          .toList();
    }
  }

  Future<bool> postArticles({ArticleModel article}) async {
    final response =
        await _dio.post('$_address/articles', data: article.toJson());
    final data = response.data;
    if (data['status'] == 'SUCCESS') {
      return true;
    } else {
      return false;
    }
  }

  Future<ArticleModel> getArticle({String id}) async {
    final response = await _dio.get('$_address/articles/$id');
    final data = response.data;
    if (data['status'] == 'SUCCESS') {
      return ArticleModel.fromJson(data['articles']);
    } else {
      return null;
    }
  }

  Future<bool> updateArticle({String id, ArticleModel article}) async {
    final response =
        await _dio.put('$_address/articles/$id', data: article.toJson());
    final data = response.data;
    if (data['status'] == 'SUCCESS') {
      return true;
    } else {
      return false;
    }
  }
}
