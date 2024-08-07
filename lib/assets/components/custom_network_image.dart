import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? height;
  final double? width;

  final Function? placeholder;
  final BaseCacheManager? cacheManager;
  final ColorFilter? colorFilter;

  CustomNetworkImage(
    this.url, {
    this.fit,
    this.height,
    this.width,
    this.placeholder,
    this.cacheManager,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        url,
        errorBuilder: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
        fit: fit,
        height: height,
        width: width,
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      placeholder: placeholder == null
          ? (context, url) => const Center(child: CircularProgressIndicator())
          : placeholder as Widget Function(BuildContext, String)?,
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            colorFilter: colorFilter,
          ),
        ),
      ),
      cacheManager: cacheManager,
    );
  }
}

// Where possible please use full fat CustomNetworkImage
ImageProvider customNetworkImageProvider(String? url) {
  if (url == null) {
    return const AssetImage('assets/imgs/plain-white-background.jpg');
  }
  return CachedNetworkImageProvider(
    url,
  );
}
