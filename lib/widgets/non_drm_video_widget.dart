import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

import '../models/asset.dart';
import '../utils/api_utils.dart';
import '../constants.dart';

class NonDRMVideoWidget extends StatefulWidget {
  const NonDRMVideoWidget({Key? key}) : super(key: key);

  @override
  _NonDRMVideoWidgetState createState() => _NonDRMVideoWidgetState();
}

class _NonDRMVideoWidgetState extends State<NonDRMVideoWidget> {
  late Future<Asset> _assetFuture;

  @override
  void initState() {
    super.initState();
    _assetFuture = fetchAsset(Constants.NON_DRM_ASSET_ID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Non DRM video'),
      ),
      body: Center(
        child: FutureBuilder<Asset>(
          future: _assetFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BetterPlayerWidget(playbackURL: snapshot.data!.videoDetails.playbackUrl);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class BetterPlayerWidget extends StatefulWidget {
  const BetterPlayerWidget({Key? key, required this.playbackURL}) : super(key: key);

  final String playbackURL;

  @override
  _BetterPlayerWidgetState createState() => _BetterPlayerWidgetState();
}

class _BetterPlayerWidgetState extends State<BetterPlayerWidget> {
  late BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = BetterPlayerController(
      const BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: true,
          enableSkips: false,
          enableFullscreen: true,
          enableOverflowMenu: true,
          overflowMenuCustomItems: [],
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.playbackURL,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _controller,
    );
  }
}
