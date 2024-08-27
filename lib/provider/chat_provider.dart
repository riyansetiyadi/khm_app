import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/models/chat_model.dart';
import 'package:khm_app/models/profile_model.dart';
import 'package:khm_app/models/response_model.dart';
import 'package:khm_app/models/room_chat_model.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/enum_state.dart';

class ChatProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  ChatProvider(this.apiService, this.authRepository) {
    _init();
  }

  ResultState _resultState = ResultState.initial;
  ResultState get state => _resultState;

  ResponseApiModel? response;
  RoomChatModel? roomChat;

  File? image;

  _init() async {}

  void resetChat() {
    roomChat = null;
    _resultState = ResultState.initial;
    image = null;
  }

  Future<bool> addRoom() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.createRoomChatApi(token ?? '');
      print("object2");
      // response = ResponseApiModel.fromJson(responseResult);

      if (responseResult['status'] == 'Successfully') {
        roomChat = RoomChatModel.fromJson(responseResult['message'][0]);
        _resultState = ResultState.loaded;
        notifyListeners();
        return true;
      } else {
        _resultState = ResultState.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('add room');
      print(e);
      _resultState = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendMessage(String message, {File? img}) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      ProfileModel? profile = await authRepository.getProfile();
      final responseResult = await apiService.sendMessageApi(
        token ?? '',
        roomChat?.id ?? '',
        profile?.fullname ?? '',
        message,
        img: img,
      );
      // response = ResponseApiModel.fromJson(responseResult);
      // if (response?.status == 'success') {
      if (responseResult['status'] == 'success') {
        _resultState = ResultState.loaded;
        notifyListeners();
        return true;
      } else {
        _resultState = ResultState.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('send pesan');
      print(e);
      _resultState = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getMessage(String idRoom) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.getMessageApi(
        idRoom,
        token ?? '',
      );
      print(responseResult);
      // response = ResponseApiModel.fromJson(responseResult);
      // if (response?.status == 'success') {
      roomChat?.chats = ChatModel.fromJsonList(responseResult);
      _resultState = ResultState.loaded;
      notifyListeners();
      return true;
      // } else {
      //   _resultState = ResultState.error;
      //   notifyListeners();
      //   return false;
      // }
    } catch (e) {
      print('get pesan');
      print(e);
      _resultState = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> refreshMessage() async {
    return await getMessage(roomChat?.id ?? '');
  }

  Future<void> pickImage() async {
    _resultState = ResultState.loading;
    notifyListeners();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      image = File(file.path!);
    }
    _resultState = ResultState.loaded;
    notifyListeners();
  }
}
