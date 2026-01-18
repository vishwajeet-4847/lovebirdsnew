// ignore_for_file: must_be_immutable

import 'package:cached_ne' 'twork_image/cached_network_image.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomImage extends StatelessWidget {
  final String image;
  BoxFit? fit;
  double? padding;
  CustomImage({
    super.key,
    required this.image,
    this.fit,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final cacheHeight = (box.maxHeight * 2).toInt();
        final cacheWidth = (box.maxWidth * 2).toInt();

        return (image != "")
            ? Database.networkImage(Api.baseUrl + image) != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: Database.networkImage(Api.baseUrl + image)!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: padding ?? 30),
                          child: Image.asset(AppAsset.icPlaceHolder),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: padding ?? 30),
                          child: Image.asset(AppAsset.icPlaceHolder),
                        );
                      },
                      memCacheHeight: cacheHeight,
                      maxHeightDiskCache: cacheHeight,
                      memCacheWidth: cacheWidth,
                      maxWidthDiskCache: cacheWidth,
                    ),
                  )
                : image.startsWith("http")
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: padding ?? 30),
                              child: Image.asset(AppAsset.icPlaceHolder),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: padding ?? 30),
                              child: Image.asset(AppAsset.icPlaceHolder),
                            );
                          },
                          memCacheHeight: cacheHeight,
                          maxHeightDiskCache: cacheHeight,
                          memCacheWidth: cacheWidth,
                          maxWidthDiskCache: cacheWidth,
                        ),
                      )
                    : FutureBuilder(
                        future: _onCheckImage(Api.baseUrl + image),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Offstage();
                          } else if (snapshot.hasError) {
                            return const Offstage();
                          } else {
                            if (snapshot.data == true) {
                              Database.onSetNetworkImage(Api.baseUrl + image);
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: Api.baseUrl + image,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: padding ?? 30),
                                      child:
                                          Image.asset(AppAsset.icPlaceHolder),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: padding ?? 30),
                                      child:
                                          Image.asset(AppAsset.icPlaceHolder),
                                    );
                                  },
                                  memCacheHeight: cacheHeight,
                                  maxHeightDiskCache: cacheHeight,
                                  memCacheWidth: cacheWidth,
                                  maxWidthDiskCache: cacheWidth,
                                ),
                              );
                            } else {
                              return const Offstage();
                            }
                          }
                        },
                      )
            : const Offstage();
      },
    );
  }
}

Future<bool> _onCheckImage(String image) async {
  try {
    final response = await http.head(Uri.parse(image));

    return response.statusCode == 200;
  } catch (e) {
    Utils.showLog('Check Profile Image Filed !! => $e');
    return false;
  }
}

/*return (image.startsWith("http"))
        ? CachedNetworkImage(
            imageUrl: image,
            fit: fit ?? BoxFit.cover,
            placeholder: (context, url) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 30),
                child: Image.asset(
                  AppAsset.icPlaceHolder,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 30),
                child: Image.asset(
                  AppAsset.icPlaceHolder,
                ),
              );
            },
          )
        : CachedNetworkImage(
            imageUrl: "${Api.baseUrl}$image",
            fit: fit ?? BoxFit.cover,
            placeholder: (context, url) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 30),
                child: Image.asset(
                  AppAsset.icPlaceHolder,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 30),
                child: Image.asset(
                  AppAsset.icPlaceHolder,
                ),
              );
            },
          );*/
