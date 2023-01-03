import 'package:flutter/material.dart';

Container movieContainer(String name, String imageLink, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width * 0.28,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: NetworkImage(imageLink),
            ),
            border: Border.all(),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        Text(
          name.length > 14 ? name.substring(0, 14) + '...' : name,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
