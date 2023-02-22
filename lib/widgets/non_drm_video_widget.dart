import 'package:flutter/material.dart';


class NonDRMVideoWidget extends StatelessWidget {
  const NonDRMVideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Non DRM video'),
      ),
      body: const Center(
        child: Text('This is the first widget!'),
      ),
    );
  }
}