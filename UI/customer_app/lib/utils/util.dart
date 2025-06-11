import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class ImageUtils {
  static Image imageFromBase64String(String base64String,
      {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    return Image.memory(
      base64Decode(base64String),
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.person,
          size: 60,
          color: Colors.grey,
        );
      },
    );
  }

  static Future<String?> imageToBase64(File imageFile) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      return base64Encode(imageBytes);
    } catch (e) {
      print('Error converting image to base64: $e');
      return null;
    }
  }

  static bool isValidBase64(String str) {
    try {
      final cleaned = str.contains(',') ? str.split(',').last : str;
      base64Decode(cleaned);
      return true;
    } catch (_) {
      return false;
    }
  }
}
