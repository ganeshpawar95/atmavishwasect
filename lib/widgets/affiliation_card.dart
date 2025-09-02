import 'package:atmavishwasect/widgets/custom_inkwell_btn.dart';
import 'package:atmavishwasect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AffiliationCard extends StatelessWidget {
  final String name;
  final String image_path;
  final String address;
  final String contact_no;
  Function? onTap;

  AffiliationCard({
    super.key,
    this.name = "",
    this.image_path = "",
    this.address = "",
    this.contact_no = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: 100,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF008374),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    10,
                  ), // Half of height/width for round
                  child: Container(
                    height: 90,
                    width: 90,
                    color: Colors.white, // Optional: background color
                    child: image_path.length != 0
                        ? Image.network(image_path, fit: BoxFit.fill)
                        : Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.fill,
                          ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            CustomText(
                              title: "Name-",
                              textAlign: TextAlign.start,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 9),
                            Expanded(
                              child: CustomText(
                                title: name,
                                textAlign: TextAlign.start,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            CustomText(
                              title: "Address-",
                              textAlign: TextAlign.start,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 3),
                            Expanded(
                              child: CustomText(
                                title: address,
                                textAlign: TextAlign.start,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            CustomText(
                              title: "Contact No-",
                              textAlign: TextAlign.start,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 3),
                            Expanded(
                              child: CustomText(
                                title: contact_no,
                                textAlign: TextAlign.start,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
