import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

///* This method is used to show images and animations in the app with different formats
///* (SVG, Network, Lottie, Asset) and handle loading and error states.
Widget showImage({
  required String image,
  BoxFit? fit,
  double? width,
  double? height,
}) {
  // in the case of svg
  if (image.endsWith('.svg')) {
    return SvgPicture.asset(
      image,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
    );
  }
  // in the case of network image
  else if (image.startsWith('http') || image.startsWith('https')) {
    return Image.network(
      image,
      fit: fit,
      width: width,
      height: height,
      // Show a progress indicator while the image is loading
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      // Show a broken image icon if loading fails
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(Icons.broken_image_outlined, color: Colors.grey),
          ),
        );
      },
    );
  }
  // in the case of lottie file animations (.json, .lottie, .lottie.json)
  else if (image.endsWith('.json') ||
      image.endsWith('.lottie') ||
      image.contains('.lottie')) {
    return Lottie.asset(
      image,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(Icons.broken_image_outlined, color: Colors.grey),
          ),
        );
      },
    );
  }
  // in the case of asset image
  else {
    return Image.asset(
      image,
      fit: fit,
      width: width,
      height: height,
      // Show a broken image icon if the asset is missing or fails
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(Icons.broken_image_outlined, color: Colors.grey),
          ),
        );
      },
    );
  }
}
