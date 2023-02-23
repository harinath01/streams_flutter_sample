import '../constants.dart';

class Asset {
  final String title;
  final String type;
  final VideoDetails videoDetails;
  final String id;
  String get drmLicenseUrl => 'https://app.tpstreams.com/api/v1/${Constants.ORG_CODE}/assets/$id/drm_license/';

  Asset({
    required this.title,
    required this.type,
    required this.videoDetails,
    required this.id,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      title: json['title'],
      type: json['type'],
      videoDetails: VideoDetails.fromJson(json['video']),
      id: json['id'],
    );
  }
}

class VideoDetails {
  final int progress;
  final List<String> thumbnails;
  final String status;
  final String playbackUrl;
  final String dashUrl;
  final String? previewThumbnailUrl;
  final String format;
  final List<String> resolutions;
  final String videoCodec;
  final String audioCodec;
  final bool enableDrm;
  final List<Track> tracks;
  final List<Input> inputs;

  VideoDetails({
    required this.progress,
    required this.thumbnails,
    required this.status,
    required this.playbackUrl,
    required this.dashUrl,
    required this.previewThumbnailUrl,
    required this.format,
    required this.resolutions,
    required this.videoCodec,
    required this.audioCodec,
    required this.enableDrm,
    required this.tracks,
    required this.inputs,
  });

  factory VideoDetails.fromJson(Map<String, dynamic> json) {
    final List<Track> tracks = [];
    if (json.containsKey('tracks')) {
      final List<dynamic> tracksJson = json['tracks'];
      tracks.addAll(tracksJson.map((trackJson) => Track.fromJson(trackJson)));
    }

    return VideoDetails(
      progress: json['progress'],
      thumbnails: List<String>.from(json['thumbnails']),
      status: json['status'],
      playbackUrl: json['playback_url'],
      dashUrl: json['dash_url'],
      previewThumbnailUrl: json['preview_thumbnail_url'],
      format: json['format'],
      resolutions: List<String>.from(json['resolutions']),
      videoCodec: json['video_codec'],
      audioCodec: json['audio_codec'],
      enableDrm: json['enable_drm'],
      tracks: tracks,
      inputs: (json['inputs'] as List<dynamic>)
          .map((inputJson) => Input.fromJson(inputJson))
          .toList(),
    );
  }
}

class Track {
  final String type;
  final String uri;

  Track({
    required this.type,
    required this.uri,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      type: json['type'],
      uri: json['uri'],
    );
  }
}

class Input {
  final String url;

  Input({
    required this.url,
  });

  factory Input.fromJson(Map<String, dynamic> json) {
    return Input(
      url: json['url'],
    );
  }
}
