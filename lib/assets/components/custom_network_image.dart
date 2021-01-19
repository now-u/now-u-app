import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double height;

  CustomNetworkImage(
    this.url,
    {
      this.fit,
      this.height
    }
  );

  @override
  Widget build(BuildContext context) {
    // If there is no image then return an error icon 
    if (url == null) {
      return Center(child: Icon(Icons.error));
    }
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      fit: fit,
      height: height,
    );
  }
}

ImageProvider customNetworkImageProvider(String url) {
  return CachedNetworkImageProvider(url);
}
