import 'package:flutter/material.dart';
import 'package:plant_app/components/container_bill.dart';
import 'package:plant_app/components/custom_button_bill.dart';
import 'package:plant_app/components/custom_row_input.dart';
import 'package:plant_app/models/app_color_bill.dart';
import 'package:plant_app/models/bill_model.dart';
import 'package:plant_app/services/local/shared_perferences.dart';

class BillPay extends StatefulWidget {
  const BillPay({super.key});
  static const String id="BillPay";

  @override
  State<BillPay> createState() => _BillPay();
}

class _BillPay extends State<BillPay> {
  TextEditingController nameController = TextEditingController();
  TextEditingController soLuongKHController = TextEditingController();
  TextEditingController donViController = TextEditingController();
  TextEditingController thanhTienViController = TextEditingController();
  bool isValue = false;
  BillModel bill = BillModel();
  final SharePrefs _prefs = SharePrefs();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<BillModel> listBillData = [];
  @override
   void initState() {
    super.initState();
    thanhTienViController.text = bill.totalBill.toStringAsFixed(3);

    _getBills();
  }
   double totalBill(double price, bool isValue, int donVi) {
    double total = 0.0;

    if (isValue == true) {
      total = price * donVi * 0.9;
      return total;
    } else {
      total = price * donVi;
      return total;
    }
  }
  int sumVip() {
    int sum = 0;
    for (var i = 0; i < listBillData.length; i++) {
      if (listBillData[i].isCheckVip == true) {
        sum++;
      }
    }
    return sum;
  }

  double sumTotal() {
    double sum = 0;
    for (var i = 0; i < listBillData.length; i++) {
      sum += listBillData[i].total ?? 0.0;
    }
    return sum;
  }

  _getBills() async {
    _prefs.getBills().then((value) {
      listBillData = value ?? listBill;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Trang thanh toán'),
        backgroundColor:Color.fromARGB(255, 104, 255, 162),
      ),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          // margin: EdgeInsets.only(
          //   top: MediaQuery.of(context).size.height * 0.03,
          //   left: 20,
          //   right: 20,
          // ),
          height: MediaQuery.of(context).size.height,
          // nên  màu nền của container
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomRowText(
text: 'Tên khách hàng',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomRowText(
                          text: 'Số lượng ',
                          controller: soLuongKHController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomRowText(
                          text: 'Giá tiền',
                          controller: donViController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text("Thành tiền"),
                            ),
                            Expanded(
                                flex: 4,
                                child: Card(
                                  child: Text(
                                    thanhTienViController.text,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.red),
                                  ),
                                ))
                          ],
                        ),
                        // child: CustomRowText(
                        //   text: "Thành tiền",
                        //   controller: thanhTienViController,
                        //   readOnly: true,
                        // ),
                      ),
                      //  const SizedBox(height: 20),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                            child: ListTile(
                          leading: const Text("KH VIP"),
                          title: Material(
                              child: Checkbox(
                                  value: isValue,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isValue = newValue!;
                                      thanhTienViController.text = (totalBill(
double.parse(
                                                  donViController.text),
                                              isValue,
                                              int.parse(
                                                  soLuongKHController.text)))
                                          .toStringAsFixed(3);
                                    });
                                  })),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        text: "Thanh Toán",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              thanhTienViController.text = (totalBill(
                                      double.parse(donViController.text),
                                      isValue,
                                      int.parse(soLuongKHController.text)))
                                  .toStringAsFixed(3);
                            });
                          }
                        },
                      ),
                      CustomButton(
                        text: "Lưu Thống kê",
                        onPressed: () {
                          setState(() {
                            bill = BillModel(
                                name: nameController.text,
                                quantyti: int.parse(soLuongKHController.text),
                                price: double.parse(donViController.text),
                                total: double.parse(thanhTienViController.text),
                                isCheckVip: isValue);

                            listBillData.insert(0, bill);
                            _prefs.addBills(listBillData);
                            nameController.clear();
                            soLuongKHController.clear();
                            donViController.clear();
                            thanhTienViController.text = "0.000";
                            isValue = false;
                            FocusScope.of(context).unfocus();
                          });
                        },
                      ),
                      CustomButton(
                        text: "Tiếp",
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 104, 255, 162),
borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: []),
                    //mainAxisSize: MainAxisSize.max,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Tống số KH : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text('${listBillData.length}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Tống số KH Vip : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text('${sumVip()}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Tống doanh thu : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(sumTotal().toStringAsFixed(3)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listBillData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomContainer(billModel: listBillData[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      //  ],
      // ),
    );
  }
}

