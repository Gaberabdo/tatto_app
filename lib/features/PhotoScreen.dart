import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'package:tattoapp/features/authentication/widget_components/validator_components.dart';

class TattooApp extends StatefulWidget {
  @override
  _TattooAppState createState() => _TattooAppState();
}

class _TattooAppState extends State<TattooApp> {
  File? _userHandImage;
  List<String> _tattooImages = [
    'assets/images/pngwing.com (1).png',
    'assets/images/pngwing.com (2).png',
    'assets/images/pngwing.com (4).png',
    'assets/images/pngwing.com (5).png',
    'assets/images/pngwing.com (6).png',
    'assets/images/pngwing.com (7).png',
    'assets/images/pngwing.com (8).png',
    'assets/images/pngwing.com (9).png',
    'assets/images/pngwing.com (10).png',
    'assets/images/pngwing.com (11).png',
    'assets/images/pngwing.com (12).png',
    'assets/images/pngwing.com (13).png',
    'assets/images/pngwing.com (14).png',
    'assets/images/pngwing.com (15).png',
    'assets/images/pngwing.com (16).png',
    'assets/images/pngwing.com (17).png',
    'assets/images/pngwing.com (18).png',
    'assets/images/pngwing.com (19).png',
    'assets/images/pngwing.com (20).png',
    'assets/images/pngwing.com (21).png',
    'assets/images/pngwing.com (22).png',
    'assets/images/pngwing.com (23).png',
    'assets/images/pngwing.com (24).png',
    'assets/images/pngwing.com (25).png',
    // Add more tattoo images here...
  ];

  final picker = ImagePicker();
  GlobalKey globalKey = GlobalKey();

  Future<void> _captureImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _userHandImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Please Make your hand in Center',
          style: GoogleFonts.arya(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_userHandImage == null)
              MaterialButton(
                color: Colors.red.shade900,
                height: 50,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                onPressed: () => _captureImage(ImageSource.camera),
                child: Text(
                  'Capture Image',
                  style: textTheme(fontSize: 22),
                ),
              )
            else
              Image.file(
                _userHandImage!,
                width: 300,
                height: 350,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            MaterialButton(
              color: Colors.red.shade900,
              height: 50,
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              onPressed: () => _captureImage(ImageSource.camera),
              child: Text(
                'Select another Image',
                style: textTheme(fontSize: 22),
              ),
            ),
            if (_userHandImage != null)
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: _tattooImages.length,
                  itemBuilder: (context, index) {
                    return TattooHandWidget(
                      userHandImage: _userHandImage!,
                      tattooImage: _tattooImages[index],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTattoo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _userHandImage = File(pickedFile.path);
      });
    }
  }
}

class TattooHandWidget extends StatelessWidget {
  final File userHandImage;
  final String tattooImage;
  GlobalKey globalKey = GlobalKey();

  TattooHandWidget({required this.userHandImage, required this.tattooImage});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Stack(
        children: [
          Image.file(
            userHandImage,
            width: 300,
            height: 400,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100, // Set the top position of the tattoo on the hand image
            left: 100, // Set the left position of the tattoo on the hand image
            width: 100, // Set the width of the tattoo
            height: 100, // Set the height of the tattoo
            child:
                Image.asset(tattooImage), // Display the selected tattoo image
          ),
          IconButton(
            onPressed: () => _downloadCompositeImage(),
            icon: Icon(Icons.download, size: 35),
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Future<void> _downloadCompositeImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(
          pixelRatio: 3.0); // Increase pixelRatio for higher resolution
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List uint8list = byteData!.buffer.asUint8List();

      final appDir = await getApplicationDocumentsDirectory();
      final compositeImagePath = "${appDir.path}/composite_image.png";

      // Write the image data to a file
      final compositeFile = File(compositeImagePath);
      await compositeFile.writeAsBytes(uint8list);

      // Save the image to the device's gallery
      final result = await ImageGallerySaver.saveFile(compositeImagePath);
      if (result['isSuccess']) {
        print("Composite image saved to gallery");
      } else {
        print("Failed to save composite image to gallery");
      }
    } catch (e) {
      print("Error downloading composite image: $e");
    }
  }
}

Future<void> downloadImage(String imageUrl) async {
  try {
    // Make an HTTP GET request to fetch the image data
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Get the application directory to store the image
      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          imageUrl.split('/').last; // Extract the file name from the URL

      // Create the local file path
      final localFilePath = "${appDir.path}/$fileName";

      // Write the image data to the local file
      final file = File(localFilePath);
      await file.writeAsBytes(response.bodyBytes);

      print("Image downloaded to: $localFilePath");
    } else {
      print("Failed to download image: ${response.statusCode}");
    }
  } catch (e) {
    print("Error downloading image: $e");
  }
}

// Add this line

// ...

class TattooHandWidgett extends StatefulWidget {
  final File userHandImage;
  final String tattooImage;

  TattooHandWidgett({required this.userHandImage, required this.tattooImage});

  @override
  _TattooHandWidgetState createState() => _TattooHandWidgetState();
}

class _TattooHandWidgetState extends State<TattooHandWidgett> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Stack(
        children: [
          Image.file(
            widget.userHandImage,
            width: 300,
            height: 400,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100, // Set the top position of the tattoo on the hand image
            left: 100, // Set the left position of the tattoo on the hand image
            width: 100, // Set the width of the tattoo
            height: 100, // Set the height of the tattoo
            child: Image.asset(
                widget.tattooImage), // Display the selected tattoo image
          ),
          IconButton(
            onPressed: () => _downloadCompositeImage(),
            icon: Icon(Icons.download, size: 35),
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Future<void> _downloadCompositeImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(
          pixelRatio: 3.0); // Increase pixelRatio for higher resolution
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List uint8list = byteData!.buffer.asUint8List();

      final appDir = await getApplicationDocumentsDirectory();
      final compositeImagePath = "${appDir.path}/composite_image.png";

      // Write the image data to a file
      final compositeFile = File(compositeImagePath);
      await compositeFile.writeAsBytes(uint8list);

      // Save the image to the device's gallery
      final result = await ImageGallerySaver.saveFile(compositeImagePath);
      if (result['isSuccess']) {
        print("Composite image saved to gallery");
      } else {
        print("Failed to save composite image to gallery");
      }
    } catch (e) {
      print("Error downloading composite image: $e");
    }
  }
}
