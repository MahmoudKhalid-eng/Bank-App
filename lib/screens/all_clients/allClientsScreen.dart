import 'package:bank_app/components/client_item.dart';
import 'package:bank_app/shared/cubit.dart';
import 'package:bank_app/shared/states.dart';
import 'package:bank_app/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<MyCubit, States>(
        listener: (context, states) {},
        builder: (context, states) {
          return ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ClientItem(
                index: index,
              );
            },
            separatorBuilder: (context, index) {
              return separateItem();
            },
            itemCount: MyCubit.get(context).clientsList.length,
          );
        },
      ),
    );
  }
}
