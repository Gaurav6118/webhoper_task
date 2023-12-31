import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:webhoper_test/help/app_config.dart';
import 'package:webhoper_test/help/helper.dart';
import 'package:webhoper_test/page/home_page/cubit/home_cubit.dart';
import 'package:webhoper_test/repos/user_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) =>
                  HomeCubit(userRepository: context.read<UserRepository>()),
              child: const HomeView(),
            ));
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColors().colorPrimary(1),
              toolbarHeight: AppConfig(context).appHeight(8),
              centerTitle: true,
              title: Text('Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConfig(context).appWidth(4.5),
                      fontWeight: FontWeight.w500)),
              actions: [
                InkWell(
                  onTap: (){
                    Helper.of(context).showMyDialog(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(AppConfig(context).appWidth(4.0)),
                    child: Icon(Icons.logout,
                    color: Colors.white,),
                  ),
                )
              ],
            ),
            body: RefreshIndicator(
              color: Colors.white,
              onRefresh: () async {
                return context.read<HomeCubit>().getDataList();
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: state.status!.isSubmissionInProgress
                    ? Helper.showLoader()
                    : state.userDataList!.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: AppConfig(context).appHeight(2.0),
                                left: AppConfig(context).appWidth(5.0),
                                right: AppConfig(context).appWidth(5.0)),
                            child: ListView.builder(
                                itemCount: state.userDataList!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            AppConfig(context).appHeight(10),
                                        width: AppConfig(context).appWidth(100),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppConfig(context)
                                                  .appHeight(1.5)),
                                          color:
                                              state.userDataList![index].color,
                                        ),
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'Name: ${state.userDataList![index].name}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(4.5),
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(
                                                  state.userDataList![index]
                                                      .pantoneValue!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(.6),
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(4.5),
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          subtitle: Text(
                                              'Year: ${state.userDataList![index].year}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(.8),
                                                  fontSize: AppConfig(context)
                                                      .appWidth(4.5),
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppConfig(context).appHeight(2),
                                      )
                                    ],
                                  );
                                }),
                          )
                        : Center(
                            child: Text('No data found',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppConfig(context).appWidth(5.0),
                                    fontWeight: FontWeight.w600)),
                          ),
              ),
            ));
      },
    );
  }
}
