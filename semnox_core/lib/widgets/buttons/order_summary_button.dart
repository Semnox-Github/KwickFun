import  'package:flutter/material.dart';
import  'package:semnox_core/semnox_core.dart';

class OrderSummaryButton extends StatelessWidget {
  const OrderSummaryButton({
    Key? key,
    this.orderLable = "Table No",
    required this.orderNo,
    required this.subtotal,
    required this.count, this.onOrderClick,
  }) : super(key: key);
  final String orderLable;
  final String orderNo;
  final String subtotal;
  final int count;
  final VoidCallback? onOrderClick;
  
    @override
  Widget build(BuildContext context) {
    return SemnoxFlatButton(
      onPressed: onOrderClick,
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SemnoxText.bodyReg2(text: orderLable),
              SemnoxText.button(text: orderNo),
            ],
          ),
        ),
        // Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SemnoxText.bodyReg2(text: "Subtotal"),
            SemnoxText.button(text: subtotal),
          ],
        ),
        SemnoxBadge.count(count: count)
      ],
    ));
  }
}

class OrderSummaryBottomBar extends StatelessWidget {
  const OrderSummaryBottomBar({ Key? key, this.onCancelClick, this.onOrderClick, this.orderLable, this.orderNo, this.subtotal, this.count }) : super(key: key);
  final VoidCallback? onCancelClick;
  final VoidCallback? onOrderClick;
  final String? orderLable;
  final String? orderNo;
  final String? subtotal;
  final int? count;
   @override
  Widget build(BuildContext context) {
    return SemnoxTwoButtons(
      flex2: 3,
      child1: SemnoxOutlineButton(child: SemnoxText(text: "CANCEL")),
      child2: OrderSummaryButton(orderNo: orderNo??"02-6", subtotal: subtotal??"30", count: 5,onOrderClick: onOrderClick,),
      
    );
  }
}

class SemnoxTwoButtons extends StatelessWidget {
  const SemnoxTwoButtons({
    required this.child1,
    required this.child2,
    this.flex1 = 1,
    this.flex2 = 1,
  });

  final Widget child1;
  final Widget child2;
  final int flex1;
  final int flex2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SemnoxPadding.mediumSpace(context)),
      child: SemnoxElevatedCard(
          child: Row(
        children: [
          Expanded(
            flex: flex1,
            child: child1,
          ),
          SizedBox(
            width: SemnoxPadding.mediumSpace(context),
          ),
          Expanded(
            flex: flex2,
            child: child2,
          ),
        ],
      )),
    );
  }
}
