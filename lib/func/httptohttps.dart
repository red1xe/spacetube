String httpsConverter(String url) {
  Uri uri = Uri.parse(url);
  Uri httpsUri = uri.replace(scheme: 'https');
  return httpsUri.toString();
}
