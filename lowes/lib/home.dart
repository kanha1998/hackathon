/*


import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



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
  var _newCounter = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  var _see = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  int l = 0;
  var section = '0';

  _removeProduct(int i) {
    setState(() {
      if (_counter[i] > 0) {
        _counter[i]--;
      }
    });
  }
  _addProduct(i) {
    setState(() {
      _counter[i]++;
    });
  }


  void getList() {


    db.once().then((DataSnapshot snapshot) {
      list.clear();

      for (var i = 0; i < 25; i++) {
        Map<dynamic, dynamic> values = snapshot.value[26.toString()]["Help"][i];
        Map<dynamic, dynamic> listItems = snapshot.value[i.toString()];
        values.forEach((key, values) {
          //print(values);
        });
        listItems.forEach((key, values) {
          //print(values);
        });
        _counter[i] = _newCounter[i]-_counter[i];
        _newCounter[i] = int.parse(snapshot.value[26.toString()]["Help"][i]['counter']);
        _counter[i] = _newCounter[i]-_counter[i];
        //_removeProductAll(i);
        //print(values);
        //if(_counter[i] == 0)

        list.add(listItems);
        i == 0?print(listItems):print("l");
        //list.add(list);
        //print(list);
      }
    });
    setState(() {
      l=0;
    });
  }






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_mapController = GoogleMapController();

    getList();


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        drawer: Drawer(

          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Side menu',
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
                  setState(() {
                    section = '0';
                  });
                  Navigator.pop(context);},
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('1'),
                onTap: () {
                  setState(() {
                    section = '1';
                  });
                Navigator.of(context).pop();},
              ),
              ListTile(
                leading: Icon(Icons.crop_square),
                title: Text('2'),
                onTap: () {
                setState(() {
                section = '2';
                });
                Navigator.of(context).pop();},
              ),
              ListTile(
                leading: Icon(Icons.hotel),
                title: Text('3'),
                onTap: () {
                  setState(() {
                    section = '3';
                  });
                  Navigator.of(context).pop();},
              ),
              ListTile(
                leading: Icon(Icons.kitchen),
                title: Text('4'),
                onTap: () {
                  setState(() {
                    section = '4';
                  });
                  Navigator.of(context).pop();},
              ),


            ],
          ),
        ),
        appBar: AppBar(

          title: Text("Helper Employee"),

        ),
        body: Scaffold(body: l == 1? Text("loading"):new ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext ctxt, int index) => list[index]["Section"].toString() != section && section != "0"?Container():Column(
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

                                SizedBox(
                                  width: 100,
                                  child: Text(list[index]['Name'],),
                                ),
                                SizedBox(width: 20,),
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
          floatingActionButton: FloatingActionButton(
            onPressed: (){getList(); setState(() {

            });},
            child: Icon(Icons.update),
          ),

        ),










    );
  }


}
*/







import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



