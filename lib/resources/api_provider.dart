import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/error_model.dart';
import 'package:flutter_app/models/success_model.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';


class ApiProvider {
 final Client _client = Client();


  Future<Either<ErrorModel, SuccessModel>> get({
   required String url,
  }) async {


    try {


      Response  response = await _client.get(Uri.parse("http://laundryapi.hia.om/api/azure/gettoken"), headers:
       {
         "content-type": "application/json",
         "accept": "application/json",
       },
      );

     var parsedBody = jsonDecode(response.body);

     String accessToken=parsedBody["data"];


        response = await _client.get(Uri.parse(url),
         headers: {
          "content-type": "application/json",
          "accept": "application/json",
           "authorization":"Bearer $accessToken"

        });

       parsedBody = jsonDecode(response.body);


      if (response.statusCode == 200) {
        return right(SuccessModel(title: "Success", data: parsedBody));
      } else {
        return left(ErrorModel(
            data: parsedBody,
            message: "Error! Something went wrong",
            title: "Error",
            errorCode: response.statusCode));
      }
    } on SocketException {
      return left(ErrorModel(
          message: "No internet connection!", title: "Error", errorCode: 400));
    } on HttpException {
      return left(ErrorModel(
          message: "Server is not responding. Try later",
          title: "Error",
          errorCode: 400));
    } catch(e){

      return left(ErrorModel(
          message: "Something went wrong. Try again",
          title: "Error",
          errorCode: 400));
    }
  }
}


