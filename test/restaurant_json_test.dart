import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:submission1_restaurant_app/data/api/api_service.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_list.dart';

import 'restaurant_json_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
    group('Testing Restaurant List', ()
  {
    test('returns a Restaurant if the http call completes successfully',
      () async {
          final client = MockClient();
          var response =
              '{"error": false, "message": "success", "count": 20, "restaurants": []}';

          when(client.get(Uri.parse(ApiService.baseUrl + "list")),
          ).thenAnswer((_) async => http.Response(response, 200));

  
          expect(await ApiService(client: client).listRestaurant(),
          isA<RestaurantList>());
        });
    test('throws an exception if the http call completes with an error',
      () async {
          final client = MockClient();
          
          when(client.get(Uri.parse(ApiService.baseUrl + "list")))
              .thenAnswer((_) async => http.Response('Not Found', 404));

          expect(await ApiService(client: client).listRestaurant(),
          isA<RestaurantList>());
        });
      });
}