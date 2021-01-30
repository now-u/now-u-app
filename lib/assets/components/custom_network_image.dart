import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double height;

  final Function placeholder; 
  final Function errorWidget; 
  final Function progressIndicatorBuilder; 
  final BaseCacheManager cacheManager;

  CustomNetworkImage(
    this.url,
    {
      this.fit,
      this.height,
      this.placeholder,
      this.errorWidget,
      this.progressIndicatorBuilder,
      this.cacheManager,
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
      placeholder: placeholder == null  && progressIndicatorBuilder == null ? (context, url) => Center(child: CircularProgressIndicator()) : placeholder,
      errorWidget: errorWidget ?? (context, url, error) => Center(child: Icon(Icons.error)),
      progressIndicatorBuilder: progressIndicatorBuilder,
      fit: fit,
      height: height,
      cacheManager: cacheManager, 
    );
  }
}

// Where possible please use full fat CustomNetworkImage
ImageProvider customNetworkImageProvider(String url) {
  if (url == null) {
    return AssetImage('assets/imgs/plain-white-background.jpg');
  }
  return CachedNetworkImageProvider(url,);
}

