import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semnox_core/semnox_core.dart';
import '../../provider/view_model/start_ride_view_model.dart';

class SemnoxTicketCard extends ConsumerWidget {
  // final SemnoxRideEntryViewModel viewModel;
  final int balance;
  final int thresholdBalance;
  final TextEditingController controller;
  const SemnoxTicketCard({
    Key? key,
    // required this.viewModel,
    required this.balance,
    required this.thresholdBalance,
    required this.controller,
  }) : super(key: key);

  Widget build(BuildContext context, ref) {
    return SemnoxElevatedCard(
      borderRadius: BorderRadius.circular(16.mapToIdealWidth(context)),
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          balance > thresholdBalance
              ? const SizedBox()
              : Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 64.mapToIdealHeight(context),
                        decoration: BoxDecoration(
                          color: SemnoxConstantColor.alertStateColor(context),
                          borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(16.mapToIdealWidth(context)),
                            topLeft:
                                Radius.circular(16.mapToIdealWidth(context)),
                          ),
                        ),
                        child: const SemnoxText.h6(
                          text: "Insufficient Balance",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          Container(
            padding: EdgeInsets.all(32.mapToIdealWidth(context)),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                width: 2,
                color: SemnoxConstantColor.shadowColor(context),
              )),
            ),
            height: 116.mapToIdealHeight(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SemnoxText.bodyReg1(text: "Customer Name"),
                    SemnoxText.h6(text: "Albert Potesto")
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SemnoxText.bodyReg1(text: "Available Balance"),
                    SemnoxText.h6(text: balance.toString())
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 160.mapToIdealHeight(context),
                  color: SemnoxConstantColor.grey(context).withAlpha(150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.mapToIdealWidth(context)),
                        child: const SemnoxText.bodyReg1(text: "Enter No.of Seats"),
                      ),
                      SizedBox(
                        width: 240.mapToIdealWidth(context),
                        child: SemnoxBoxField(
                          dialogTitle: "Enter No.of Seats",
                          controller: controller,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 124.mapToIdealHeight(context),
                  child: SemnoxPopUpTwoButtons(
                    padding: EdgeInsets.zero,
                    outlineButtonText: "CANCEL",
                    filledButtonText: "ENTER",
                    onFilledButtonPressed: () {
                      ref.read(StartRideViewModel.provider).enter();
                    },
                    onOutlineButtonPressed: () {
                      ref.read(StartRideViewModel.provider).clear();
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
