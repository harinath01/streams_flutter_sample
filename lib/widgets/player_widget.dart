import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

import '../models/asset.dart';
import '../utils/api_utils.dart';
import '../constants.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String assetId;

  const VideoPlayerWidget({Key? key, required this.assetId}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late Future<Asset> _assetFuture;

  @override
  void initState() {
    super.initState();
    _assetFuture = fetchAsset(widget.assetId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streams video player'),
      ),
      body: Center(
        child: FutureBuilder<Asset>(
          future: _assetFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BetterPlayerWidget(asset: snapshot.data!);
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
  const BetterPlayerWidget({Key? key, required this.asset}) : super(key: key);

  final Asset asset;

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
        widget.asset.videoDetails.enableDrm ? widget.asset.videoDetails.dashUrl : widget.asset.videoDetails.playbackUrl,
        drmConfiguration: widget.asset.videoDetails.enableDrm ? BetterPlayerDrmConfiguration(
          drmType: BetterPlayerDrmType.widevine,
          licenseUrl: widget.asset.drmLicenseUrl,
          headers: {'Authorization': 'Token ${Constants.AUTHORIZATION_TOKEN}'},
        ) : null,
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