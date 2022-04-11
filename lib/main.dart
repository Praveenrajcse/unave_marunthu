import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Quotes.dart';
import 'package:flutter_share/flutter_share.dart';

DailyQuote dailyQuote = DailyQuote();

var controller = TextEditingController();
final ScrollController firstController = ScrollController();

void main() => runApp(Marunthu());

class Marunthu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuotesPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal.shade900,
      child: Image.asset('images/unave_marunthu_splash.png'),
    );
  }
}

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  @override
  void initState() {
    dailyQuote.foundQuote = dailyQuote.allQuote;
    super.initState();
  }

  void close() {
    controller.clear();
    // FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    setState(() {
      dailyQuote.foundQuote = dailyQuote.allQuote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'உணவே மருந்து',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen.shade50,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        dailyQuote.foundQuote = dailyQuote.runFilter(value);
                      });
                      if (value == '') {
                        close();
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'உணவுப் பொருள் / நோய்',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => close(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
                height: 5,
              ),
              Expanded(
                child: Scrollbar(
                  controller: firstController,
                  showTrackOnHover: true,
                  thickness: 6.0,
                  radius: Radius.circular(15.0),
                  child: ListView.builder(
                    itemCount: dailyQuote.foundQuote.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          onLongPress: () {
                            FlutterShare.share(
                              title: "உணவே மருந்து",
                              text: "உணவே மருந்து APP: " +
                                  dailyQuote.foundQuote[index],
                              chooserTitle: "உணவே மருந்து",
                            );
                            print(dailyQuote.foundQuote[index]);
                          },
                          tileColor: Colors.teal.shade50,
                          title: Text(
                            dailyQuote.foundQuote[index],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.teal.shade900,
                              fontSize: 17,
                              fontFamily: 'SourceSansPro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
