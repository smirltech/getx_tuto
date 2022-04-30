import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tuto/modules/shop_module/screens/home/shop_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Get.toNamed('/second');
        },
        child: const Icon(Icons.navigate_next),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showSnakbar,
              child: const Text('Snackbar'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showDialog,
              child: const Text('Dialog'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showBottomSheet,
              child: const Text('BottomSheet'),
            ),
          ],
        ),
      ),
    );
  }

  _showSnakbar() {
    Get.snackbar(
      'Snackbar',
      'Ceci est un snackbar',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.deepOrange,
      snackStyle: SnackStyle.GROUNDED,
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        onPressed: () {},
        child: const Text('OK'),
      ),
    );
  }

  _showDialog() {
    Get.defaultDialog(
      title: 'Dialog',
      middleText: 'Ceci est un dialog du middle text',
      content: const Text('Ceci est un dialog du content'),
      backgroundColor: Colors.teal,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OUI'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("JE NE SAIS PAS"),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('NO'),
        ),
      ],
    );
  }

  _showBottomSheet() {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 200,
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ceci est un bottom sheet'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.amber,
    );
  }
}
