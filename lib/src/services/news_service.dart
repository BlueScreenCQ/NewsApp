import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';

final _URL_NEWS = 'newsapi.org';
final _API_KEY = '55aa069d396742c4bb0c6a5780032142';
final _PAIS = 'it';

class NewsService with ChangeNotifier {

  List<Article> headLines = [];
  Map<String, List<Article>> categoryArticles = {};
  String _selectedCategory = 'business';
  
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];


  NewsService() {
    this.getTopHeadLines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory (String c) {
    this._selectedCategory= c;

    this.getArticlesByCategory(c);

    notifyListeners();
  }

  List<Article >get getArticulosByCategoria => this.categoryArticles[this.selectedCategory];


  getTopHeadLines() async {

    final url = Uri.https(_URL_NEWS,'v2/top-headlines',{
      'country' : _PAIS,
      'apiKey'  : _API_KEY
    });

    final res = await http.get(url);

    final newsResponse = newsResponseFromJson(res.body);

    this.headLines.addAll(newsResponse.articles);

    // NO hace falta devolver nada porque al crearse la instancia de la vista se hace la llamada y se notifica con la respuesta
    notifyListeners();
  }

  getArticlesByCategory(String category) async {

    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }

    final url = Uri.https(_URL_NEWS,'v2/top-headlines',{
      'country'  : _PAIS,
      'apiKey'   : _API_KEY,
      'category' : category
    });

    final res = await http.get(url);

    final newsResponse = newsResponseFromJson(res.body);

    this.categoryArticles[category].addAll(newsResponse.articles);

    // NO hace falta devolver nada porque al crearse la instancia de la vista se hace la llamada y se notifica con la respuesta
    notifyListeners();
  }
}