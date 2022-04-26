import 'package:flutter/material.dart';
import 'package:flutter_app/models/account_model.dart';
import 'package:flutter_app/resources/api_provider.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {

  RxList<Account> allAccounts = RxList<Account>();
  RxList<Account> showingAccounts = RxList<Account>();
  var status = Status.initial.obs;
  var textController=TextEditingController();
  var selectedStateCode=2.obs;
  Rx<String?> selectedProvince= Rx(null);

  final provinces=[
    "WA",
    "MA",
  ];
 var isGridView=false.obs;
  @override
  void onInit() {
    getAccounts();
    super.onInit();
  }
  reset(){
    selectedProvince.value=null;
    selectedStateCode.value=2;
  }
  filter(){
    status(Status.loading);
    if(textController.text.isEmpty){
      showingAccounts.clear();
      showingAccounts.addAll(allAccounts.where((element) => (element.stateCode==selectedStateCode.value || selectedStateCode.value==2)
          && (element.stateOrProvince==selectedProvince.value || selectedProvince.value==null)
      ).toList());
    }else{
      List<Account> tempList = List.of(showingAccounts);
      showingAccounts.clear();
      showingAccounts.addAll(tempList.where((element) =>  (element.stateCode==selectedStateCode.value || selectedStateCode.value==2)
          && (element.stateOrProvince==selectedProvince.value || selectedProvince.value==null)).toList());

    }
 status(Status.success);


   }

  search(){
    status(Status.loading);
    showingAccounts.clear();
    String searchText=textController.text.toLowerCase();
    showingAccounts.addAll(allAccounts.where((element) => element.name.toString().toLowerCase().contains(searchText) || element.accountNumber.contains(searchText)).toList());

    status(Status.success);
  }

  Future<void> getAccounts() async {
    try {

      status.value = Status.loading;

      var apiProvider=ApiProvider();

        var response = await apiProvider.get(
            url: "https://org34d86d0e.crm4.dynamics.com/api/data/v9.1/accounts");

        response.fold((l) {

          status.value = Status.error;
        }, (r) {

          allAccounts.clear();
          showingAccounts.clear();
          for (var x in r.data["value"]) {
            var account=Account.fromMap(x);
            allAccounts.add(account);
          }
          showingAccounts.addAll(allAccounts);
          status.value = Status.success;
       
        });
    } catch (e) {
      status.value = Status.error;
    }
  }



}


enum Status {
  initial,
  loading,
  success,
  error
}
