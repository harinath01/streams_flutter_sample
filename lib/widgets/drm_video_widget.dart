import 'package:flutter/material.dart';

class DRMVideoWidget extends StatelessWidget {
  const DRMVideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DRM video'),
      ),
      body: const Center(
        child: Text('This is the second widget!'),
      ),
    );
  }
}