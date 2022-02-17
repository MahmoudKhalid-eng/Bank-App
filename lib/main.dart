import 'package:bank_app/shared/cubit.dart';
import 'package:bank_app/shared/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffd32f2f),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff9a0007),
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xffd32f2f),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          elevation: 20,
        ),
      ),
      home: BlocProvider(
        create: (context) {
          return MyCubit()
            ..createDataBase()
            ..createDataBase2();
        },
        child: BlocConsumer<MyCubit, States>(
          listener: (context, states) {},
          builder: (context, states) {
            var cubit = MyCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(cubit.screenTitles[cubit.selectedScreenIndex]),
                actions: (cubit.selectedScreenIndex == 0 &&
                        cubit.clientsList.length == 0
                    ? [
                        IconButton(
                          onPressed: () {
                            cubit.fillData();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ]
                    : []),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: (cubit.selectedScreenIndex == 0 ||
                        cubit.selectedScreenIndex == 2
                    ? 0
                    : 1),
                onTap: (index) {
                  cubit.changeScreen(index);
                  if (index == 1) {
                    cubit.selectDataBase2();
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Clients',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'History',
                  ),
                ],
              ),
              body: cubit.myScreens[cubit.selectedScreenIndex],
            );
          },
        ),
      ),
    );
  }
}
