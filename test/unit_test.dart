import 'package:flutter_app/controllers/account_controller.dart';
import 'package:test/test.dart';

void main() {
  group('Accounts', () {
    test('initial data', () {
      expect(AccountController().allAccounts, []);
      expect(AccountController().showingAccounts, []);
    });

    test('get data from api', () async{
      final controller = AccountController();

      await controller.getAccounts();
      final status = controller.status.value== Status.success?Status.success:Status.error;
      expect(controller.status.value, status);
    });

    test('search by name or account number', () async{
      final controller = AccountController();
      await controller.getAccounts();
      controller.textController.text="3006";
      controller.search();
      expect(controller.showingAccounts.length,
         controller.allAccounts.where((element) => element.accountNumber.contains(controller.textController.text)).length);
    });

    test('filter by account state and state/province', ()async {
      final controller = AccountController();
      await controller.getAccounts();
      controller.selectedStateCode.value=0;
      controller.filter();
      expect(controller.showingAccounts.length, controller.allAccounts.where((element) => element.stateCode==0).length);
    });


  });
}