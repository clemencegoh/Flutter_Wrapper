import 'dart:math';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';


Future<Map<String, dynamic>> getRandomQuote() async {
  final random = new Random();
  List<Map<String, dynamic>> quotesList = await getQuotes(random.nextInt(10));
  return quotesList[random.nextInt(quotesList.length)];
}

Future getQuotes(int pageNumber) async {
  try{
    Response res = await Dio().get("http://quotes.toscrape.com/page/$pageNumber");
    var document = parse(res.data);
    List<Element> quotes = document.querySelectorAll('div.quote');

    List<Map<String, dynamic>> quoteMap = [];
    for (var quote in quotes){
      quoteMap.add({
        "Quote": quote.querySelector("span.text").text.trim().split("\n")[0],
        "Author": quote.querySelector("small.author").text.trim(),
      });
    }
    return quoteMap;
  }catch (e) {
    return [{"Quote": "$e", "Author": "QuotesGetter"}];
  }
}

main(){
  getRandomQuote().then((e){
    print(e);
  });
}