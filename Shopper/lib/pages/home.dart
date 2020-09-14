
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:barcode_scan/barcode_scan.dart';
//import '../payment/check.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import '../paymentFailed.dart';
import '../paymentSuccess.dart';

import '../payment/razorpay_flutter.dart';

class CheckRazor extends StatefulWidget {
  final int bill;
  CheckRazor(this.bill);
  @override
  _CheckRazorState createState() => _CheckRazorState(bill);
}

class _CheckRazorState extends State<CheckRazor> {
  int bill;
  _CheckRazorState(this.bill);
  Razorpay _razorpay = Razorpay();
  var options;
  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SuccessPage(
          response: response,
        ),
      ),
          (Route<dynamic> route) => false,
    );
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
          response: response,
        ),
      ),
          (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options = {
      'key': "rzp_test_m03jIn7GtrZfCV", // Enter the Key ID generated from the Dashboard

      'amount': bill*100, //in the smallest currency sub-unit.
      'name': 'organization',

      'currency': "INR",
      'theme.color': "#F37254",
      'buttontext': "Pay with Razorpay",
      'description': 'RazorPay example',
      'prefill': {
        'contact': '',
        'email': '',
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
//import 'barcode.dart';
//import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';



var list = new List();
var cart = new List();
final db = FirebaseDatabase.instance.reference();




class MapControllerPage extends StatefulWidget {


  @override
  MapControllerPageState createState() {
    return MapControllerPageState();
  }
}

class MapControllerPageState extends State<MapControllerPage> {

  //final dateFormat = DateFormat("yyyy-MM-dd");
  //final timeFormat = DateFormat("HH:mm");
  int bill = 0;
  DateTime date;
  TimeOfDay time;
  String barcode = "";
  String scanMessage = "Please scan an item to make cart";

  var _counter = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  var _see = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
 int l = 0;

 void readScanner(i){
   db.child('27').child('Cart').child(i.toString()).set({
     'counter': 1,
   });
   bill = bill + int.parse(list[i]['Price'].toString());
   print(bill);
 }


  var userid = "customer3";

 void addToHelp() {
    var temp;

    db.once().then((DataSnapshot snapshot) {

      //Map<dynamic,dynamic> valuese = snapshot.value[28];
      //print(valuese);
      var j = 0;
      for (var i = 0; i < 25; i++) {
        Map<dynamic, dynamic> values = snapshot.value[26.toString()]["Help"][i];

        values.forEach((key, values) {
          //print(values);
        });
        temp = _counter[i] + int.parse(snapshot.value[26.toString()]["Help"][i]["counter"].toString());
        print(temp.toString());
        //snapshot.value[i]["Help"][i.toString()] = temp.toString();
        db.reference().child("26").child("Help").child(i.toString()).update({
          'counter': temp.toString(),

        });



        {
          if(_counter[i] != 0){
            j++;

            Map<dynamic, dynamic> toAdd = list[i];
            toAdd.putIfAbsent("count",()=>_counter[i]);
            print("list items" + list[i].toString());
            db.reference().child("orders").child(userid).child(j.toString()).set(toAdd);


          }
        }


        

        //_removeProductAll(i);
        //print(values);
        //list.add(values);
        //list.add(values);
        //print(list);
      }
    });

    setState(() {
      l=0;
    });
  }

  void addToHelpNoPack() {
    var temp;

    db.once().then((DataSnapshot snapshot) {



      for (var i = 0; i < 25; i++) {
        Map<dynamic, dynamic> values = snapshot.value[26.toString()]["Help"][i];

        values.forEach((key, values) {
          //print(values);
        });
        temp = _counter[i] + int.parse(snapshot.value[26.toString()]["Help"][i]["counter"].toString());
        print(temp.toString());
        //snapshot.value[i]["Help"][i.toString()] = temp.toString();
        db.reference().child("26").child("Help").child(i.toString()).update({
          'counter': temp.toString(),

        });





        //_removeProductAll(i);
        //print(values);
        //list.add(values);
        //list.add(values);
        //print(list);
      }
    });

    setState(() {
      l=0;
    });
  }



  var categories = new Set();

  void getList() async {


   await db.once().then((DataSnapshot snapshot) {
      for (var i = 0; i < 25; i++) {
        Map<dynamic, dynamic> values = snapshot.value[i.toString()];


        values.forEach((key, values) {
          //print(values);
        });
        //print(values);

          list.add(values);
          categories.add(values["Category"]);
        //list.add(values);
        //print(list);
      }
    });
    print("ko");

    setState(() {
      l=0;
    });
  }


  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      readScanner(int.parse(barcode));
      if(int.parse(barcode) > 25 && int.parse(barcode) < 0){
        Fluttertoast.showToast(
            msg: "Invalid Barcode",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,

            backgroundColor: Colors.black26,
            textColor: Colors.white,
            fontSize: 16.0

        );
        setState(() => this.barcode = barcode);
      }

      cart.add(list[int.parse(barcode)]);
      print(cart);
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_mapController = GoogleMapController();

    getList();


  }

  _removeProduct(int i) {
    setState(() {
      if (_counter[i] > 0) {
        _counter[i]--;
      }
    });
  }


  _removeCartProduct(int i) {
   //int j;



   bill = bill - (cart[i]['Price']);
    cart.removeAt(i);

   setState(() {
      /*if (_counter[i] > 0) {
        _counter[i] = 0;
      }*/
    });
  }

  _addProduct(i) {
    setState(() {
      _counter[i]++;
    });
  }

  int _selectedIndex = 0;
  
  cancelSearch(){

    setState(() {
      _see = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    });

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  TextEditingController textController = TextEditingController();

  search(String url){
    for (var i = 0; i < 25; i++) {
      if(!list[i]["Name"].toString().toLowerCase().contains(url.toLowerCase()))
       _see[i] = 1;
    }
    setState(() {

    });

  }

  var section = "";

  sectionChange(){
    for (var i = 0; i < 25; i++) {
      if(list[i]["Category"].toString().toLowerCase() == section.toLowerCase() || section == '')
        _see[i] = 0;
      else
        _see[i] = 1;
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

          return MaterialApp(
            home: Scaffold(

              body: IndexedStack(
                  index: _selectedIndex ,
                  children: <Widget>[
                    Scaffold(

                      body: cart.length == 0? Center(
                        child: Container(
                          child: Text("Please scan to add an item to cart"),
                        ),
                      ):new ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (BuildContext ctxt, int index) => Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 30.0,),
                              Row(
                                  children: <Widget>[
                                    SizedBox(width: 10.0,),
                                    Expanded(
                                      child: Card(
                                        child: Container(
                                          //width: MediaQuery.of(context).size.width/3,
                                          height: 100,
                                          child: Row(

                                            children: <Widget>[
                                              SizedBox(
                                                width: 150,
                                                child: Column(

                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      backgroundImage: new NetworkImage(cart[index]['Image Url']),
                                                    ),
                                                    new Text(

                                                      cart[index]['Category'],
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 10),
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: new Text(
                                                        "Rs. " + cart[index]['Price'].toString()+".00",

                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 0,),
                                              SizedBox(
                                                width: 100,
                                                child: Text(cart[index]['Name'],),
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    new Container(
                                                      child: new IconButton(
                                                        icon: new Icon(Icons.remove),
                                                        highlightColor: Colors.green,
                                                        onPressed: (){
                                                          _removeCartProduct(index);
                                                        },
                                                      ),
                                                    ),

                                                  ]
                                              ),


                                            ],
                                          ),

                                        ),

                                      ),
                                    ),



                                  ]
                              ),
                            ]
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                          onPressed: scan, child: Icon(Icons.scanner)
                      ),

                    ),
                    Scaffold(
                      drawer: Drawer(

                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            DrawerHeader(
                              child: Text(
                                'Categories',
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/images/cover.jpg'))),
                            ),
                            ListTile(
                              leading: Icon(Icons.border_all),
                              title: Text('All'),
                              onTap: () {
                                section =  '';
                                sectionChange();
                                //Navigator.pop(context);
                                },
                            ),
                            ListTile(
                              leading: Icon(Icons.book),
                              title: Text('Books'),
                              onTap: () {
                                section =  'Books';
                                sectionChange();
                                },
                            ),
                            ListTile(
                              leading: Icon(Icons.crop_square),
                              title: Text('Bathroom Mirror'),
                              onTap: () {
                                section =  'Bathroom Mirror';
                                sectionChange();
                                //Navigator.of(context).pop();

                                },
                            ),
                            ListTile(
                              leading: Icon(Icons.hotel),
                              title: Text('Carpet'),
                              onTap: () {
                                section =  'Carpet';
                                sectionChange();
                                },
                            ),
                            ListTile(
                              leading: Icon(Icons.kitchen),
                              title: Text('KitchenWare'),
                              onTap: () {

                                  section =  'KitchenWare';

                                  sectionChange();
                                  },
                            ),


                          ],
                        ),
                      ),
                      appBar: AppBar(



                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            autofocus: false,

                            controller: textController,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (String url){search(url); textController.clear();},
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 6.0),
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)),
                              hintText: "Search or Enter Url",
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.cancel),
                            color: Colors.white,
                            onPressed: () {
                              // using currentState with question mark to ensure it's not null
                              cancelSearch();
                            },
                          )
                        ],
                      ),
                      body: l == 1? Text("loading"):new ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext ctxt, int index) => _see[index] != 0?Container(): Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30.0,),
                            Row(
                                children: <Widget>[
                                  SizedBox(width: 10.0,),
                                  Expanded(
                                    child: Card(
                                      child: Container(
                                        //width: MediaQuery.of(context).size.width/3,
                                        height: 100,
                                        child: Row(

                                          children: <Widget>[
                                            SizedBox(
                                              width: 150,
                                              child: Column(

                                                children: <Widget>[
                                                  new CircleAvatar(
                                                    backgroundImage: new NetworkImage(list[index]['Image Url']),
                                                  ),
                                                  new Text(

                                                    list[index]['Category'],
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 10),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: new Text(
                                                      "Rs. " + list[index]['Price'].toString()+".00",

                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 0,),
                                            SizedBox(
                                              width: 75,
                                              child: Text(list[index]['Name'],),
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [

                                                  new Container(
                                                    child: new IconButton(
                                                      icon: new Icon(Icons.remove),
                                                      highlightColor: Colors.green,
                                                      onPressed: (){
                                                        _removeProduct(index);
                                                      },
                                                    ),
                                                  ),
                                                  new Container(
                                                    child: new Text(_counter[index].toString(),
                                                      //style : Theme.of(context).textTheme.headline4,
                                                    ),
                                                  ),
                                                  new Container(
                                                    child: new IconButton(
                                                      icon: new Icon(Icons.add),
                                                      highlightColor: Colors.green,
                                                      onPressed: (){
                                                        _addProduct(index);
                                                      },
                                                    ),
                                                  ),

                                                ]
                                            ),


                                          ],
                                        ),

                                      ),

                                    ),
                                  ),



                                ]
                            ),
                          ]
                      ),
                    ),
                      floatingActionButton: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: addToHelpNoPack,
                            tooltip: 'Increment',
                            child: Icon(Icons.add),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FloatingActionButton(
                            onPressed: addToHelp,
                            tooltip: 'Increment',
                            child: Icon(Icons.add_box),
                          ),
                        ],
                      ),
                    ),
                    Scaffold(

                      body: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                  icon: Container(
                                    margin: EdgeInsets.only(
                                        left: 20.0, top: 5.0),
                                    width: 20.0,
                                    height: 30.0,
                                    child: Icon(Icons.face,
                                      color: Colors.blue.shade600,),),
                                  hintText: "Change name..",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15.0, top: 5.0),
                                ),
                                onSubmitted: (val){
                                  userid = val;

                                },
                              ),
                              SizedBox(
                                height: 200,
                              ),
                              Container(
                                child: RaisedButton(
                                  color: Colors.green,
                                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (ctx) => CheckRazor(bill),
                                    ),
                                        (Route<dynamic> route) => false,
                                  ),
                                  child: Text(
                                    "Pay Bill:" + bill.toString()
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),

                    ),



                  ]
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.scanner),
                    title: Text('Fact'),
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    title: Text('My Help Cart'),

                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.payment),
                    title: Text('Help Out'),
                  ),


                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.lightBlueAccent,
                onTap: _onItemTapped,
                showSelectedLabels: false,
                showUnselectedLabels: false,

              ),



    ),
          );
  }


}




