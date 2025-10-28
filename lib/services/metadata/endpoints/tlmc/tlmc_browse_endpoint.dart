import 'package:backend_client_api/api.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/browse_endpoint.dart';

/// TLMC implementation of MetadataBrowseEndpointInterface
class TlmcBrowseEndpoint implements MetadataBrowseEndpointInterface {
  static SpotubeSimpleArtistObject toSpotubeSimpleArtistObject(
      CircleReadDto artist) {
    return SpotubeSimpleArtistObject(
      id: artist.id!,
      name: artist.name!,
      externalUri: 'https://google.com/',
      images: [],
    );
  }

  static SpotubeImageObject? toSpotubeImageObjectFromAsset(
      AssetReadDto? image, int width, int height) {
    if (image == null) {
      return null;
    }
    return SpotubeImageObject(
      url: image.url!,
      width: width,
      height: height,
    );
  }

  static List<SpotubeImageObject> toSpotubeImageObjectFromThumbnail(
      ThumbnailReadDto? thumbnail) {
    if (thumbnail == null) {
      return [];
    }
    var imagesList = <SpotubeImageObject?>[];
    imagesList.add(toSpotubeImageObjectFromAsset(thumbnail.large, 500, 500));
    imagesList.add(toSpotubeImageObjectFromAsset(thumbnail.medium, 300, 300));
    imagesList.add(toSpotubeImageObjectFromAsset(thumbnail.small, 100, 100));
    imagesList.add(toSpotubeImageObjectFromAsset(thumbnail.tiny, 50, 50));

    return imagesList
        .where((image) => image != null)
        .cast<SpotubeImageObject>()
        .toList();
  }

  static SpotubeFullAlbumObject toSpotubeFullAlbumObject(AlbumReadDto album) {
    return SpotubeFullAlbumObject(
      id: album.id!,
      name: album.name!.default_,
      artists: album.albumArtist!
          .map((artist) => toSpotubeSimpleArtistObject(artist))
          .toList(),
      releaseDate: album.releaseDate!.toIso8601String(),
      externalUri: 'https://google.com/',
      totalTracks: album.tracks!.length,
      albumType: SpotubeAlbumType.album,
      images: toSpotubeImageObjectFromThumbnail(album.thumbnail),
    );
  }

  static SpotubeSimpleAlbumObject toSpotubeSimpleAlbumObject(
      AlbumReadDto album) {
    return SpotubeSimpleAlbumObject(
      id: album.id!,
      name: album.name!.default_,
      artists: album.albumArtist!
          .map((artist) => toSpotubeSimpleArtistObject(artist))
          .toList(),
      externalUri: 'https://google.com/',
      albumType: SpotubeAlbumType.album,
      images: toSpotubeImageObjectFromThumbnail(album.thumbnail),
    );
  }

  static SpotubeBrowseSectionObject<Object> toSpotubeBrowseSectionObject(
      List<AlbumReadDto> album) {
    return SpotubeBrowseSectionObject<Object>(
      id: "Albums Section",
      title: "Albums",
      externalUri: 'https://google.com/',
      browseMore: false,
      items: album.map((item) => toSpotubeSimpleAlbumObject(item)).toList(),
    );
  }

  @override
  Future<SpotubePaginationResponseObject<SpotubeBrowseSectionObject<Object>>>
      sections({
    int? offset,
    int? limit,
  }) async {
    var offsetInt = offset ?? 0;
    var limitInt = limit ?? 20;

    var client = ApiClient(basePath: 'https://staging-api.marisad.me');
    var albumApi = AlbumApi(client);
    var response = await albumApi.getAlbums(
      start: offsetInt,
      limit: limitInt,
      sortOrder: SortOrder.descending,
      sort: AlbumOrderOptions.date,
    );

    if (response == null) {
      return SpotubePaginationResponseObject<
          SpotubeBrowseSectionObject<Object>>(
        limit: 0,
        nextOffset: 0,
        total: 0,
        hasMore: false,
        items: [],
      );
    }

    return SpotubePaginationResponseObject<SpotubeBrowseSectionObject<Object>>(
      limit: limitInt,
      nextOffset: response.count ?? 0 + limitInt,
      total: response.total ?? 0,
      hasMore: true,
      items: [toSpotubeBrowseSectionObject(response.albums!)],
    );
  }

  @override
  Future<SpotubePaginationResponseObject<Object>> sectionItems(
    String id, {
    int? offset,
    int? limit,
  }) async {
    throw UnimplementedError(
        'TLMC browse section items endpoint not implemented yet');
  }
}
