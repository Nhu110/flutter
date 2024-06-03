import 'package:flutter/material.dart';

 void main() {
  runApp(MaterialApp(
    home: AboutScreen(),
  ));
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Giới thiệu'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Phiên bản RN và APP'),
            trailing: Text('v5.01.3.2.11.2'),
          ),
          Divider(),
          ListTile(
            title: Text('Chính sách bảo mật'),
            onTap: () {
              // Điều hướng đến màn hình chính sách bảo mật
            },
          ),
          Divider(),
          ListTile(
            title: Text('Điều khoản sử dụng'),
            onTap: () {
              // Điều hướng đến màn hình điều khoản sử dụng
            },
          ),
        ],
      ),
    );
  }
}