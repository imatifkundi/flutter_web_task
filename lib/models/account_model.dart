



class Account{


  late String name;
  late String accountNumber;
  late dynamic stateCode;
  late String stateOrProvince;

  Account({required this.name,required this.accountNumber,required this.stateCode,required this.stateOrProvince});

  Account.fromMap(item){
    name=item["name"];
    accountNumber=item["accountnumber"];
    stateCode=item["statecode"];
    stateOrProvince=item["address1_stateorprovince"];

}

}
