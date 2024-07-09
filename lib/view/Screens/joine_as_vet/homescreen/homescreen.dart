import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/appassets/textstyle/customstyles.dart';
import 'package:healmypet/view/auth/onboard/onboardingscreen.dart';
import 'package:iconsax/iconsax.dart';

class VetHomeScreen extends StatelessWidget {
  final String vetId = 'RGeJLmjwhsOe18VAGpCodYUmzBo2'; // Example vet ID
  final _auth=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('vets').doc(_auth!.uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var vetData = snapshot.data!;
              bool isApproved = vetData['isApproved'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                if (!isApproved)
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          final _auth=FirebaseAuth.instance;
                          _auth.signOut().then((value)=>Get.to(Onboardingscreen()));
                        }, icon: Icon(Iconsax.logout,color: Colors.red,)),
                        Center(
                          child: Card(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Please wait for admin approval',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            
                    // Header Section
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/dog.png'),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Hello,\nDr. Hamna',
                          style: AppTextStyles.medium,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
      if (isApproved) ...[
                    // Active Appointments Section
                    Text('Active Appointments',
                        style: AppTextStyles.heading1.copyWith(fontSize: 18)),
                    SizedBox(height: 16),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 150,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ),
                      items: [1, 2, 3, 4].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/images/dog.png'),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Maxi',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    'Dog | Border Collie',
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 24),

                    // Manage Time Section
                    Text('Manage Time',
                        style: AppTextStyles.heading1.copyWith(fontSize: 18)),
                    SizedBox(height: 16),
                    TableCalendar(),

                    // Message Customer Section
                    SizedBox(height: 24),
                    Text('Message Customer',
                        style: AppTextStyles.heading1.copyWith(fontSize: 18)),
                    SizedBox(height: 16),
                    ListTile(
                      tileColor: bgcolor1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: grey1,
                        child: Icon(
                          Iconsax.user,
                          color: whitecolor,
                        ),
                      ),
                      title: Text(
                        'Abdul Fatir Ch',
                        style: AppTextStyles.medium,
                      ),
                      subtitle: Text(
                        'Active Now',
                        style: AppTextStyles.small.copyWith(color: Colors.green),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TableCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: [
          TableRow(
            children: [
              _buildTableCell(context, '29'),
              _buildTableCell(context, '30'),
              _buildTableCell(context, '31'),
              _buildTableCell(context, '1'),
              _buildTableCell(context, '2'),
              _buildTableCell(context, '3'),
              _buildTableCell(context, '4'),
            ],
          ),
          TableRow(
            children: [
              _buildTableCell(context, '5'),
              _buildTableCell(context, '6'),
              _buildTableCell(context, '7'),
              _buildTableCell(context, '8'),
              _buildTableCell(context, '9'),
              _buildTableCell(context, '10', highlighted: true),
              _buildTableCell(context, '11'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(BuildContext context, String day,
      {bool highlighted = false}) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: highlighted ? Colors.blue : Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      height: 50,
    );
  }
}
