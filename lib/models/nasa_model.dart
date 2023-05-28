// ignore_for_file: public_member_api_docs, sort_constructors_first
class NasaModel {
  final String? title;
  final String? url;
  final String? description;
  final String? date;
  final String? hdurl;
  final List? keywords;
  final String? mediaType;
  final String? center;
  final String? nasaId;

  NasaModel({
    this.title,
    this.url,
    this.description,
    this.date,
    this.hdurl,
    this.keywords,
    this.mediaType,
    this.center,
    this.nasaId,
  });

  factory NasaModel.fromJson(Map<String, dynamic> json) {
    return NasaModel(
      title: json['data'][0]['title'] == null
          ? "Unknown Title"
          : json['data'][0]['title'],
      date: json['data'][0]['date_created'] == null
          ? "Unknown Date"
          : json['data'][0]['date_created'],
      url: json['links'][0]['href'] == null
          ? "Unknown URL"
          : json['links'][0]['href'],
      hdurl: json['href'] == null ? "Unknown HDURL" : json['href'],
      description: json['data'][0]['description'] == null
          ? "Unknown Description"
          : json['data'][0]['description'],
      keywords: json['data'][0]['keywords'] == null
          ? []
          : json['data'][0]['keywords'],
      mediaType: json['data'][0]['media_type'] == null
          ? "Unknown Media Type"
          : json['data'][0]['media_type'],
      center: json['data'][0]['center'] == null
          ? "Unknown Center"
          : json['data'][0]['center'],
      nasaId: json['data'][0]['nasa_id'] == null
          ? "Unknown Nasa ID"
          : json['data'][0]['nasa_id'],
    );
  }
  factory NasaModel.fromJsonSearch(Map<String, dynamic> json) {
    return NasaModel(
      title: json['data'][0]['title'] == null
          ? "Unknown Title"
          : json['data'][0]['title'],
      date: json['data'][0]['date_created'] == null
          ? "Unknown Date"
          : json['data'][0]['date_created'],
      hdurl: json['href'] == null ? "Unknown HDURL" : json['href'],
      description: json['data'][0]['description'] == null
          ? "Unknown Description"
          : json['data'][0]['description'],
      keywords: json['data'][0]['keywords'] == null
          ? []
          : json['data'][0]['keywords'],
      mediaType: json['data'][0]['media_type'] == null
          ? "Unknown Media Type"
          : json['data'][0]['media_type'],
      center: json['data'][0]['center'] == null
          ? "Unknown Center"
          : json['data'][0]['center'],
      nasaId: json['data'][0]['nasa_id'] == null
          ? "Unknown Nasa ID"
          : json['data'][0]['nasa_id'],
    );
  }
}
