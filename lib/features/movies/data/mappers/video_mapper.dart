


import 'package:periferiamovies/features/movies/data/models/moviedb/moviedb_videos.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/video.dart';

class VideoMapper {

  static moviedbVideoToEntity( Result moviedbVideo ) => Video(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt
  );


}