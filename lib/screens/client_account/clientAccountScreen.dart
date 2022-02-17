import 'package:bank_app/model/transfer_model.dart';
import 'package:bank_app/shared/cubit.dart';
import 'package:bank_app/shared/states.dart';
import 'package:bank_app/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientAccountScreen extends StatelessWidget {
  final idController = TextEditingController();
  final valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MyCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        clientDataText(
                            label: 'ID:', size: 24, weight: FontWeight.bold),
                        SizedBox(
                          width: 15,
                        ),
                        clientDataText(
                            label:
                                '${cubit.clientsList[cubit.selectedClientIndex]['id']}',
                            size: 22),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        clientDataText(
                            label: 'Name:', size: 24, weight: FontWeight.bold),
                        SizedBox(
                          width: 15,
                        ),
                        clientDataText(
                            label:
                                '${cubit.clientsList[cubit.selectedClientIndex]['name']}',
                            size: 22),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        clientDataText(
                            label: 'Mail:', size: 24, weight: FontWeight.bold),
                        SizedBox(
                          width: 5,
                        ),
                        clientDataText(
                            label:
                                '${cubit.clientsList[cubit.selectedClientIndex]['mail']}',
                            size: 22),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        clientDataText(
                            label: 'Balance:',
                            size: 24,
                            weight: FontWeight.bold),
                        SizedBox(
                          width: 15,
                        ),
                        clientDataText(
                            label:
                                '${cubit.clientsList[cubit.selectedClientIndex]['Balance']}',
                            size: 22),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    textFormField(
                        'Transfer to',
                        Icon(Icons.person, color: Color(0xff9a0007)),
                        idController, (value) {
                      if (value.isEmpty) {
                        return 'Please enter receiver ID';
                      } else if (int.tryParse(value)! < 1) {
                        return 'Receiver ID can not be zero or negative';
                      } else if (int.tryParse(value)! >
                          cubit.clientsList.length) {
                        return 'ID not found';
                      } else if (int.tryParse(value)! ==
                          cubit.clientsList[cubit.selectedClientIndex]['id']) {
                        return 'You can not transfer to yourself';
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    textFormField(
                        'Transfer value',
                        Icon(
                          Icons.attach_money,
                          color: Color(0xff9a0007),
                        ),
                        valueController, (value) {
                      if (value.isEmpty) {
                        return 'Please enter transfer value';
                      } else if (int.tryParse(value)! < 1) {
                        return 'Transfer value can not be zero or negative';
                      } else if (int.tryParse(valueController.text)! >
                          cubit.clientsList[cubit.selectedClientIndex]
                              ['Balance']) {
                        return 'No enough balance in your account';
                      } else if (int.tryParse(value)! < 1) {
                        return 'Transfer value can not be zero or negative';
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      minWidth: 140,
                      height: 45,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          int from = cubit
                              .clientsList[cubit.selectedClientIndex]['id'];
                          int to = int.tryParse(idController.text)!;
                          int value = int.tryParse(valueController.text)!;
                          idController.text = '';
                          valueController.text = '';
                          await cubit.updateDataBase(from, to, value);
                          cubit.insertDataBase2(
                            TransferModel(
                              from: from,
                              to: to,
                              value: value,
                            ),
                          );
                          cubit.selectDataBase2();
                        }
                      },
                      child: Text(
                        'Transfer',
                        style: TextStyle(fontSize: 24),
                      ),
                      color: Color(0xffd32f2f),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
