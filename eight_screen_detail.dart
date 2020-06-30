import 'package:demo7_listview2/model/country.dart';
import 'package:flutter/material.dart';
import '../model/user2.dart';

class DetailEightPage extends StatelessWidget {

  final Country user2;
  DetailEightPage(this.user2);

  
  @override
  Widget build(BuildContext context) {


    String populationC = user2.population.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(user2.name),
      ),
          body:  SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              
              Text(user2.capital),
            
              Text(populationC), 
              
           
              
            ],
          )
          
        ),
      ),
    );
  }
}