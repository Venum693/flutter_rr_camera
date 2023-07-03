
import 'package:dio/dio.dart';

import '../models/model_retuarant.dart';

abstract class RideCaptainRepository{
  Future<AllRestaurantItem> allRestaurants({required double lat,required double lng,required int page});
  Future getRestaurantAudioLink({required String restaurantId});
  Future dislikeRestaurantApi({required String restauratId});
}

class RidesApi implements RideCaptainRepository{

  final Dio _dio=Dio(
      //BaseOptions(baseUrl: "https://dev-api.realroadies.com/")
  );

  String token='Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlNXSmtyLXFSRjlja2RzUUwxaWMwViJ9.eyJpc3MiOiJodHRwczovL3JlYWxyb2FkaWVzLnVzLmF1dGgwLmNvbS8iLCJzdWIiOiJzbXN8NjQwZmZiMjhlZWUzNzJkNzk4M2M3MDI2IiwiYXVkIjpbImh0dHBzOi8vcmVhbHJvYWRpZXMudXMuYXV0aDAuY29tL2FwaS92Mi8iLCJodHRwczovL3JlYWxyb2FkaWVzLnVzLmF1dGgwLmNvbS91c2VyaW5mbyJdLCJpYXQiOjE2ODgwMzQxODEsImV4cCI6MTY4ODAzNzc4MSwiYXpwIjoidGFXODE2QzhPZDYyb0RKcVFsS1JhNW9JR1hwTjNsWHEiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIHBob25lIHJlYWQ6Y3VycmVudF91c2VyIHVwZGF0ZTpjdXJyZW50X3VzZXJfbWV0YWRhdGEgZGVsZXRlOmN1cnJlbnRfdXNlcl9tZXRhZGF0YSBjcmVhdGU6Y3VycmVudF91c2VyX21ldGFkYXRhIGNyZWF0ZTpjdXJyZW50X3VzZXJfZGV2aWNlX2NyZWRlbnRpYWxzIGRlbGV0ZTpjdXJyZW50X3VzZXJfZGV2aWNlX2NyZWRlbnRpYWxzIHVwZGF0ZTpjdXJyZW50X3VzZXJfaWRlbnRpdGllcyBvZmZsaW5lX2FjY2VzcyIsImd0eSI6InBhc3N3b3JkIn0.rqoyqR9N7OzCpQJALBErGGweP-vgQRYN5R0AfqYmDEJuqfTs0yAq3o6I5ytFI44FJAM2vjR-kazCGsd5AGNM4PsPKNAQuC_kMeRs11HaZDbyNVY4siT0fYJt776dYVpptdtOTyaIjzVvBDtGiwl2k_FP4mHTsFZri1lDd6c7RHTzLvfu9ZtfOPxi2itlnJkOFJU7IrD5fQ115bjf9tqdoI07lhIClozcA_EsCmiKGOL865xAns-T2iltPTV3riBytt6C4DjMybrjd1uHjrXOkDS8g7so_9YbgDh4mTHtqjVgdmil47XC0BFNjHWMh5ProSqH9xcg3Kc_9YWO7rzQWQ';

  @override
  Future<AllRestaurantItem> allRestaurants({required double lat, required double lng, required int page}) async {

    print('inside ---------------api call-------------$lat,$lng,--->$page');
    try{
      var response = await _dio.get('https://dev-api.realroadies.com/api/v1/location/fetch-all-restaurents/${lat}/${lng}?page=${page}&size=50',
      options: Options(headers: {'Authorization': '$token'}));
      print('Response : ${response.data}');
      print('Response Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response REALURI is ${response.realUri.path}');


      if(response.statusCode==200){
        print('--------------------------------api call is success--');
        return AllRestaurantItem.fromJson(response.data);
      }
      else{
        throw response.statusCode ?? 500;
      }

    } on DioException catch(e){
      print(e);
      throw Exception(e.response?.data);
    }
  }

  @override
  Future dislikeRestaurantApi({required String restauratId}) {
    // TODO: implement dislikeRestaurantApi
    throw UnimplementedError();
  }

  @override
  Future getRestaurantAudioLink({required String restaurantId}) {
    // TODO: implement getRestaurantAudioLink
    throw UnimplementedError();
  }
  
}