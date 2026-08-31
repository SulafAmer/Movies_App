/// status : "ok"
/// status_message : "Query was successful"
/// data : {"movie_count":0,"movies":[...]}
/// @meta : {"api_version":2,"execution_time":"0 ms"}

class MovieSuggestion {
  MovieSuggestion({this.status, this.statusMessage, this.data, this.meta});

  MovieSuggestion.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;

    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }

  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['status'] = status;
    map['status_message'] = statusMessage;

    if (data != null) {
      map['data'] = data!.toJson();
    }

    if (meta != null) {
      map['@meta'] = meta!.toJson();
    }

    return map;
  }
}

/// api_version : 2
/// execution_time : "0 ms"

class Meta {
  Meta({this.apiVersion, this.executionTime});

  Meta.fromJson(dynamic json) {
    apiVersion = (json['api_version'] as num?)?.toInt();
    executionTime = json['execution_time'];
  }

  int? apiVersion;
  String? executionTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['api_version'] = apiVersion;
    map['execution_time'] = executionTime;

    return map;
  }
}

/// movie_count : 0
/// movies : [...]

class Data {
  Data({this.movieCount, this.movies});

  Data.fromJson(dynamic json) {
    movieCount = (json['movie_count'] as num?)?.toInt();

    if (json['movies'] != null) {
      movies = (json['movies'] as List).map((v) => Movies.fromJson(v)).toList();
    }
  }

  int? movieCount;
  List<Movies>? movies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['movie_count'] = movieCount;

    if (movies != null) {
      map['movies'] = movies!.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

/// Movie model

class Movies {
  Movies({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Movies.fromJson(dynamic json) {
    id = (json['id'] as num?)?.toInt();

    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];

    year = (json['year'] as num?)?.toInt();

    // مهم جدًا عشان الـ API ممكن يرجع int أو double
    rating = (json['rating'] as num?)?.toDouble();

    runtime = (json['runtime'] as num?)?.toInt();

    genres = json['genres'] != null ? List<String>.from(json['genres']) : [];

    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    state = json['state'];

    if (json['torrents'] != null) {
      torrents = (json['torrents'] as List)
          .map((v) => Torrents.fromJson(v))
          .toList();
    }

    dateUploaded = json['date_uploaded'];

    dateUploadedUnix = (json['date_uploaded_unix'] as num?)?.toInt();
  }

  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['state'] = state;

    if (torrents != null) {
      map['torrents'] = torrents!.map((v) => v.toJson()).toList();
    }

    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;

    return map;
  }
}

/// Torrent model

class Torrents {
  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Torrents.fromJson(dynamic json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];

    seeds = (json['seeds'] as num?)?.toInt();
    peers = (json['peers'] as num?)?.toInt();

    size = json['size'];

    sizeBytes = (json['size_bytes'] as num?)?.toInt();

    dateUploaded = json['date_uploaded'];

    dateUploadedUnix = (json['date_uploaded_unix'] as num?)?.toInt();
  }

  String? url;
  String? hash;
  String? quality;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
    map['is_repack'] = isRepack;
    map['video_codec'] = videoCodec;
    map['bit_depth'] = bitDepth;
    map['audio_channels'] = audioChannels;
    map['seeds'] = seeds;
    map['peers'] = peers;
    map['size'] = size;
    map['size_bytes'] = sizeBytes;
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;

    return map;
  }
}
