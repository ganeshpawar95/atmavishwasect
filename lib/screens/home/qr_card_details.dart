import 'package:atmavishwasect/models/qr_card_details_model.dart';
import 'package:atmavishwasect/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PublicHelpingCardScreen extends StatefulWidget {
  final PublicHelpingCard card;

  const PublicHelpingCardScreen({super.key, required this.card});

  @override
  State<PublicHelpingCardScreen> createState() =>
      _PublicHelpingCardScreenState();
}

class _PublicHelpingCardScreenState extends State<PublicHelpingCardScreen> {
  @override
  void initState() {
    super.initState();
    // Force landscape mode when entering this page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // Restore orientation settings when leaving this page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.card.familyDetails);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,

        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ), // or EdgeInsets.zero
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),

        title: CustomText(
          title: 'Card Details',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: const Border(
                  bottom: BorderSide(
                    color: Colors.green, // Your green border
                    width: 1,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'PUBLIC HELPING CARD YOJANE',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.yellow[100],
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isPortrait =
                      MediaQuery.of(context).orientation ==
                      Orientation.portrait;

                  if (isPortrait) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                          columnWidths: const {
                            0: IntrinsicColumnWidth(),
                            1: FlexColumnWidth(),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          children: [
                            tableRow('CARD NUMBER', widget.card.cardNumber),
                            tableRow('NAME', widget.card.name),
                            tableRow('AGE', widget.card.age.toString()),
                            tableRow('MOBILE', widget.card.mobile),
                            tableRow(
                              'RATION/ADHAAR',
                              widget.card.rationOrAadhaar,
                            ),
                            tableRow('GENDER', widget.card.gender),
                            tableRow(
                              'TOTAL FAMILY MEMBERS',
                              widget.card.totalFamilyMembers.toString(),
                            ),
                            tableRow(
                              'DATE OF EXPIRY',
                              widget.card.dateOfExpiry,
                            ),
                            tableRow('ADDRESS', widget.card.address),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.card.imageUrl,
                              width: 250,
                              height: 250,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person, size: 100),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.top,
                            children: [
                              tableRow('CARD NUMBER', widget.card.cardNumber),
                              tableRow('NAME', widget.card.name),
                              tableRow('AGE', widget.card.age.toString()),
                              tableRow('MOBILE', widget.card.mobile),
                              tableRow(
                                'RATION/ADHAAR',
                                widget.card.rationOrAadhaar,
                              ),
                              tableRow('GENDER', widget.card.gender),
                              tableRow(
                                'TOTAL FAMILY MEMBERS',
                                widget.card.totalFamilyMembers.toString(),
                              ),
                              tableRow(
                                'DATE OF EXPIRY',
                                widget.card.dateOfExpiry,
                              ),
                              tableRow('ADDRESS', widget.card.address),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.card.imageUrl,
                            width: 250,
                            height: 250,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 100),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: const Border(
                  top: BorderSide(
                    color: Colors.green, // Your green border
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: Colors.green, // Your green border
                    width: 1,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'FAMILY DETAILS',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              color: Colors.yellow[100],
              padding: const EdgeInsets.all(16),
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: IntrinsicColumnWidth(),
                  3: FlexColumnWidth(),
                },
                border: TableBorder.all(color: Colors.green, width: 1),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  // Header Row
                  const TableRow(
                    decoration: BoxDecoration(color: Colors.greenAccent),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'NAME',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'RELATION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'AGE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'AADHAAR',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  // Dynamic Rows
                  ...widget.card.familyDetails.map((member) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(member.name),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(member.relation),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(member.age),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(member.adhaar),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TableRow tableRow(String label, String value) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          '$label ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('-  $value'),
      ),
    ],
  );
}
