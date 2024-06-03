import 'package:flutter/material.dart';
import 'package:plant_app/models/bill_model.dart';

class CustomContainer extends StatelessWidget {
  final BillModel? billModel;
  const CustomContainer({super.key, this.billModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: const Color.fromARGB(255, 251, 1, 1), width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              billModel?.name ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              billModel?.isCheckVip == true ? Icons.star : null,
              color: Colors.yellow,
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Số lượng: ${billModel?.quantyti}'),
              Text('Giá: ${billModel?.price}00'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 35,
                width: 100,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 244, 188, 206),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  billModel!.total!.toStringAsFixed(3),
                  textAlign: TextAlign.center,
                ),
              )
              // SizedBox(
              //   height: 20,
              // )
            ],
          )
        ],
      ),
    );
  }
    
  }

