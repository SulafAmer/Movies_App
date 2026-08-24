import 'package:dio/dio.dart';
//just for learning purpose
//no need for this interceptor while we are using pretty logger interceptor
//can be improved when we need more actions to be done by the interceptor

class DioInterceptor extends Interceptor
{

 @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
    print('REQUEST:${options.method}${options.uri}');
  }
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print('RESPONSE:${response.statusMessage}${response.requestOptions.uri}');

    super.onResponse(response, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    print('ERROR:${err.message}${err.requestOptions.uri}');

    super.onError(err, handler);
  }
}