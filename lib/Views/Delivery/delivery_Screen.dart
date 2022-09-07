


import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mobile_api/Controller/Export/export_screen.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}



class _DeliveryScreenState extends State<DeliveryScreen> {

  late Box<String> storeMobileApiData;

  final TextEditingController _scanArticleData =TextEditingController();
  final TextEditingController _textArticleData =TextEditingController();




  _startBarcodeScanStream() async {
    return await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE).then((value) => setState(()=>_scanArticleData.text = value));
  }

  @override
  void initState(){
    super.initState();
    storeMobileApiData = Hive.box<String>("adnan");
  }




  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return WillPopScope(
        onWillPop: ()async{
      SystemNavigator.pop();
      return true;
  },
      child:  Scaffold(
    body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 23),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  width: double.infinity,
                  color: AppColors.kButton,
                ),
              SizedBox(height: data.size.height * 0.04,),
              TextField(
                controller: _scanArticleData,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText:"Enter Barcode Article Id",
                  )
                ),
              SizedBox(height: data.size.height * 0.04,),
              SizedBox(height: data.size.height * 0.04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      _startBarcodeScanStream();
                    },
                    child: Container(
                      height: data.size.height * 0.05,
                      width: data.size.width * 0.45,
                      decoration: BoxDecoration(
                          color: AppColors.kButton,
                          borderRadius:BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children:  [
                          const Icon(Icons.document_scanner,size:21,color: AppColors.kWhite,),
                          SizedBox(width: data.size.height * 0.005,),
                          const Text("BarCode Scan",style: TextStyle(fontSize: 17,color: AppColors.kWhite),),
                        ],
                        ),
                      ),

                    ),
                  ),
                ],
              ),
              SizedBox(height: data.size.height * 0.04,),
              InkWell(
                onTap: (){
                  final key = _scanArticleData.text;
                  final value = _textArticleData.text;
                  storeMobileApiData.put(key, value);
                  _scanArticleData.clear();

                },
                child: Container(
                  width: double.infinity,
                  height: data.size.height * 0.06,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.kButton,
                      borderRadius:BorderRadius.circular(10)),
                  child:  const Text("Save",
                      style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kWhite,
                      )),
                ),
              ),
              SizedBox(height: data.size.height * 0.04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  const [
                Text("Article Id",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                Text("Status",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              ],
              ),
              SizedBox(height: data.size.height * 0.04,),
              ValueListenableBuilder(valueListenable: storeMobileApiData.listenable(),
                  builder: (context,Box<String>adnan,_)
                  {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        final key = adnan.keys.toList()[index];
                        final value = adnan.get(key);
                        return Card(
                          child: ListTile(
                            title: Text("$key",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            trailing: InkWell(
                              onTap: (){
                                storeMobileApiData.delete(key);
                              },
                              child: const Icon(Icons.delete),),
                          ),
                        );
                      },
                      itemCount: storeMobileApiData.keys.toList().length,
                    );
                  }
              ),

          ],
          ),
        ),
      ),
    ),
    ),
    );
}
}
