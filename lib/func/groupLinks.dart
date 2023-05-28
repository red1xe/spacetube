List<dynamic> groupmp4links(List<dynamic> links) {
  List<dynamic> mp4Links =
      links.where((link) => link.endsWith('orig.mp4')).toList();
  return mp4Links;
}

List<dynamic> groupmp3links(List<dynamic> links) {
  List<dynamic> mp3Links =
      links.where((link) => link.endsWith('.mp3')).toList();
  return mp3Links;
}
