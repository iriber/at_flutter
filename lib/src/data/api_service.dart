import 'dart:convert';
import 'dart:io';

import 'package:agro_tracking_flutter/src/data/exceptions/at_exception.dart';
import 'package:agro_tracking_flutter/src/data/exceptions/connectivity_exception.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:http/http.dart' as http;
import 'package:fiona_logger/src/log/fiona_logger.dart';

import 'connectivity.dart';

class ApiService {

  FionaLogger logger = DependencyManager().get<FionaLogger>();


  Future<dynamic> get(url, {Map<String,String>? headers}) async {
    try {

      await checkConnection();

      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } on SocketException catch (e1) {
      Future.error(throw connectivityException, StackTrace.current);
    } on ConnectivityException catch (e3) {
      Future.error(throw e3, StackTrace.current);
    } on Exception catch (e2) {
      Future.error(throw AtException(message:e2.toString()), StackTrace.current);
    }
  }

  Future<List<dynamic>> getList(url, {Map<String,String>? headers}) async {
    try {

      await checkConnection();

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        logger.d("API LIST");
        logger.d( response.body);
        return jsonDecode(response.body);
      }else{
        Future.error(throw Exception(response.statusCode), StackTrace.current);
      }
    } on SocketException catch (e1) {
      Future.error(throw connectivityException, StackTrace.current);
    } on ConnectivityException catch (e3) {
      Future.error(throw e3, StackTrace.current);
    } on Exception catch (e2) {
      Future.error(throw AtException(message:e2.toString()), StackTrace.current);
    }
  }

  Future<dynamic> post(Uri url, Map data, { Map<String,String>? headers }) async {
    try {

      await checkConnection();

      String body = json.encode(data);

      logger.d("POST to $url");
      logger.d("POST data $body");

      if(headers==null){
        headers = {"Content-Type": "application/json"};
      }

      final response =  await http.post(url,
          headers: headers ,
          body: body );

      logger.d("Response status: ${response.statusCode}");
      logger.d("Response body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }else {
        Future.error(throw AtException(message:"POST ${response.statusCode}"), StackTrace.current);
      }


    } on SocketException catch (e1) {
      Future.error(throw connectivityException, StackTrace.current);
    } on ConnectivityException catch (e3) {
      Future.error(throw e3, StackTrace.current);
    } on Exception catch (e2) {
      Future.error(throw AtException(message:e2.toString()), StackTrace.current);
    }
  }

  Future<dynamic> delete(Uri url, { Map<String,String>? headers }) async {
    try {

      await checkConnection();

      logger.d("DELETE  $url");

      final response =  await http.delete(url,
        headers: headers ,
      );

      logger.d("Headers: ${headers.toString()}");

      logger.d("Response status: ${response.statusCode}");
      logger.d("Response body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }else {
        Future.error(throw AtException(message:"DELETE ${response.statusCode}"), StackTrace.current);
      }


    } on SocketException catch (e1) {
      Future.error(throw connectivityException, StackTrace.current);
    } on ConnectivityException catch (e3) {
      Future.error(throw e3, StackTrace.current);
    } on Exception catch (e2) {
      Future.error(throw AtException(message:e2.toString()), StackTrace.current);
    }
  }


  Exception get connectivityException => ConnectivityException();

  Future<void> checkConnection()async{

    final hasConnection = await ConnectivityService().checkInternetConnection();
    if(!hasConnection)
      Future.error(throw connectivityException, StackTrace.current);

  }


}