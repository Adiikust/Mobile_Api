import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mobile_api/Controller/Export/export_screen.dart';

class DeliveryScreen extends StatefulWidget {
  late double? personalID;
  late String? location;
  late double? locationId;
  DeliveryScreen({
    double? personalID,
    String? location,
    double? locationId,
  }) {
    this.personalID = personalID;
    this.location = location;
    this.locationId = locationId;
  }

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  late Box<String> storeMobileApiData;
  String SelectedCurrentValue = "Change Status";

  final TextEditingController _scanArticleData = TextEditingController();
  final TextEditingController _textArticleData = TextEditingController();

  _startBarcodeScanStream() async {
    return await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)
        .then((value) => setState(() => _scanArticleData.text = value));
  }

  @override
  void initState() {
    super.initState();
    storeMobileApiData = Hive.box<String>("adnan");
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        onPressed: () {
                          Hive.box('isUserLogin').put('isUserLoggedIn', false);
                        },
                        icon: const Icon(Icons.logout)),
                  ),
                  SizedBox(
                    height: data.size.height * 0.04,
                  ),
                  TextField(
                      controller: _scanArticleData,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: "Enter Barcode Article Id",
                      )),
                  SizedBox(
                    height: data.size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _startBarcodeScanStream();
                        },
                        child: Container(
                          height: data.size.height * 0.05,
                          width: data.size.width * 0.45,
                          decoration: BoxDecoration(
                              color: AppColors.kButton,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.document_scanner,
                                    size: 21,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                                SizedBox(
                                  width: data.size.height * 0.005,
                                ),
                                const Expanded(
                                  flex: 7,
                                  child: Text(
                                    "BarCode Scan",
                                    style: TextStyle(
                                        fontSize: 17, color: AppColors.kWhite),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: data.size.height * 0.04,
                  ),
                  InkWell(
                    onTap: () {
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
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text("Save",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kWhite,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: data.size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Article Id",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Status",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: data.size.height * 0.04,
                  ),
                  ValueListenableBuilder(
                      valueListenable: storeMobileApiData.listenable(),
                      builder: (context, Box<String> adnan, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final key = adnan.keys.toList()[index];

                            return SizedBox(
                              height: data.size.width * 0.1,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "$key",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            child: const Text("Saved"),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: SizedBox(
                                                        height: 300,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Center(
                                                                  child: Text(
                                                                      "$key",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                      ))),
                                                              SizedBox(
                                                                height: data
                                                                        .size
                                                                        .height *
                                                                    0.04,
                                                              ),
                                                              Text(
                                                                widget
                                                                    .personalID
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                              SizedBox(
                                                                height: data
                                                                        .size
                                                                        .height *
                                                                    0.04,
                                                              ),
                                                              Text(
                                                                widget.location
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                              SizedBox(
                                                                height: data
                                                                        .size
                                                                        .height *
                                                                    0.04,
                                                              ),
                                                              Text(
                                                                widget
                                                                    .locationId
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                              SizedBox(
                                                                height: data
                                                                        .size
                                                                        .height *
                                                                    0.04,
                                                              ),
                                                              Center(
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Close")),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            }),
                                        SizedBox(
                                          width: data.size.width * 0.06,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            storeMobileApiData.delete(key);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: storeMobileApiData.keys.toList().length,
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*Card(
                          child: ListTile(
                            title: Text("$key",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            trailing: InkWell(
                              onTap: (){
                                storeMobileApiData.delete(key);
                              },
                              child: const Icon(Icons.delete),),
                          ),
                        );*/
/*  InkWell(
                                    onTap: (){},
                                    child: Text("Saved",style: TextStyle(fontSize: 15),)),*/
