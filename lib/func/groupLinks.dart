List<dynamic> groupmp4links(List<dynamic> links) {
  List<dynamic> mp4Links =
      links.where((link) => link.endsWith('orig.mp4')).toList();
  print(mp4Links);
  return mp4Links;
}

List<dynamic> groupmp3links(List<dynamic> links) {
  List<dynamic> mp3Links =
      links.where((link) => link.endsWith('.mp3')).toList();
  print(mp3Links);
  return mp3Links;
}
