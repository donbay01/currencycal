
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_function_type_syntax_for_parameters, avoid_print, void_checks, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:currency_calculator/service/api_client.dart';
import 'package:currency_calculator/widgets/chart_widget.dart';
import 'package:currency_calculator/widgets/dropDown.dart';
import 'package:currency_calculator/widgets/toastMessage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String>? currencies;

  String? currencyFrom;
  String? currencyTo;
  double? rate;
  String? result = '';
  final valueController  = TextEditingController();
  ApiClient client = ApiClient();


  final Uri currencyURL  = Uri.http("free.currconv.com", '/api/v7/currencies',
      {"apiKey": "3729b56fceb7b5e1bc81"});


  Future<List<String>?> getCurrencies() async{
    http.Response res = await http.get(currencyURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["results"];
      currencies = (list.keys).toList();
      print(currencies);
      return currencies;
    }else {
      throw Exception("Failed to connect to api");

    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencies();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.dehaze,
            color: Colors.green[700],
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Currency\nCalculator',
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                 TextField(
                   onSubmitted: (value) async {
                     getResults();
                   },
                   controller: valueController,
                   decoration: InputDecoration(
                     suffix: currencyFrom == null ? Text('') : Text(currencyFrom!),
                     filled: true,
                     labelText: 'Input Amount to convert',
                     labelStyle: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.w500,
                     )
                   ),
                   style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.w700,
                     fontSize: 25
                   ),
                   keyboardType: TextInputType.numberWithOptions(decimal: true),
                   textAlign: TextAlign.start,
                 ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(result!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.green),),
                        ),
                        currencyTo == null ? Text('') : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(currencyTo!,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.green),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox( 
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                            border: Border.all(color: Colors.grey)
                          ),
                          child: Center(child: customDropDown(currencies, currencyFrom, (val){
                            getResults();
                            setState(() {
                              currencyFrom = val;
                            });
                          }))
                        ),
                        IconButton(
                          onPressed: (){
                            String? temp = currencyFrom;
                            setState(() {
                              currencyFrom = currencyTo;
                              currencyTo = temp;
                            });
                          },
                          icon: Icon(Icons.swap_horiz_sharp,size: 30,color: Colors.blue,),

                        ),

                        Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Center(
                                child: customDropDown(currencies, currencyTo, (val){
                                  getResults();
                                  setState(() {
                                    currencyTo = val;
                                  });
                                })
                            )
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          return getResults();
                        },
                        child: Text('Convert',style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            primary: Colors.green)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(child: Row(
                    children: [
                      TextButton(
                        onPressed: () {

                        },
                        child: Text('Mid-market exchange rate at 13:38 UTC',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                            color: Colors.blue[600],fontSize: 15,fontWeight: FontWeight.w500),),),
                      Icon(FontAwesomeIcons.infoCircle,color: Colors.grey,)
                    ],
                  )),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Today',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                Text('30 days',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                Text('60 days',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 20,),
            ChartWidget(),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }

  getResults() async {
    if (valueController.text.isEmpty){
      displayToastMessage('Kindly Input an Amount', context);
    } else if (valueController.text == '0'){
      displayToastMessage('The number 0 is not an amount', context);
    }
    rate = await client.getRate(currencyFrom!, currencyTo!);
    setState(() {
      result = (rate! * double.parse(valueController.text)).toStringAsFixed(3);
    });
    print(result);
  }

}


