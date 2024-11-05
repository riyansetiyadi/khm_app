String? getResponseFromUrl(String url) {
  String cleanedUrl = cleanUrl(url);
  switch (cleanedUrl) {
    case 'https://simkhm.id':
      return '/home';
    case 'https://example.com/about':
      return 'About Page';
    case 'https://example.com/contact':
      return 'Contact Page';
    default:
      return null;
  }
}

String cleanUrl(String url) {
  Uri uri = Uri.parse(url);
  // Ambil hanya bagian path tanpa query parameters dan tanpa trailing slash
  String cleanedUrl = uri.origin + uri.path;
  // Menghilangkan tanda '/' di akhir URL jika ada
  return cleanedUrl.endsWith('/')
      ? cleanedUrl.substring(0, cleanedUrl.length - 1)
      : cleanedUrl;
}
