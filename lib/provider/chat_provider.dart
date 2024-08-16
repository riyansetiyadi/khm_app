import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khm_app/db/auth_repository.dart';
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

  _init() async {}

  Future<bool> addRoom() async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.createRoomChatApi(token ?? '');
      response = ResponseApiModel.fromJson(responseResult);
      if (!(response?.error ?? true)) {
        roomChat = RoomChatModel.fromJson(response?.data[0]);
        _resultState = ResultState.loaded;
        notifyListeners();
        return true;
      } else {
        _resultState = ResultState.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendMessage({file}) async {
    _resultState = ResultState.loading;
    notifyListeners();

    try {
      String? token = await authRepository.getToken();
      final responseResult = await apiService.createRoomChatApi(token ?? '');
      response = ResponseApiModel.fromJson(responseResult);
      if (!(response?.error ?? true)) {
        roomChat = RoomChatModel.fromJson(response?.data[0]);
        _resultState = ResultState.loaded;
        notifyListeners();
        return true;
      } else {
        _resultState = ResultState.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return false;
    }
  }
}
