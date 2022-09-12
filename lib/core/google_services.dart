import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:googleapis/drive/v3.dart' as g_drive;
import 'package:googleapis_auth/auth_io.dart' hide ResponseType;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../common/utils/helper.dart' as helper;

const _scopes = [g_drive.DriveApi.driveScope];

class GoogleDriveService {
  String apiHostMaster = 'https://porto.co.id/odoo-master-api-host.txt';
  String apiHostDev = 'https://porto.co.id/odoo-dev-api-host.txt';

  // Future<Map<String, dynamic>> getKeyFromLocalFile() async {
  //   final String response = await rootBundle.loadString(
  //     "assets/odoo10-1596259258166-36369d6e1c7c.json",
  //   );
  //   final data = json.decode(response);
  //   return data;
  // }

  Future<http.Client> getHttpClient() async {
    const accountCredential = helper.googleServiceAccount;
    final serviceAccountCredential = ServiceAccountCredentials.fromJson(
      accountCredential,
    );

    final authClient = await clientViaServiceAccount(
      serviceAccountCredential,
      _scopes,
    );
    return authClient;
  }

  Future<String> getApiUrl() async {
    try {
      var response = await Dio().get(
        apiHostDev,
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      return response.data;
    } catch (e) {
      return 'error';
    }
  }

  Future<File?> compressImg(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final _fileName = p.basenameWithoutExtension(file.path);
    final _fileExt = p.extension(file.path);
    final targetPath = dir.absolute.path + "/${_fileName + 'temp' + _fileExt}";
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 60,
    );
    return result;
  }

  Future<Map<String, dynamic>> uploadFile(File file) async {
    File imgFile = File(file.path);
    final compressedImg = await compressImg(imgFile);
    final _client = await getHttpClient();
    final _drive = g_drive.DriveApi(_client);
    var _currentDate = DateTime.now();
    var formatter = DateFormat('yyyyMMdd_kkmmss');
    String _formattedDate = formatter.format(_currentDate);
    final _fileName = p.basenameWithoutExtension(compressedImg!.path);
    final _fileExtension = p.extension(compressedImg.path);
    final _formattedName = _fileName + "_" + _formattedDate + _fileExtension;

    debugPrint("Uploading file");

    final _streamedFile = compressedImg.openRead();
    final _fileSize = compressedImg.lengthSync();
    final _response = await _drive.files.create(
      g_drive.File(
        name: _formattedName,
        parents: ["1fxOVHCUJJ_i5AIEGuzCI-_BAk4AzNdVC"],
      ),
      uploadMedia: g_drive.Media(_streamedFile, _fileSize),
      supportsAllDrives: true,
      supportsTeamDrives: true,
    );
    debugPrint("Result ${_response.toJson()}");

    return _response.toJson();
  }

  Future<List<Map<String, dynamic>>> uploadMultipleFilesWithoutCompress(
      List<File> files) async {
    final _client = await getHttpClient();
    final _drive = g_drive.DriveApi(_client);
    var _currentDate = DateTime.now();
    var formatter = DateFormat('yyyyMMdd_kkmmss');
    String _formattedDate = formatter.format(_currentDate);
    String _formattedName;
    Stream<List<int>> _streamedFile;
    int _fileSize;
    List<Map<String, dynamic>> res = [];

    for (File file in files) {
      final _fileName = p.basenameWithoutExtension(file.path);
      final _fileExtension = p.extension(file.path);
      _formattedName = _fileName + "_" + _formattedDate + _fileExtension;

      //stopwatch start
      debugPrint("Uploading file");

      _streamedFile = file.openRead();
      _fileSize = file.lengthSync();
      final _response = await _drive.files.create(
        g_drive.File(
          name: _formattedName,
          parents: ['1fxOVHCUJJ_i5AIEGuzCI-_BAk4AzNdVC'],
        ),
        uploadMedia: g_drive.Media(_streamedFile, _fileSize),
        supportsAllDrives: true,
        supportsTeamDrives: true,
      );
      // debugPrint("Result ${_response.toJson()}");

      res.add(_response.toJson());
    }
    return res;
  }
}
