import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, this.userName = "Kwashie Jude"})
      : super(key: key);

  final String _url = "";
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _url.isEmpty
            ? const CircleAvatar(
                radius: 44.0,
                backgroundColor: Color(0xFFDBDBDB),
              )
            : CircleAvatar(
                radius: 44.0,
                backgroundImage: NetworkImage(_url),
              ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}