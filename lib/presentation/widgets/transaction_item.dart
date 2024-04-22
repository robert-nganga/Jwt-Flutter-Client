import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../domain/models/Transaction.dart';
import '../utils/constants.dart';


class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM, dd, yyyy');
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: Row(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 5,
            width: kSpacingUnit.w * 5,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor4,
                    blurRadius: 24,
                    offset: Offset(0, kSpacingUnit.w),
                  )
                ]),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/${getTransaction(transaction.type ?? "")}.svg',
                height: 35,
                width: 35,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 1.5),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontFamily: 'Muli'),
                  children: [
                    TextSpan(
                      text: "${transaction.type}\n",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: kTextColor,
                      ),
                    ),
                    TextSpan(
                      text: dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(transaction.date!)),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: kTextSecondaryColor,
                        height: 1.5
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: const TextStyle(fontFamily: 'Muli'),
              children: [
                TextSpan(
                  text:
                  '${transaction.type == "Borrow" || transaction.type == "Withdraw" ? '-' : '+'}Ksh ${transaction.amount}\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: getColor(transaction.type!),
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String getTransaction(String type){
  if(type == "Deposit"){
    return "atm-deposit";
  } else if (type == "Withdraw"){
    return "withdraw-dollar-sign";
  } else if (type == "Payment") {
    return "money-bag";
  } else {
    return "borrow";
  }
}

Color getColor(String type){
  if(type == "Deposit" || type == "Payment"){
    return kGreenColor;
  } else {
    return kRedColor;
  }
}

