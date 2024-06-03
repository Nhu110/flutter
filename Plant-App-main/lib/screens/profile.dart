import 'package:flutter/material.dart';
import 'package:plant_app/screens/AddressMapScreen.dart';
import 'package:plant_app/screens/LoyaltyMemberShipScreen.dart';
import 'package:plant_app/screens/PointsWalletScreen.dart';
import 'package:plant_app/screens/about_us_screen.dart';
import 'package:plant_app/screens/login_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static const String id="Profile";
    void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
//  void _launchURL(String url) async {
//     if (await canLaunchUrl(url as Uri)) {
//       await launchUrl(url as Uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Information
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
              title: Text('Trang Lê'),
              subtitle: Text('0963264898'),
            ),
            Divider(),

            // Loyalty Points
           ListTile(
  leading: Icon(Icons.star, color: Colors.yellow),
  title: Text('KH Thân thiết'),
  subtitle: Text('Bạn cần tích lũy thêm 200 điểm để đạt thành viên Bạc'),
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoyaltyMembershipScreen()),
    );
  },
),

            Divider(),

            // Points Wallet
           ListTile(
  leading: Icon(Icons.wallet_giftcard, color: Colors.orange),
  title: Text('Ví tích điểm'),
  trailing: Text('100 điểm', style: TextStyle(color: Colors.green)), // Thay đổi số điểm này bằng số điểm thực tế của người dùng
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PointsWalletScreen()),
    );
  },
),
            Divider(),

            // Referral Code
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.blue),
              title: Text('Mã giới thiệu'),
              trailing: Text('84387878845', style: TextStyle(color: Colors.blue)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ReferralCodeDialog(referralCode: '84387878845'); // Replace with your actual referral code
                  },
                );
              },
            ),
            Divider(),

            // Vouchers
            ListTile(
              leading: Icon(Icons.discount, color: Colors.red),
              title: Text('Voucher của tôi'),
              subtitle: Text('Sử dụng các mã giảm giá đã nhận'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => VoucherScreen()),
                );
              },
            ),
            Divider(),

            // Address
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.purple),
              title: Text('Địa chỉ của tôi'),
              subtitle: Text('Quản lý địa chỉ nhận hàng'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddressMapScreen()),
                );
              },
            ),
            Divider(),

            // Facebook Fanpage
             ListTile(
              leading: Icon(Icons.facebook, color: Colors.blue),
              title: Text('Fanpage GS'),
              subtitle: Text('Facebook Fanpage chăm sóc khách hàng'),
              onTap: () {
                // _launchURL('https://www.facebook.com/changcute2511/');
              },
            ),
            Divider(),

            // About Us
            ListTile(
              leading: Icon(Icons.info, color: Colors.green),
              title: Text('Giới thiệu về chúng tôi'),
              onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );}
            ),
            Divider(),

            // Logout
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Đăng xuất'),
               onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReferralCodeDialog extends StatelessWidget {
  final String referralCode;

  ReferralCodeDialog({required this.referralCode});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Mã giới thiệu của bạn'),
      content: Text(referralCode),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

class VoucherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> vouchers = [
      {
        'title': '10% off',
        'description': 'Get 10% off on your next purchase',
        'validity': 'Valid until: 31/12/2024',
        'image': 'https://via.placeholder.com/300',
      },
      {
        'title': '20% off',
        'description': 'Enjoy 20% off on all items',
        'validity': 'Valid until: 31/12/2024',
        'image': 'https://via.placeholder.com/300',
      },
      {
        'title': 'Buy 1 Get 1 Free',
        'description': 'Buy one get one free on selected items',
        'validity': 'Valid until: 31/12/2024',
        'image': 'https://via.placeholder.com/300',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Vouchers'),
      ),
      body: ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          final voucher = vouchers[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(voucher['image']!, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucher['title']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        voucher['description']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        voucher['validity']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


