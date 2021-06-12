import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker/localization/language_constants.dart';

class Helper
{
    static Duration timeout = Duration(seconds: 50);
    static Widget sizedCircularProgressIndicator({double width,double height, double strokeWidth,Color color,double value}) => SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(color),strokeWidth: strokeWidth,value: value,),
    );
    static Future<void> showError(BuildContext context,String messageKey, Duration duration) async
    {
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.easeInOut,
        forwardAnimationCurve: Curves.elasticOut,
        shouldIconPulse: false,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        boxShadows: [
          BoxShadow(
              offset: Offset(0,2),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.10)
          )
        ],
        padding: EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Theme.of(context).colorScheme.error,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context,"error"),
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
            SizedBox(height: 5,),
            Text(
              getTranslated(context,messageKey),
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
              softWrap: true,
            ),
          ],
        ),
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      )..show(context);
    }
    static Future<void> showErrorString(BuildContext context,String message, Duration duration) async
    {
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.easeInOut,
        forwardAnimationCurve: Curves.elasticOut,
        shouldIconPulse: false,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        boxShadows: [
          BoxShadow(
              offset: Offset(0,2),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.10)
          )
        ],
        padding: EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Theme.of(context).colorScheme.error,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context,"error"),
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
            SizedBox(height: 5,),
            Text(
              message,
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
              softWrap: true,
            ),
          ],
        ),
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      )..show(context);
    }
    static Future<void> gainHealthPoints(BuildContext context,String points, Duration duration) async
    {
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.easeInOut,
        forwardAnimationCurve: Curves.elasticOut,
        shouldIconPulse: false,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        boxShadows: [
          BoxShadow(
              offset: Offset(0,2),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.10)
          )
        ],
        padding: EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context,"bravo"),
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
            SizedBox(height: 5,),
            Text(
              getTranslated(context,"you_gain")+" "+points+" "+getTranslated(context,"points"),
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
              softWrap: true,
            ),
          ],
        ),
        icon: Icon(
          Icons.card_giftcard,
          color: Colors.white,
        ),
      )..show(context);
    }
    static Future<void> showSuccess(BuildContext context,String messageKey, Duration duration) async
    {
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.easeInOut,
        forwardAnimationCurve: Curves.elasticOut,
        shouldIconPulse: false,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        boxShadows: [
          BoxShadow(
              offset: Offset(0,2),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.10)
          )
        ],
        padding: EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context,"bravo"),
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
            SizedBox(height: 5,),
            Text(
              getTranslated(context,messageKey),
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
              softWrap: true,
            ),
          ],
        ),
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
        ),
      )..show(context);
    }
    static Future<void> showSuccessWithoutTitle(BuildContext context,String messageKey, Duration duration) async
    {
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.easeInOut,
        forwardAnimationCurve: Curves.elasticOut,
        shouldIconPulse: false,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        boxShadows: [
          BoxShadow(
              offset: Offset(0,2),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.10)
          )
        ],
        padding: EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context,messageKey),
              style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
              softWrap: true,
            ),
          ],
        ),
        icon: Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
        ),
      )..show(context);
    }
}