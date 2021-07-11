import 'package:categora/helpers/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void unknownError() {
  toast("Unknown Error, please contact support");
}

String getDaysHours(int microSec) {
  final int currMicroSec = Timestamp.now().microsecondsSinceEpoch;

  final int differenceMicroSec = microSec - currMicroSec;

  if (differenceMicroSec <= 0) {
    return "Due";
  }

  double seconds = differenceMicroSec / 1000000;

  double minutes = seconds / 60;

  double hours = minutes / 60;

  double days = hours / 24;

  int iDays = (days + 1).toInt();

  double dayDiff = days - days.toInt();

  hours = dayDiff * 24;

  int iHours = hours.toInt();

  int iYears = iDays ~/ 365;

  //Show Only Years
  if (iYears > 5) {
    return "";
  } else if (iYears >= 1) {
    String toReturn = iYears.toString() + " year";

    if (iYears > 1) {
      toReturn += "s";
    }

    return toReturn;
  } else if (iDays > 7) {
    //Show only days if greater than 7 days
    return iDays.toString() + " days";
  } else if (iDays <= 1) {
    //Less than hour, show due soon
    if (iHours <= 1) {
      return "Less than an hour";
    }

    //Show only hours
    return iHours.toString() + " hours";
  } else {
    //Show days and hours only if less than a week
    return iDays.toString() + " days, " + iHours.toString() + " hours";
  }
}
