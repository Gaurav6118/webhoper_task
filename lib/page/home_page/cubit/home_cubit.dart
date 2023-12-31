import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:webhoper_test/help/helper.dart';
import 'package:webhoper_test/model/user_data.dart';
import 'package:webhoper_test/repos/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({this.userRepository}) : super(const HomeState()) {
    getDataList();
  }

  UserRepository? userRepository;

  void getDataList() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      http.Response response = await userRepository!.getUserData();

      if (response.statusCode == 200) {
        UserData userData = UserData.fromJson(jsonDecode(response.body));

        if (userData.data!.isNotEmpty) {
          emit(state.copyWith(
              status: FormzStatus.submissionSuccess,
              userDataList: userData.data));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
          Helper.showToast('Please try again');
        }
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        Helper.showToast('Data not found');
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
