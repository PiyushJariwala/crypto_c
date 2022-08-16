import 'package:crypto_c/modelData/RatesData.dart';
import 'package:crypto_c/modelData/cryptodataClass.dart';
import 'package:crypto_c/splash.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => MyCrypto(),
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.lightBlue,
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontSize: 18),
            titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )),
    ),
  );
}

class MyCrypto extends StatefulWidget {
  const MyCrypto({Key? key}) : super(key: key);

  @override
  State<MyCrypto> createState() => _MyCryptoState();
}

class _MyCryptoState extends State<MyCrypto> {
  double currncy = 1;
  String name = 'USD';
  String symbol = '\$';
  bool box = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Crypto Converter"),
        ),
        body: FutureBuilder(
          future: apiCall(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              List l1 = snapshot.data;
              CryptoData cryptoData = l1[0];
              RatesData ratesData = l1[1];
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Stack(
                  children: [
                    Card(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: Text(
                            "Rank",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          title: Text(
                            "Name",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          trailing: Text(
                            "Price in $name",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 55),
                      child: ListView.builder(
                          itemCount: cryptoData.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Text(
                                  "${cryptoData.data![index].rank}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                title: Text(
                                  "${cryptoData.data![index].name}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle:
                                    Text("${cryptoData.data![index].symbol}"),
                                trailing: Text(
                                  "${symbol} ${(double.parse(cryptoData.data![index].priceUsd!) / currncy).toStringAsFixed(2)}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            );
                          }),
                    ),
                    box
                        ? Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.blue,
                            margin: EdgeInsets.only(left: 200, top: 55),
                            child: ListView.builder(
                                itemCount: ratesData.data!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        name = ratesData.data![index].symbol!;
                                        currncy = double.parse(
                                            ratesData.data![index].rateUsd!);
                                        ratesData.data![index].currencySymbol != null
                                            ? symbol= ratesData
                                                .data![index].currencySymbol!
                                            : symbol = ' ';
                                        box = false;
                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: Text(
                                                    '${ratesData.data![index].symbol}'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: Text(
                                                    '${ratesData.data![index].currencySymbol != null ? ratesData.data![index].currencySymbol : ' '}'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Container(),


                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FloatingActionButton(onPressed: (){
                          setState(() {
                            box ? box = false : box = true;
                          });
                        },child: Text("$symbol",style: TextStyle(fontSize: 20),),),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future apiCall() async {
    Uri uri = Uri.parse("https://api.coincap.io/v2/assets");
    var res = await http.get(uri);
    var jsd = convert.jsonDecode(res.body);

    Uri url = Uri.parse("https://api.coincap.io/v2/rates");
    var respons = await http.get(url);
    var jsondata = convert.jsonDecode(respons.body);
    List call = [CryptoData.fromJson(jsd), RatesData.fromJson(jsondata)];

    return call;
  }
}
