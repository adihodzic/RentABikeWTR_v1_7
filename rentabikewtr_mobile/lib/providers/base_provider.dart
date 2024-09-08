import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String? _endpoint;

  HttpClient client = new HttpClient();
  IOClient? http;

  BaseProvider(String endpoint) {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue:
            "http://10.0.2.2:44335/api/"); // localhost kad koristim windows prikaz a pisalo je 44346 44335 24257 za http
    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = _baseUrl! + "/";
    }

    _endpoint = endpoint;

    // HttpClient createHttpClient(SecurityContext? context) {
    //   final httpClient = HttpClient(context: context);
    //   httpClient.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return httpClient;
    // }

    final client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    //client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<T> getById(int id, [dynamic additionalData]) async {
    var url = Uri.parse("$_baseUrl$_endpoint/$id");
    //List<T> _items = [];

    Map<String, String> headers = createHeaders();

    var response = await http!.get(url, headers: headers);
    print(
        'Error: ${response.statusCode}'); // ovo je provjera konekcije preko 10.0.2.2
    print('Response body: ${response.body}');

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      // return data
      //     .map((x) => fromJson(x))
      //     .cast<T>()
      //     .firstWhere((T) => T.id == id);
      //List<T> get items => _items;

      //return data.map((x) => fromJson(x)).cast<T>().toList();
      // return data
      //     .map((x) => fromJson(x))
      //     .cast<T>()
      //     .firstWhere((T) => T.id == id, orElse: () => null);
      //T data = jsonDecode(response.body)['data'];
      return fromJson(data) as T; //moram provjeriti da li treba T?
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
  // Future<List<T>> getById(int id) {
  //   return List<T>.firstWhere((T) => T.id == id, orElse: () => null);
  // }

  Future<T?> getProfilKorisnika(String username,
      [dynamic additionalData]) async {
    var url = Uri.parse("$_baseUrl$_endpoint?username=$username");

    Map<String, String> headers = createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      //return data.map((x) => fromJson(x)).cast<T>().toList();
      //T data = jsonDecode(response.body).cast<T>();
      //['data'];
      //return data! as T?; //ovo je ChatGPT predlozio
      return fromJson(data) as T?;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T>> getRezervacijeKupac(int id) async {
    var url = Uri.parse("$_baseUrl$_endpoint?id=$id");

    // if (id != null) {
    //   String queryString = getQueryString(id);
    //   url = url + "?" + queryString;
    // }

    //var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T?>> getRezervacijeDostupni([dynamic search]) async {
    var url = "$_baseUrl$_endpoint";

    if (search != null) {
      //String queryString = getQueryString(search);
      url = url + "?" + "datumIzdavanja=$search";
      //{(DateTime.parse(search) as DateTime).toIso8601String()}";
    }

    var uri = Uri.parse(url);
    //var url = Uri.parse("$_baseUrl$_endpoint?datumIzdavanja=$datumIzdavanja");

    Map<String, String> headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
      //T data = jsonDecode(response.body).cast<T>();
      //['data'];
      //return data! as T?; //ovo je ChatGPT predlozio
      //return fromJson(data) as T?;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T>> recommend(int id) async {
    var url = Uri.parse("$_baseUrl$_endpoint/$id/Recommend");

    // if (id != null) {
    //   String queryString = getQueryString(id);
    //   url = url + "?" + queryString;
    // }

    //var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T>> get([dynamic search]) async {
    var url = "$_baseUrl$_endpoint";

    if (search != null) {
      String queryString = getQueryString(search);
      url = url + "?" + queryString;
    }

    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    print("get me");
    var response = await http!.get(uri, headers: headers);
    print("done $response");
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<T?> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Future<T?> insertKupca(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    Map<String, String> headers = createKupacHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Future<T?> updateProfilKorisnika(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Map<String, String> createKupacHeaders() {
    String? username2 = "test";
    String? password2 = "test";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username2:$password2'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
    return headers;
  }

  Map<String, String> createHeaders() {
    String? username = Authorization.username;
    String? password = Authorization.password;

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
    return headers;
  }

  T fromJson(data) {
    throw Exception("Override method");
  }

  String getQueryString(Map params,
      {String prefix: '&', bool inRecursion: false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
