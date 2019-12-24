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

  final random = Random(DateTime.now().millisecond);

  // Keys for storing and getting from shared prefs
  final String lastUpdatedDay = "last_updated_day";
  final String lastUpdatedMonth = "last_updated_month";
  final String lastUpdatedYear = "last_updated_year";
  final String currentQuoteOfTheDay = "quote_of_the_day";
  final String currentAuthor = "author_of_the_day";


  /*
     Rules:
         - Try to refresh quotesList every day
         - Otherwise, get random quote from stored list on refresh
   */
  Future<QuoteItem> getQuoteOfTheDay() async {
    bool isAvailable = await _checkCacheValidity();
    List<QuoteItem> quotes;

    if (isAvailable){
      return await this._getSavedQuote();
//      quotes = await this._getQuotesFromDB();
    }
    else{
      // First time or refresh daily
      quotes = await this._getQuotesFromPage(random.nextInt(10));
      this._setLastUpdated();
//      this._setDB(quotes);
    }
    QuoteItem chosenQuote = quotes[random.nextInt(quotes.length)];
    this._setQuoteOfTheDayIntoSharedPrefs(chosenQuote);
    return chosenQuote;
  }

  void _setDB(List<QuoteItem> quotes) async {
    // todo: implement as a feature
  }

  void _setQuoteOfTheDayIntoSharedPrefs(QuoteItem quoteItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.currentQuoteOfTheDay, quoteItem.quote);
    prefs.setString(this.currentAuthor, quoteItem.author);
  }

  Future<QuoteItem> _getSavedQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return QuoteItem(
      quote: await prefs.get(currentQuoteOfTheDay),
      author: await prefs.get(currentAuthor)
    );
  }

  void _setLastUpdated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime today = DateTime.now();
    prefs.setInt(lastUpdatedDay, today.day);
    prefs.setInt(lastUpdatedMonth, today.month);
    prefs.setInt(lastUpdatedYear, today.year);
  }

  Future<List<QuoteItem>> _getQuotesFromDB() async {
    // todo: implement
  }

  Future<bool> _checkCacheValidity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int updatedOnDay = prefs.getInt(this.lastUpdatedDay);
    if (updatedOnDay != null){
      // check validity
      DateTime today = DateTime.now();
      if ((updatedOnDay == today.day)
        && prefs.getInt(this.lastUpdatedMonth) == today.month
        && prefs.getInt(this.lastUpdatedYear) == today.year
      ){
        return true;
      }
    }
    return false;
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

