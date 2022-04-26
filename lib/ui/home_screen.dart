import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/account_controller.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<AccountController> {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Column(
            children: [
              Row(
                children: [

                  Expanded(
                    child: TextFormField( onChanged: (val){
                          controller.search();
                    },
                      controller: controller.textController,
decoration: const InputDecoration(
  prefixIcon: Icon(MaterialCommunityIcons.magnify,),
  hintText: "Search"
),
                    ),
                  ),

                   Container(
                     margin: const EdgeInsets.only(right: 30),
                     child:
                     TextButton.icon(
                         key: const Key("filter-button"),
                         onPressed: (){


                       Get.defaultDialog(title: "Filter",
                       radius: 0,
                       content: Obx(()=>
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                             const Text("Account State:"),
                             const SizedBox(height: 10,),
                             Row(
                               children: [
                                  Radio(
                                      key: const Key("radio-2"),
                                      value: 2, groupValue: controller.selectedStateCode.value, onChanged: (int? val){
                                     if(val!=null){
                                       controller.selectedStateCode.value=val;
                                     }

                                   }),
                            const Text("All"),

                               Radio(
                                   key: const Key("radio-0"),
                                   value: 0, groupValue: controller.selectedStateCode.value, onChanged: (int? val){
                                       if(val!=null){
                                         controller.selectedStateCode.value=val;
                                       }

                                     }),
                                         const Text("Active")

                               ,Radio(

                                   key: const Key("radio-1"),value: 1, groupValue: controller.selectedStateCode.value, onChanged: (int? val){
                                       if(val!=null){
                                         controller.selectedStateCode.value=val;
                                       }

                                     },),
                                          const Text("Inactive")

                               ],
                             ),
                               const SizedBox(height: 10,),
                               const Text("State/Province:"),
                               DropdownButton<String>(
                                 dropdownColor: Colors.white,
                                 borderRadius: BorderRadius.zero,


                                 items: controller.provinces.map((e) =>
                                   DropdownMenuItem(child: Text(e),value: e,)
                               ).toList()
                               , onChanged: (val){
                                controller.selectedProvince.value=val!;
                                 },
                               value: controller.selectedProvince.value,
                               hint: const Text("Choose One"),
                               ),
                             ],
                            ),
                          ),

                       ),
                         actions: [

                           ElevatedButton(onPressed: controller.reset, child: const Text("Reset")),
                           ElevatedButton(onPressed: (){controller.filter(); Get.back();}, child: const Text("Apply")),

                         ]
                       );

                     }, icon: const Icon(MaterialCommunityIcons.filter),
                         style:  TextButton.styleFrom(
                           primary:Colors.black,
                         ),
                         label: const Text("Filter")),
                   )
                  ,
                  IconButton(
                      key: const Key("listview-button"),
                      onPressed: (){
                    controller.isGridView(false);
                  }, icon: const Icon( MaterialCommunityIcons.view_list)),
                  const SizedBox(width: 10,),
                  IconButton(
                      key: const Key("gridview-button"),
                      onPressed: (){
                    controller.isGridView(true);
                  }, icon: const Icon(MaterialCommunityIcons.view_grid)),
                ],
              ),


              Expanded(
                child: Padding(
                  padding:  const EdgeInsets.only(top: 20),
                  child: Obx(()=>

                  controller.status.value==Status.loading?

                      const Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(strokeWidth: 2,)),
                      ):

                      controller.status.value==Status.error?
                          const Center(
                            child: Text("Couldn't load data"),
                          )

                          : controller.showingAccounts.isEmpty?
                      const Center(
                        child: Text("No records found!"),
                      )

                          :


                  controller.isGridView.value?

                  GridView.builder(
                    key: const Key("gridview"),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                  childAspectRatio: 0.8,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12
                  ),itemBuilder
                    : (context,index){
                      var account = controller.showingAccounts[index];
                      return Card(
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Image.asset("assets/images/placeholder-image.png",
                                width: double.infinity,
                                height:130,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(height: 12,),
                              Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(account.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                  const SizedBox(height: 10,),
                                  Text("Account Number: ${account.accountNumber}"),
                                  const SizedBox(height: 5,),
                                  Text("State/Province: ${account.stateOrProvince}"),
                                  const SizedBox(height: 5,),
                                  Text("State: ${account.stateCode==0?"Active":"Inactive"}"),
                                ],
                              ))

                            ],
                          ),
                        ),

                      );
                    },
                    shrinkWrap: true,
                    itemCount: controller.showingAccounts.length,

                  )

                      :
                  ListView.separated(
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 12,);
                    },
                    itemBuilder: (context,index){
                      var account = controller.showingAccounts[index];
                      return Card(
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset("assets/images/placeholder-image.png",
                              width: 140, height: 100,
                                fit: BoxFit.fill,

                              ),

                              const SizedBox(width: 12,),

                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(account.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                                  const SizedBox(height: 10,),
                                  Text("Account Number: ${account.accountNumber}"),
                                  const SizedBox(height: 5,),
                                  Text("State/Province: ${account.stateOrProvince}"),
                                  const SizedBox(height: 5,),
                                  Text("State: ${account.stateCode==0?"Active":"Inactive"}"),
                                ],
                              ))

                            ],
                          ),
                        ),

                      );
                    },
                    shrinkWrap: true,
                    itemCount: controller.showingAccounts.length,

                  )


                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
