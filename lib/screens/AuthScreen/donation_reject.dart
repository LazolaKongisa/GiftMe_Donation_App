import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_application/provider/db_service.dart';
import 'package:final_application/screens/AuthScreen/donation_review.dart';
import 'package:final_application/screens/AuthScreen/view_item.dart';
import 'package:final_application/styles/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteConfirm extends StatefulWidget {
  const DeleteConfirm({Key key, this.title, this.description, this.id})
      : super(key: key);
  final title;
  final description;
  final id;

  @override
  _DeleteConfirmState createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<DeleteConfirm> {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Donate Item');
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 360, left: 30),
                child: Text(
                    "This Will Result in the donation item being deleted, Continue?"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 120),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          
                            onPressed: () {
                              DbHelper().delete(id: widget.id, title: widget.title, desciption: widget.description).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewDonations()),
                              );
                            },
                            child: Text("Yes")),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewDonations()),
                              );
                            },
                            child: Text("No")),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
