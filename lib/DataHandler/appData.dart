import 'package:cloned_uber/Models/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier
{


  Address pickUpLocation = new Address("","",0.0, 0.0);
  Address dropLocation = new Address("","",0.0,0.0);


  void updatePickuplocationAddress(Address pickupAddress)
    {
      pickUpLocation= pickupAddress;
      notifyListeners();
    }

  void updatedropdownAddress(Address DropLocationAddress)
  {
    dropLocation= DropLocationAddress;
    notifyListeners();
  }



}