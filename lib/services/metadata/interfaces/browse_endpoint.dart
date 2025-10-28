import 'package:spotube/models/metadata/metadata.dart';

/// Abstract interface for browse endpoints
abstract class MetadataBrowseEndpointInterface {
  /// Get browse sections
  Future<SpotubePaginationResponseObject<SpotubeBrowseSectionObject<Object>>>
      sections({
    int? offset,
    int? limit,
  });

  /// Get section items
  Future<SpotubePaginationResponseObject<Object>> sectionItems(
    String id, {
    int? offset,
    int? limit,
  });
}
