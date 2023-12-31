part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.status = FormzStatus.pure, this.userDataList = const []});

  final FormzStatus? status;
  final List<Data>? userDataList;

  HomeState copyWith(
      {int? selectedTab, FormzStatus? status, List<Data>? userDataList}) {
    return HomeState(
      status: status ?? this.status,
      userDataList: userDataList ?? this.userDataList,
    );
  }

  @override
  List<Object?> get props => [status, userDataList];
}
