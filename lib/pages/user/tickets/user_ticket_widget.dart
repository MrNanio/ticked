import 'package:flutter/material.dart';

class UserTicketsWidget extends StatefulWidget {
  const UserTicketsWidget({Key? key}) : super(key: key);

  @override
  _UserTicketsWidgetState createState() => _UserTicketsWidgetState();
}

class _UserTicketsWidgetState extends State<UserTicketsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-50,
      child: ListWheelScrollView(
        itemExtent: 280,
        diameterRatio: 4,
        children: [
          Container(
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                'item1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // List<Widget> items = [
  //   const ListTile(
  //     leading: Icon(Icons.local_activity, size: 50),
  //     title: Text('Activity'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_airport, size: 50),
  //     title: Text('Airport'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_atm, size: 50),
  //     title: Text('ATM'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_bar, size: 50),
  //     title: Text('Bar'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_cafe, size: 50),
  //     title: Text('Cafe'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_car_wash, size: 50),
  //     title: Text('Car Wash'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_convenience_store, size: 50),
  //     title: Text('Heart Shaker'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_dining, size: 50),
  //     title: Text('Dining'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_drink, size: 50),
  //     title: Text('Drink'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_florist, size: 50),
  //     title: Text('Florist'),
  //     subtitle: Text('Description here'),
  //   ),
  //   const ListTile(
  //     leading: Icon(Icons.local_gas_station, size: 50),
  //     title: Text('Gas Station'),
  //     subtitle: Text('Description here'),
  //   ),
  //   ListTile(
  //     leading: Icon(Icons.local_grocery_store, size: 50),
  //     title: Text('Grocery Store'),
  //     subtitle: Text('Description here'),
  //   ),
  // ];
}
