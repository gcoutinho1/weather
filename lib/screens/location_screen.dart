import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.near_me,
                    size: 50,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.location_city,
                    size: 50,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text('32º'),
                  Text('IconText'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                'its time lalala',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
