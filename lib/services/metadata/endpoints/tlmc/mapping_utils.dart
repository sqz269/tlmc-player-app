import 'package:backend_client_api/api.dart';
import 'package:spotube/models/metadata/metadata.dart';
import 'package:spotube/services/metadata/interfaces/browse_endpoint.dart';

class TlmcToSpotubeMappingUtils {
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

  static int durationStringToMilliseconds(String duration) {
    // in format of hh:mm:ss.ms, with possible leading zeros
    // or missing hours and seconds
    // return the duration in milliseconds
    var parts = duration.split('.');
    var seconds = parts[0].split(':').reversed.toList();
    // var milliseconds = int.parse(parts[1]);
    var milliseconds = 0;

    var coefficients = 1;
    for (var part in seconds) {
      milliseconds += int.parse(part) * coefficients;
      coefficients *= 60;
    }
    return milliseconds * 1000;
  }

  static SpotubeFullTrackObject toSpotubeFullTrackObject(
      TrackReadDto track, AlbumReadDto album) {
    return SpotubeFullTrackObject(
      id: track.id!,
      name: track.name!.default_,
      externalUri: "https://google.com/",
      artists: [],
      album: toSpotubeSimpleAlbumObject(album),
      durationMs: durationStringToMilliseconds(track.duration!),
      isrc: '',
      explicit: false,
    );
  }
}
