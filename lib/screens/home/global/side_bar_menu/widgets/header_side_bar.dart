import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeaderSideBar extends StatelessWidget {
  final String urlImage;
  final String name;
  final String email;
  final Future? Function() onClick;

  const HeaderSideBar({
    Key? key,
    required this.urlImage,
    required this.name,
    required this.email,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: paddingMedium);

    return InkWell(
      onTap: onClick,
      child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: paddingXXLarge)),
        child: Row(
          children: <Widget>[
            //CircleAvatar(
            //  radius: circleRaidusMedium,
            //  backgroundImage: NetworkImage(urlImage),
            //),
            CachedNetworkImage(
              imageUrl: urlImage,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(width: paddingMedium),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontSize: textSizeLarge),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.white, fontSize: textSizeSmall2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
