import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  const ListaNoticias(this.noticias);

  final List<Article> noticias;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: this.noticias.length,
        itemBuilder: (BuildContext context, int i){
          return _Noticia(noticia: this.noticias[i], index: i);
        }),
    );
  }
}


class _Noticia extends StatelessWidget {
  const _Noticia({
    @required this.noticia,
    @required this.index
  });

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tarjetaImagen(noticia: noticia),
        _tarjetaTitulo(noticia: noticia),
        _tarjetaMedio(noticia: noticia),
        _tarjetaBody(noticia: noticia),
        SizedBox(height: 10),
        _tarjetaBotones(),
        SizedBox(height: 10),
        Divider()
      ],
    );
  }
}

class _tarjetaMedio extends StatelessWidget {
  const _tarjetaMedio({
    @required this.noticia,
  });

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Text('${noticia.source.name}'),
        ],
      ),
    );
  }
}

class _tarjetaTitulo extends StatelessWidget {
  const _tarjetaTitulo({
    @required this.noticia,
  });

  final Article noticia;

  @override
  Widget build(BuildContext context) {

    List<String> l = noticia.title.split(' - ');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Text(l[0], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _tarjetaImagen extends StatelessWidget {
  const _tarjetaImagen({
    @required this.noticia,
  });

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: (noticia.urlToImage != null)
              ? FadeInImage(
                    placeholder: AssetImage('assets/giphy.gif') ,
                    image: NetworkImage(noticia.urlToImage),
                  )
              : AssetImage('assets/no-image.pngName'),
        ),
      ),
    );
  }
}

class _tarjetaBody extends StatelessWidget {
  const _tarjetaBody({
    @required this.noticia,
  });

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: (noticia.description != null)
        ? Text(noticia.description, textAlign: TextAlign.justify,)
        : ''
    );
  }
}

class _tarjetaBotones extends StatelessWidget {
  const _tarjetaBotones({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: miTema.accentColor,
            child: Icon(Icons.star_border),
          ),

          SizedBox(width: 20,),

          RawMaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.blue,
            child: Icon(Icons.more_horiz_outlined),
          ),
        ],
      )
    );
  }
}




