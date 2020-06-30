import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/country.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'eight_screen_detail.dart';

class EightScreen extends StatefulWidget {
  @override
  _EightScreenState createState() => _EightScreenState();
}

SnackBar snackBar = SnackBar(content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
       print('click this action');
      }),
);

class _EightScreenState extends State<EightScreen> {
  var url = 'https://restcountries.eu/rest/v2/all';

  List<Country> coutries = List();
  Future<List<Country>> _getCoutry() async {
    var data = await http.get(url);
    var jsonData = jsonDecode(data.body);

    for (var u in jsonData) {
      Country coutry = Country(u["name"], u["capital"],u["population"]);
      coutries.add(coutry);
    }

    print(coutries.length);
    return coutries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('list coutries of the world'),
        ),
        body: Container(
          child: FutureBuilder(
              future: _getCoutry(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: SpinKitCircle(color: Colors.blue,)
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(
                          snapshot.data[index].capital,
                          style: TextStyle(color: Colors.grey),
                          maxLines: 3,
                        ),
                        
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      DetailEightPage(snapshot.data[index])));
                        },
                        onLongPress: () {
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                }
              }),
        )
        );
  }
}
