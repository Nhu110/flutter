import 'package:flutter/material.dart';

class LoyaltyMembershipScreen extends StatefulWidget {
  const LoyaltyMembershipScreen({super.key});

  @override
  State<LoyaltyMembershipScreen> createState() => _LoyaltyMembershipScreenState();
}

class _LoyaltyMembershipScreenState extends State<LoyaltyMembershipScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Khách hàng thân thiết'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MembershipCard(
            title: 'Thành viên mới',
            subtitle: 'Bạn cần tích lũy thêm 200 điểm để đạt thành viên Bạc',
            icon: Icons.star_border,
          ),
          MembershipCard(
            title: 'Thành viên Bạc',
            subtitle: 'Bạn cần tích lũy thêm 500 điểm để đạt thành viên Vàng',
            icon: Icons.star,
          ),
          MembershipCard(
            title: 'Thành viên Vàng',
            subtitle: 'Chương trình ưu đãi dành riêng cho thành viên Vàng',
            icon: Icons.star,
          ),
        ],
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  MembershipCard({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon, color: Colors.yellow),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
