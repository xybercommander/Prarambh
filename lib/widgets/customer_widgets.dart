import 'package:flutter/material.dart';

setContainerGradient(String service) {
  if(service == 'Developer') {
    return LinearGradient(
      colors: [Color.fromRGBO(222, 98, 98, 1), Color.fromRGBO(255, 184, 140, 1)]
    );
  } else if(service == 'Designer') {
    return LinearGradient(
      colors: [Color.fromRGBO(204, 43, 94, 1), Color.fromRGBO(117, 58, 136, 1)]
    );
  } else if(service == 'House Cleaning') {
    return LinearGradient(
      colors: [Color.fromRGBO(33, 147, 176, 1), Color.fromRGBO(109, 213, 237, 1)]
    );
  } else if(service == 'Grocery Store') {
    return LinearGradient(
      colors: [Color.fromRGBO(67, 206, 162, 1), Color.fromRGBO(24, 90, 157, 1)]
    );
  } else if(service == 'Restaurant') {
    return LinearGradient(
      colors: [Color.fromRGBO(69, 104, 220, 1), Color.fromRGBO(176, 106, 179, 1)]
    );
  }
}