import 'package:feliz_coin/commons/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedNetworkImageWidget extends StatelessWidget {
  const CustomCachedNetworkImageWidget({
    Key? key,
    this.isRadius = true,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.radius,
    this.isSeller,
    this.shape,
  }) : super(key: key);
  final bool isRadius;
  final String? imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? radius;
  final bool? isSeller;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ??
          'https://pbs.twimg.com/profile_images/932599989964099584/GKV4NGiU_400x400.jpg',
      imageBuilder: (context, imageProvider) => Container(
        width: width!,
        height: height!,
        decoration: BoxDecoration(
          borderRadius: isRadius ? radius : null,
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: width!,
        height: height!,
        child: CircularProgressIndicator(
          strokeWidth: 3.w,
          color: isSeller ?? false ? ThemeHelper.brown80 : ThemeHelper.green100,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
