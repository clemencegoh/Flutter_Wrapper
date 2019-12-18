import 'dart:math';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';


Future<Map<String, dynamic>> getRandomQuote() async {
  final random = new Random();
  List<Map<String, dynamic>> quotesList = await getQuotes();
  return quotesList[random.nextInt(quotesList.length)];
}

Future getQuotes() async {
  try{
    Response res = await get("https://www.goodreads.com/quotes");
    var document = parse(res.body);
    List<Element> quotes = document.querySelectorAll('div.quote');

    List<Map<String, dynamic>> quoteMap = [];
    for (var quote in quotes){
      quoteMap.add({
        "Quote": quote.querySelector("div.quoteText").text.trim().split("\n")[0],
        "Author": quote.querySelector("span.authorOrTitle").text.trim(),
      });
    }
    return quoteMap;
  }catch (e) {
    return [{"Quote": "$e", "Author": "QuotesGetter"}];
  }
}

//main(){
//  getRandomQuote().then((e){
//    print(e);
//  });
//}