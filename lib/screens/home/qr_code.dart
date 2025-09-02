import 'dart:ui';
import 'package:atmavishwasect/models/qr_card_details_model.dart';
import 'package:atmavishwasect/providers/qr_scan_provider.dart';
import 'package:atmavishwasect/screens/home/home_screen.dart';
import 'package:atmavishwasect/screens/home/qr_card_details.dart';
import 'package:atmavishwasect/utilites/helper.dart';
import 'package:atmavishwasect/widgets/custom_inkwell_btn.dart';
import 'package:atmavishwasect/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

class QRcodeScreen extends StatefulWidget {
  const QRcodeScreen({super.key});

  @override
  State<QRcodeScreen> createState() => _QRcodeScreenState();
}

class _QRcodeScreenState extends State<QRcodeScreen> {
  final GlobalKey qrKey = GlobalKey();

  Future<void> _handleQrScanResult(String text) async {
    final qrProvider = Provider.of<QrScanProvider>(context, listen: false);

    qrProvider.reset();
    qrProvider.setQrText(text);
    await qrProvider.fetchResultFromApi();

    if (!mounted) return;

    if (qrProvider.error != null ||
        qrProvider.apiResult != 'Verified successfully') {
      Helper.showSnack(context, "Data not found");
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PublicHelpingCardScreen(
            card: PublicHelpingCard.fromJson(qrProvider.resultData!),
          ),
        ),
      );
    }
  }

  Future<void> _pickAndScanImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Crop Image'),
        ],
      );

      if (cropped != null) {
        try {
          final result = await QrCodeToolsPlugin.decodeFrom(cropped.path);
          if (result != null && result.isNotEmpty) {
            await _handleQrScanResult(result);
          } else {
            if (!mounted) return;
            Helper.showSnack(context, 'No QR code found in image.');
          }
        } catch (e) {
          if (!mounted) return;
          Helper.showSnack(context, 'Failed to decode QR: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanAreaSize = MediaQuery.of(context).size.width * 0.7;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CustomInkWell(
            onTap: () => Helper.toRemoveUntiScreen(context, HomeScreen()),
            child: const Icon(Icons.arrow_back),
          ),
          title: CustomText(title: "QR Code Scan"),
          actions: [
            IconButton(
              icon: const Icon(Icons.photo_library),
              tooltip: 'Select by Photo',
              onPressed: () => _pickAndScanImage(context),
            ),
          ],
        ),
        body: Consumer<QrScanProvider>(
          builder: (context, qrProvider, _) {
            return Stack(
              children: [
                QRCodeDartScanView(
                  key: qrKey,
                  onCameraError: (String error) {
                    debugPrint('Camera Error: $error');
                  },
                  typeScan: TypeScan.live,
                  onCapture: (Result result) async {
                    if (result.text.isNotEmpty) {
                      await _handleQrScanResult(result.text);
                    } else {
                      debugPrint('QR result had no text!');
                    }
                  },
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = constraints.maxHeight;
                    final left = (width - scanAreaSize) / 2;
                    final top = (height - scanAreaSize) / 2;
                    return Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          width: width,
                          height: top,
                          child: _BlurArea(),
                        ),
                        Positioned(
                          left: 0,
                          top: top + scanAreaSize,
                          width: width,
                          height: height - (top + scanAreaSize),
                          child: _BlurArea(),
                        ),
                        Positioned(
                          left: 0,
                          top: top,
                          width: left,
                          height: scanAreaSize,
                          child: _BlurArea(),
                        ),
                        Positioned(
                          left: left + scanAreaSize,
                          top: top,
                          width: left,
                          height: scanAreaSize,
                          child: _BlurArea(),
                        ),
                        Positioned(
                          left: left,
                          top: top,
                          width: scanAreaSize,
                          height: scanAreaSize,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                if (qrProvider.isLoading)
                  Container(
                    color: Colors.black45,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BlurArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(color: Colors.black.withOpacity(0.3)),
      ),
    );
  }
}