var listr = new List();
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
  int l = 0,k=1;

  var orderNames = new List();
  var listOfOrders = new List();
  List<int> visible = new List();
  List<int> status = new List();

  var _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  var _newCounter = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  var _see = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

  var section = '0';

  _removeProduct(int i) {
    setState(() {
      if (_counter[i] > 0) {
        _counter[i]--;
      }
    });
  }
  _addProduct(i) {
    setState(() {
      _counter[i]++;
    });
  }


  void getList() {


    db.once().then((DataSnapshot snapshot) {
      list.clear();

      for (var i = 0; i < 25; i++) {
        Map<dynamic, dynamic> values = snapshot.value[26.toString()]["Help"][i];
        Map<dynamic, dynamic> listItems = snapshot.value[i.toString()];
        values.forEach((key, values) {
          //print(values);
        });
        listItems.forEach((key, values) {
          //print(values);
        });
        _counter[i] = _newCounter[i]-_counter[i];
        _newCounter[i] = int.parse(snapshot.value[26.toString()]["Help"][i]['counter']);
        _counter[i] = _newCounter[i]-_counter[i];
        //_removeProductAll(i);
        //print(values);
        //if(_counter[i] == 0)

        list.add(listItems);
        i == 0?print(listItems):print("l");
        //list.add(list);
        //print(list);
      }
    });
    setState(() {
      l=0;
    });
  }






  void getListr() {


    db.once().then((DataSnapshot snapshot) {
      print(snapshot.value["orders"]["customer2"].length);
       {
       // Map<dynamic, dynamic> values = snapshot.value[26.toString()]["Help"][i];
       // Map<dynamic, dynamic> listItems = snapshot.value[i.toString()];
        Map<dynamic, dynamic> orders = snapshot.value["orders"];
        var i = 0;
        var newLength = orders.length;
        var oldLength = status.length;
        orders.forEach((key, value) {
          visible.add(0);
          i++;
          if(i<=newLength-oldLength)
          status.insert(0,0);

          var listr = new List();
          orderNames.add(key);
          print(key);
          print(orderNames.first.toString());
          for (var i = 1; i < value.length; i++)
            listr.add(value[i]);

          listOfOrders.add(listr);
          setState(() {


            print(listOfOrders[0][0].toString());
          });

        });


        //list.add(list);
        //print(list);
        debugPrint("ko "+listOfOrders[1][0].toString());
      }
    });

    setState(() {

      l=0;
    });
  }






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_mapController = GoogleMapController();

    getListr();


  }
  var o = 0;



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

        body: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
        Scaffold(

        drawer: Drawer(

          child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Side menu',
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
                setState(() {
                  section = '0';
                });
                //Navigator.pop(context);
                },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('1'),
              onTap: () {
                setState(() {
                  section = '1';
                });
                },
            ),
            ListTile(
              leading: Icon(Icons.crop_square),
              title: Text('2'),
              onTap: () {
                setState(() {
                  section = '2';
                });
                },
            ),
            ListTile(
              leading: Icon(Icons.hotel),
              title: Text('3'),
              onTap: () {
                setState(() {
                  section = '3';
                });
                },
            ),
            ListTile(
              leading: Icon(Icons.kitchen),
              title: Text('4'),
              onTap: () {
                setState(() {
                  section = '4';
                });
                },
            ),


          ],
        ),
      ),
      appBar: AppBar(

        title: Text("Helper Employee"),

      ),
      body: Scaffold(

        body: l == 1? Text("loading"):new ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext ctxt, int index) => list[index]["Section"].toString() != section && section != "0"?Container():Column(
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

                              SizedBox(
                                width: 100,
                                child: Text(list[index]['Name'],),
                              ),
                              SizedBox(width: 20,),
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){getList(); setState(() {

          });},
          child: Icon(Icons.update),
        ),

      ),










    ),
            Scaffold(
              appBar: AppBar(
                leading: Image.network('https://www.lowes.com/images/logos/2016_lowes_logo/lowes_logo_pms_280/Lowes_logo_pms_280.png'),
                title: Text("Helper Employee"),
              ),body: l == 1? Text("loading"): Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: new ListView.builder(
                      itemCount: listOfOrders.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctxt, int index1) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Card(
                            child: Container(
                              height: 100,

                              child: Column(
                                children:<Widget>[
                                  Row(

                                  children: <Widget>[
                                    new Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                        child: new Text(
                                            orderNames.length == 0? "":orderNames[index1].toString(),

                                          ),
                                    ),
                                    SizedBox(
                                      width: 250,
                                    ),
                                    IconButton(
                                      icon: visible[index1] == 1?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down),
                                      onPressed: ()=>visible[index1]==0?setState(() {
                                        visible[index1] = 1;
                                      }):setState(() {
                                        visible[index1] = 0;
                                      }),
                                    ),
                                  ],
                                ),
                                  RaisedButton(
                                    child: status[index1] == 0?Text("Pending"):Text("Done"),
                                    color: status[index1] == 0?Colors.grey:Colors.greenAccent,
                                    onPressed: ()=>setState(() {
                                      status[index1] = (status[index1]+1)%2;
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          visible[index1] == 0 ? Container():new ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,

                                  itemCount: listOfOrders[index1].length,
                                  physics: ClampingScrollPhysics(),

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
                                                                backgroundImage: new NetworkImage(listOfOrders[index1][index]['Image Url']),
                                                              ),
                                                              new Text(

                                                                listOfOrders[index1][index]['Category'],
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 10),
                                                              ),
                                                              FittedBox(
                                                                fit: BoxFit.contain,
                                                                child: new Text(
                                                                  "Rs. " + listOfOrders[index1][index]['Price'].toString()+".00",

                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          width: 100,
                                                          child: Text(listOfOrders[index1][index]['Name'],),
                                                        ),
                                                        SizedBox(width: 50,),
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [


                                                              new Container(
                                                                child: new Text(listOfOrders[index1][index]['count'].toString(),
                                                                  //style : Theme.of(context).textTheme.headline4,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){ listOfOrders.clear(); orderNames.clear(); getListr(); setState(() {

                });},
                child: Icon(Icons.update),
                ),

              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              title: Text('Fact'),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('My Help Cart'),

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




