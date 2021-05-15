import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              _listaCategorias(),

              Expanded(
                child: Center(
                    child: (newsService.categoryArticles[newsService.selectedCategory] == 0 )
                        ? Center(child: CircularProgressIndicator())
                        : ListaNoticias(newsService.categoryArticles[newsService.selectedCategory])
                ),
              )
            ],
          ),
        )
    );
  }
}

class _listaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 75,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            //width: 92,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _categoryButton(categoria: categories[index]),
                  SizedBox(height: 5,),
                  Text("${categories[index].name[0].toUpperCase()}${categories[index].name.substring(1)}")
                ],
              ),
            ),
          );
        }),
    );
  }
}

class _categoryButton extends StatelessWidget {

  final Category categoria;

  const _categoryButton({this.categoria});

  @override
  Widget build(BuildContext context) {

    final newsServices = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsServices = Provider.of<NewsService>(context, listen: false);
        newsServices.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (newsServices.selectedCategory == categoria.name )
                  ? miTema.accentColor
                  : Colors.black54
        ),
      ),
    );
  }
}