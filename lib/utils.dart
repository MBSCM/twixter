import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  

  static showSnackBar(String? text) {
    
    if (text == null) return;

    var errorText;

    switch (text) {
      case 'The email address is already in use by another account.':
        errorText = 'Dit emailadres is al in gebruik door een andere gebruiker.';
       
        break;
      case 'The password is invalid or the user does not have a password.':
       errorText = 'U heeft een fout wachtwoord opgegeven.';
      
      break;
      default: errorText = 'Er is een fout opgetreden, probeer opnieuw.';
    }
    final snackBar = SnackBar(content: Text(errorText), backgroundColor: Colors.red);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static DateTime? toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }
}