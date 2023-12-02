import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_app/features/authentication/service/authentication_service.dart';

import '../constants/key_constants.dart';
import '../constants/string_constants.dart';

final chopperClient = ChopperClient(
  baseUrl: Uri.parse(StringConstants.kBaseUrl),
  services: services,
  converter: JsonToTypeConverter(typeToJsonFactoryMap),
  interceptors: [HttpLoggingInterceptor(), TokenInterceptor()],
  // authenticator: TokenAuthenticator(),
);

List<ChopperService> get services => [
      AuthenticationService.create(),
    ];

Map<Type, Function> get typeToJsonFactoryMap => {
// AuthSuccess: (json) => AuthSuccess.fromJson(json),
// Product: (json) => Product.fromJson(json),
    };

class TokenAuthenticator extends Authenticator {
  @override
  FutureOr<Request?> authenticate(Request request, Response response,
      [Request? originalRequest]) async {
    if (response.statusCode == 401) {
      final preffs = await SharedPreferences.getInstance();
      final token = preffs.getString(KeyConstants.kCachedToken) ?? '';
      final updatedHeaders = Map<String, String>.of(request.headers);

      if (token.isNotEmpty) {
        updatedHeaders.update('Authorization', (value) => 'Bearer $token',
            ifAbsent: () => 'Bearer $token');
        return request.copyWith(headers: updatedHeaders);
      }
    }
    return null;
  }
}

class TokenInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final preffs = await SharedPreferences.getInstance();
    final token = preffs.getString(KeyConstants.kCachedToken) ?? '';
    request.copyWith(headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $token",
    });
    return request;
  }
}

class JsonToTypeConverter extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap;

  const JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(
          response.body, typeToJsonFactoryMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function? jsonParser) {
    var jsonMap = json.decode(jsonData);
    if (jsonParser == null) {
      return jsonMap as T;
    }
    if (jsonMap is List) {
      return jsonMap
          .map((item) => jsonParser(item as Map<String, dynamic>) as InnerType)
          .toList() as T;
    }

    return jsonParser(jsonMap);
  }
}
