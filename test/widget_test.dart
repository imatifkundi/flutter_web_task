
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/account_controller.dart';
import 'package:flutter_app/models/account_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';
import 'package:get/get.dart';


void main() {

  final testAccounts =[
    Account(name: "Test account 1",accountNumber: "12345",stateCode: 0,stateOrProvince: "WA"),
    Account(name: "Test account 2",accountNumber: "12345",stateCode: 0,stateOrProvince: "WA"),
    Account(name: "Test account 3",accountNumber: "12345",stateCode: 0,stateOrProvince: "WA"),

  ];

  testWidgets('search field, filter button, listview and gridview buttons on screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byKey(const Key("filter-button")), findsOneWidget);
    expect(find.byKey(const Key("listview-button")), findsOneWidget);
    expect(find.byKey(const Key("gridview-button")), findsOneWidget);
  });

  testWidgets('click filter button and display filter alert dialog', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const Key("filter-button")));
    await tester.pump();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.byKey(const Key("radio-0"),), findsOneWidget);
    expect(find.byKey(const Key("radio-1"),), findsOneWidget);
    expect(find.byKey(const Key("radio-2"),), findsOneWidget);
  });


  testWidgets('showing circular loader when status is loading', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    var controller = Get.find<AccountController>();

    controller.status(Status.loading);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

  });


  testWidgets('showing error message when status is error', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    var controller = Get.find<AccountController>();

    controller.status(Status.error);
    await tester.pump();
    expect(find.text("Couldn't load data"), findsOneWidget);

  });

  testWidgets('showing no records message when status is success with 0 accounts', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    var controller = Get.find<AccountController>();

    controller.status(Status.success);
    controller.showingAccounts.value=[];
    await tester.pump();
    expect(find.text("No records found!"), findsOneWidget);

  });

  testWidgets('show data in listview after data is fetched', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    var controller =  Get.find<AccountController>();

    controller.status(Status.success);
    controller.showingAccounts.addAll(testAccounts);
    await tester.pump();
    expect(find.byType(ListView), findsOneWidget);


  });



}
