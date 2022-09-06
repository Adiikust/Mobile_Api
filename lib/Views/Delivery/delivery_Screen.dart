import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_api/Controller/Export/export_screen.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}



class _DeliveryScreenState extends State<DeliveryScreen> {
  final TextEditingController _articleData =TextEditingController();
String _data ='';
  _startBarcodeScanStream() async {
    return await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE).then((value) => setState(()=>_data = value));
  }
  @override
  void dispose(){
super.dispose();
_articleData.dispose();
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
    body: SafeArea(
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
            TextFormField(
              controller: _articleData,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: _data,
              ),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  const [
              Text("Article Id",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              Text("Status",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            ],
            ),

        ],
        ),
      ),
    ),
    ),
    );
}
}
