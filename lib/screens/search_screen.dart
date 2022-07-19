import 'package:flutter/material.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/widgets/custom_button.dart';
// import 'package:clima/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            kSearchBackgroundImage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: kTextFieldInput,
                    onChanged: (value) {
                      cityName = value;
                      // print(value);
                    },
                  ),
                ),
                CustomButton(
                  buttonText: 'Obter previsão do tempo',
                  onTap: () {
                    Navigator.pop(context, cityName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
