import 'dart:io';

import 'package:mockito/mockito.dart';

// Image data taken from here https://github.com/flutter/flutter/blob/master/packages/flutter/test/image_data.dart
const List<int> kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
];

R provideMockedNetworkImages<R>(R body(), {List<int> imageBytes = kTransparentImage, int statusCode = 200}) {
  return HttpOverrides.runZoned(
    body,
    createHttpClient: (_) => _createMockImageHttpClient(statusCode, imageBytes),
  );
}

// Taken from https://github.com/flutter/flutter/blob/master/dev/manual_tests/test/mock_image_http.dart
// Returns a mock HTTP client that responds with an image to all requests.
MockHttpClient _createMockImageHttpClient(int statusCode, List<int> imageBytes) {
  
  final MockHttpClient client = MockHttpClient();
  final MockHttpClientRequest request = MockHttpClientRequest();
  final MockHttpClientResponse response = MockHttpClientResponse();
  final MockHttpHeaders headers = MockHttpHeaders();
  when(client.getUrl(any)).thenAnswer((_) => Future<HttpClientRequest>.value(request));
  when(request.headers).thenReturn(headers);
  when(request.close()).thenAnswer((_) => Future<HttpClientResponse>.value(response));
 
  when(response.statusCode).thenReturn(statusCode);
  print("Status code of $statusCode");
  if (statusCode < 400) {
    when(response.contentLength).thenReturn(imageBytes.length);
    when(response.compressionState).thenReturn(HttpClientResponseCompressionState.notCompressed);
    when(response.listen(any)).thenAnswer((Invocation invocation) {
      final void Function(List<int>) onData = invocation.positionalArguments[0] as void Function(List<int>);
      final void Function() onDone = invocation.namedArguments[#onDone] as void Function();
      final void Function(Object, [StackTrace]) onError = invocation.namedArguments[#onError] as void Function(Object, [StackTrace]);
      final bool cancelOnError = invocation.namedArguments[#cancelOnError] as bool;
      return Stream<List<int>>.fromIterable(<List<int>>[imageBytes]).listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError);
    });
  }
  return client;

}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}
