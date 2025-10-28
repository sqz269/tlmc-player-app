import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for track endpoints
abstract class MetadataTrackEndpointInterface {
  /// Get a full track by ID
  Future<SpotubeFullTrackObject> getTrack(String id);

  /// Save tracks
  Future<void> save(List<String> ids);

  /// Unsave tracks
  Future<void> unsave(List<String> ids);

  /// Get track radio (recommendations)
  Future<List<SpotubeFullTrackObject>> radio(String id);
}
