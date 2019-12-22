import 'dart:math';

import 'package:flutter_app/projects/homepage/dbHelper.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';

import 'package:flutter_app/projects/homepage/projectsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';



/*
  All instances querying for a quote should go through here
  Prevents multiple unnecesssary http requests
 */
class QuoteClass {
  static final QuoteClass _singleton = QuoteClass._internal();
  final DBHelper _dbHelper = DBHelper();

  factory QuoteClass() {
    return _singleton;
  }

  QuoteClass._internal();

  final random = Random();

  Future<QuoteItem> getQuoteOfTheDay() async {
    /*
     Rules:
         - Try to refresh quotesList every day
         - Otherwise, get random quote from stored list on refresh
     */

    bool isAvailable = await _checkCacheForQuote();
    List<QuoteItem> quotes;

    if (isAvailable){
      quotes = await this._getQuotesFromDB();
    }
    else{
      // First time or refresh daily
      quotes = await this._getQuotesFromPage(random.nextInt(10));
      this._setLastUpdated();
      this._setDB(quotes);
    }
    return quotes[random.nextInt(quotes.length)];
  }

  void _setDB(List<QuoteItem> quotes) async {
    // todo: implement
  }

  void _setLastUpdated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const refreshDateTimeID = "homepage_quotes_refreshed_last";

    prefs.setString(refreshDateTimeID, DateTime.now().toString());
  }

  Future<List<QuoteItem>> _getQuotesFromDB() async {
    // todo: implement

    // set items to cache
    const refreshDateTimeID = "homepage_quotes_refreshed_last";
    const quotesCounterID = "refresh_quotes_counter";
    const currentQuoteID = "current_quote";
    const currentAuthorID = "current_author";
  }

  Future<bool> _checkCacheForQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const refreshDateTimeID = "homepage_quotes_refreshed_last";

    String lastUpdate = prefs.get(refreshDateTimeID) ?? DateTime.now().toString();

    return (DateTime.parse(lastUpdate).difference(DateTime.now()) < Duration(days: 1));
  }

  // Webscrape, should be called sparingly
  Future<List<QuoteItem>> _getQuotesFromPage(int pageNumber) async {
    String website = "http://quotes.toscrape.com/page/$pageNumber";

    try{
      Response res = await Dio().get(website);
      var document = parse(res.data);
      List<Element> quotes = document.querySelectorAll('div.quote');

      List<QuoteItem> quoteMap = [];
      for (var quote in quotes){
        quoteMap.add(QuoteItem(
          quote: quote.querySelector("span.text").text.trim().split("\n")[0],
          author: quote.querySelector("small.author").text.trim(),
        ));
      }
      return quoteMap;
    }catch (e) {
      return [QuoteItem(quote: "$e", author: "Error")];
    }
  }
}


Future<Map<String, dynamic>> getRandomQuote() async {
  final random = new Random();
  List<Map<String, dynamic>> quotesList = await getQuotes(random.nextInt(10));
  return quotesList[random.nextInt(quotesList.length)];
}


// todo: store quotes in local cache and call it only once on opening app
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

