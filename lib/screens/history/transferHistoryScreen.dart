import 'package:bank_app/components/transfer_item.dart';
import 'package:bank_app/model/transfer_model.dart';
import 'package:bank_app/shared/cubit.dart';
import 'package:bank_app/shared/states.dart';
import 'package:bank_app/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransfersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCubit, States>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = MyCubit.get(context);
        return Container(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return TransferItem(
                TransferModel(
                  from: cubit.transfersList[index]['sender'],
                  to: cubit.transfersList[index]['receiver'],
                  value: cubit.transfersList[index]['value'],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return separateItem();
            },
            itemCount: cubit.transfersList.length,
          ),
        );
      },
    );
  }
}
