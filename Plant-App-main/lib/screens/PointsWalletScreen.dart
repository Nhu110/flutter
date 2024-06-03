import 'package:flutter/material.dart';

class PointsWalletScreen extends StatefulWidget {
  const PointsWalletScreen({super.key});

  @override
  State<PointsWalletScreen> createState() => _PointsWalletScreenState();
}

class _PointsWalletScreenState extends State<PointsWalletScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Ví tích điểm'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Số điểm của bạn:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.point_of_sale, color: Colors.orange),
                SizedBox(width: 10),
                Text(
                  '100 điểm', // Thay đổi số điểm này bằng số điểm thực tế của người dùng
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Các mức điểm và ưu đãi tương ứng:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildRewardItem('Mức điểm 100:', 'Giảm giá 10% cho lần mua hàng tiếp theo', 'Sử dụng 100 điểm để nhận ưu đãi này'),
                buildRewardItem('Mức điểm 200:', 'Giảm giá 20% cho lần mua hàng tiếp theo', 'Sử dụng 200 điểm để nhận ưu đãi này'),
                buildRewardItem('Mức điểm 300:', 'Miễn phí vận chuyển cho đơn hàng tiếp theo', 'Sử dụng 300 điểm để nhận ưu đãi này'),
                // Thêm các mức điểm và ưu đãi khác tùy theo nhu cầu của bạn
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRewardItem(String title, String description, String usage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    usage,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nút được nhấn
                },
                child: Text('Đổi ưu đãi'),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}