import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:LoveBirds/common/loading_widget.dart';
import 'package:LoveBirds/custom/custom_image/custom_profile_image.dart';
import 'package:LoveBirds/custom/custom_image/host_photo_gallery.dart';
import 'package:LoveBirds/custom/no_data_found/no_data_found.dart';
import 'package:LoveBirds/pages/chat_page/controller/chat_controller.dart';
import 'package:LoveBirds/pages/chat_page/widget/receiver_audio_message.dart';
import 'package:LoveBirds/pages/chat_page/widget/receiver_chat_widget.dart';
import 'package:LoveBirds/pages/chat_page/widget/sender_audio_message_widget.dart';
import 'package:LoveBirds/pages/chat_page/widget/sender_chat_widget.dart';
import 'package:LoveBirds/utils/api.dart';
import 'package:LoveBirds/utils/asset.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/constant.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/enum.dart';
import 'package:LoveBirds/utils/font_style.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svga/flutter_svga.dart';
import 'package:get/get.dart';

class ChatCenterWidget extends GetView<ChatController> {
  const ChatCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - (MediaQuery.of(context).viewPadding.top + 60) - 180,
      child: GetBuilder<ChatController>(
        id: AppConstant.onChatList,
        builder: (logic) {
          return Database.isHost
              ? logic.isLoadingHost
                  ? const LoadingWidget()
                  : logic.hostChats.isEmpty
                      ? NoDataFoundWidget()
                      : buildChatList(logic.hostChats)
              : logic.isLoadingUser
                  ? const LoadingWidget()
                  : logic.userChats.isEmpty
                      ? NoDataFoundWidget()
                      : buildChatList(logic.userChats);
        },
      ),
    );
  }

  // ********************* All Chat List
  Widget buildChatList(List chatList) {
    return GetBuilder<ChatController>(
      builder: (logic) {
        return ListView.builder(
          controller: logic.scrollController,
          shrinkWrap: true,
          reverse: true,
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            if (chatList.isEmpty) {
              log("Empty");
              return const Text("Chat is empty");
            }
            final chat = chatList[index];
            final isLastMessage = index == 0;
            if (chat.messageType == 1) {
              return chat.senderId == Database.loginUserId ||
                      chat.senderId == Database.hostId
                  ? SenderChatWidget(
                      message: chat.message ?? "",
                      time: chat.date ?? "",
                    )
                  : ReceiverChatWidget(
                      message: chat.message ?? "",
                      time: chat.date ?? "",
                    );
            } else if (chat.messageType == 2) {
              return buildImageMessage(chat, context, isLastMessage, chat.date);
            } else if (chat.messageType == 3) {
              return chat.senderId == Database.hostId ||
                      chat.senderId == Database.loginUserId
                  ? SenderAudioMessageWidget(
                      audioUrl: chat.audio ?? "",
                      time: chat.date ?? "",
                      id: chat.id ?? "",
                      chat: chat,
                      isLastMessage: isLastMessage,
                    )
                  : ReceiverAudioMessageWidget(
                      audioUrl: chat.audio ?? "",
                      time: chat.date ?? "",
                      id: chat.id ?? "",
                      chat: chat,
                    );
            } else if (chat.messageType == 4) {
              return chat.senderId == Database.hostId ||
                      chat.senderId == Database.loginUserId
                  ? buildSenderGiftMessage(chat)
                  : buildReceiverGiftMessage(chat);
            } else if (chat.messageType == 5) {
              return buildVoiceCall(chat);
            } else if (chat.messageType == 6) {
              return buildVideoCall(chat);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  Widget buildImageMessage(chat, context, isLastMessage, time) {
    String? imageUrl = chat.image;

    if (imageUrl == null || imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    bool isSender = chat.senderId == Database.loginUserId ||
        chat.senderId == Database.hostId;

    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: isSender == false,
          child: GetBuilder<ChatController>(
            builder: (logic) {
              return Container(
                padding: const EdgeInsets.all(1.2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.whiteColor),
                ),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CustomImage(
                    padding: 8,
                    image: logic.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        GetBuilder<ChatController>(
          id: AppConstant.onChatList,
          builder: (logic) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  Get.to(FullScreenImageView(imageUrl: imageUrl));
                },
                child: Column(
                  crossAxisAlignment: isSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                      ),
                      width: 154,
                      height: 190,
                      child: isLastMessage
                          ? logic.isLoadingImage
                              ? const CupertinoActivityIndicator(
                                  color: AppColors.messageColor,
                                  radius: 15,
                                )
                              : CustomImage(
                                  padding: 8,
                                  image: imageUrl,
                                  fit: BoxFit.cover,
                                )
                          : CustomImage(
                              padding: 8,
                              image: imageUrl,
                              fit: BoxFit.cover,
                            ),
                    ),
                    6.height,
                    GetBuilder<ChatController>(builder: (logic) {
                      return Text(
                        logic.formatTimeFromApi(time),
                        style: AppFontStyle.styleW700(AppColors.whiteColor, 10),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
        Visibility(
          visible: isSender == true,
          child: GetBuilder<ChatController>(
            builder: (logic) {
              return Container(
                padding: const EdgeInsets.all(1.2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.whiteColor),
                ),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CustomImage(
                    padding: 8,
                    image: Database.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).paddingOnly(bottom: 15);
  }

  Widget buildSenderGiftMessage(chat) {
    return Row(
      key: ValueKey('gift_${chat.id ?? chat.image ?? chat.message}'),
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.messageColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AppColors.whiteColor,
                    ),
                    child: chat.giftType == 3
                        ? GetBuilder<ChatController>(
                            builder: (logic) {
                              final shouldAuto =
                                  logic.shouldAutoPlayFor(chat.id ?? "");
                              return GiftSvgaOnce(
                                key: ValueKey(
                                    'svga_${chat.id ?? chat.image ?? chat.message}'),
                                svgaUrl: Api.baseUrl +
                                    (chat.giftImage ?? chat.message ?? ""),
                                thumbUrl: Api.baseUrl +
                                    (chat.giftsvgaImage ??
                                        chat.image ??
                                        chat.message ??
                                        ""),
                                size: const Size(80, 80),
                                autoPlayFirstTime: shouldAuto,
                                onFirstPlayComplete: () {
                                  final id = chat.id ?? "";
                                  if (id.isNotEmpty)
                                    logic.markAutoPlayConsumed(id);
                                },
                                onFirstPlayFailed: () => logic
                                    .onAutoPlayFailed(chat.id ?? ""), // NEW

                                onTryPlay: () =>
                                    logic.onTryStartManualPlay(chat.id ?? ""),
                                onReplayStart: () => logic
                                    .onManualReplayStart(chat.id ?? ""), // NEW
                                onReplayComplete: () =>
                                    logic.onManualReplayFinished(
                                        chat.id ?? ""), // UPDATED
                                onReplayError: () => logic
                                    .onManualReplayError(chat.id ?? ""), // NEW
                              );
                            },
                          )
                        : Container(
                            color:
                                AppColors.colorTextGrey.withValues(alpha: 0.22),
                            width: 80,
                            height: 80,
                            child: CustomImage(
                              image: chat.image ?? chat.message ?? "",
                              padding: 8,
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      "x${chat.giftCount.toString()}",
                      style: AppFontStyle.styleW600(AppColors.blackColor, 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              GetBuilder<ChatController>(
                builder: (logic) {
                  return Text(
                    logic.formatTimeFromApi(chat.date.toString()),
                    style: AppFontStyle.styleW600(AppColors.whiteColor, 8),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        GetBuilder<ChatController>(
          builder: (logic) {
            return Container(
              padding: const EdgeInsets.all(1.2),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.whiteColor),
                  shape: BoxShape.circle),
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                ),
                clipBehavior: Clip.hardEdge,
                child: CustomImage(
                  padding: 8,
                  image: Database.profileImage,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    ).paddingOnly(bottom: 15);
  }

  Widget buildReceiverGiftMessage(chat) {
    return Row(
      key: ValueKey('gift_${chat.id ?? chat.image ?? chat.message}'),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GetBuilder<ChatController>(
          builder: (logic) {
            return Container(
              padding: const EdgeInsets.all(1.2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.whiteColor),
              ),
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.colorTextGrey.withValues(alpha: 0.22),
                ),
                clipBehavior: Clip.hardEdge,
                child: CustomImage(
                  padding: 8,
                  image: logic.profileImage,
                  fit: BoxFit.cover,
                ),
              ),
            ).paddingOnly(bottom: 8);
          },
        ),
        const SizedBox(width: 10),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.pinkMessageColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AppColors.whiteColor,
                    ),
                    child: chat.giftType == 3
                        ? GetBuilder<ChatController>(
                            builder: (logic) {
                              final shouldAuto =
                                  logic.shouldAutoPlayFor(chat.id ?? "");
                              return GiftSvgaOnce(
                                key: ValueKey(
                                    'svga_${chat.id ?? chat.image ?? chat.message}'),
                                svgaUrl: Api.baseUrl +
                                    (chat.giftImage ?? chat.message ?? ""),
                                thumbUrl: Api.baseUrl +
                                    (chat.giftsvgaImage ??
                                        chat.image ??
                                        chat.message ??
                                        ""),
                                size: const Size(80, 80),
                                autoPlayFirstTime: shouldAuto,
                                onFirstPlayComplete: () {
                                  final id = chat.id ?? "";
                                  if (id.isNotEmpty)
                                    logic.markAutoPlayConsumed(id);
                                },
                                onFirstPlayFailed: () => logic
                                    .onAutoPlayFailed(chat.id ?? ""), // NEW

                                onTryPlay: () =>
                                    logic.onTryStartManualPlay(chat.id ?? ""),
                                onReplayStart: () => logic
                                    .onManualReplayStart(chat.id ?? ""), // NEW
                                onReplayComplete: () =>
                                    logic.onManualReplayFinished(
                                        chat.id ?? ""), // UPDATED
                                onReplayError: () => logic
                                    .onManualReplayError(chat.id ?? ""), // NEW
                              );
                            },
                          )
                        : Container(
                            color:
                                AppColors.colorTextGrey.withValues(alpha: 0.22),
                            width: 80,
                            height: 80,
                            child: CustomImage(
                              padding: 8,
                              image: chat.image ?? chat.message ?? "",
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 1,
                    child: Text(
                      "x${chat.giftCount.toString()}",
                      style: AppFontStyle.styleW600(AppColors.blackColor, 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              GetBuilder<ChatController>(
                builder: (logic) {
                  return Text(
                    logic.formatTimeFromApi(chat.date.toString()),
                    style: AppFontStyle.styleW600(AppColors.whiteColor, 8),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ).paddingOnly(bottom: 15);
  }

  Widget buildVideoCall(chat) {
    bool isSender = chat.senderId == Database.loginUserId ||
        chat.senderId == Database.hostId;

    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.callBgColor,
            borderRadius: isSender
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.purple2),
                    child: Center(
                      child: Image.asset(
                        AppAsset.callIconGradiant,
                        height: 28,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(EnumLocale.txtVideoCall.name.tr,
                          style:
                              AppFontStyle.styleW800(AppColors.whiteColor, 18)),
                      Text(chat.callDuration ?? "00:00",
                          style: AppFontStyle.styleW600(
                              AppColors.chatDetailColor, 14)),
                    ],
                  ),
                  GetBuilder<ChatController>(
                    builder: (logic) {
                      return Text(
                        logic.formatTimeVideoCall(chat.date.toString()),
                        style: AppFontStyle.styleW600(AppColors.whiteColor, 10),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ).paddingOnly(bottom: 15),
      ],
    );
  }

  Widget buildVoiceCall(chat) {
    bool isSender = chat.senderId == Database.loginUserId ||
        chat.senderId == Database.hostId;

    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.callBgColor,
            borderRadius: isSender
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.purple2),
                    child: Center(
                      child: Image.asset(
                        AppAsset.icAudioCallIconGradiant,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        EnumLocale.txtAudioCall.name.tr,
                        style: AppFontStyle.styleW800(AppColors.whiteColor, 18),
                      ),
                      Text(
                        chat.callDuration ?? "00:00",
                        style: AppFontStyle.styleW600(
                            AppColors.chatDetailColor, 14),
                      ),
                    ],
                  ),
                  GetBuilder<ChatController>(
                    builder: (logic) {
                      return Text(
                        logic.formatTimeVideoCall(chat.date.toString()),
                        style: AppFontStyle.styleW600(AppColors.whiteColor, 10),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ).paddingOnly(bottom: 15),
      ],
    );
  }
}

class GiftSvgaOnce extends StatefulWidget {
  const GiftSvgaOnce({
    super.key,
    required this.svgaUrl,
    required this.thumbUrl,
    this.size = const Size(80, 80),
    this.autoPlayFirstTime = false,
    this.onFirstPlayComplete,
    this.onTryPlay,
    this.onReplayStart, // NEW
    this.onReplayComplete, // existing (finish ok)
    this.onFirstPlayFailed, // NEW
    this.onReplayError, // NEW
  });

  final String svgaUrl;
  final String thumbUrl;
  final Size size;
  final bool autoPlayFirstTime;
  final VoidCallback? onFirstPlayComplete;
  final Future<bool> Function()? onTryPlay;
  final VoidCallback? onFirstPlayFailed; // NEW

  /// Called when user tap replay actually starts (lock set in parent)
  final VoidCallback? onReplayStart; // NEW
  /// Called when user tap replay finishes successfully (unlock in parent)
  final VoidCallback? onReplayComplete; // was there already
  /// Called when replay fails to load/play (unlock in parent)
  final VoidCallback? onReplayError; // NEW

  @override
  State<GiftSvgaOnce> createState() => _GiftSvgaOnceState();
}

class _GiftSvgaOnceState extends State<GiftSvgaOnce>
    with SingleTickerProviderStateMixin {
  late final SVGAAnimationController _controller;
  bool _isPlaying = false;
  bool _hasPlayedOnce = false;
  bool _decodeTried = false; // avoid repeated failing decodes in one frame
  Object? _lastError; // debug/telemetry (optional)

  @override
  void initState() {
    super.initState();
    _controller = SVGAAnimationController(vsync: this);
    _loadAndMaybePlay(); // first render
  }

  Future<void> _ensureMovieLoaded() async {
    if (_controller.videoItem != null) return;
    if (_decodeTried) return;
    _decodeTried = true;
    try {
      // Optional: small timeout so it won't hang forever
      final movie = await SVGAParser.shared
          .decodeFromURL(widget.svgaUrl)
          .timeout(const Duration(seconds: 6));
      if (!mounted) return;
      _controller.videoItem = movie;
    } catch (e) {
      _lastError = e;
      // keep showing thumbnail; parent will be notified on play attempt
    }
  }

  Future<void> _autoPlayIfNeeded() async {
    if (!mounted) return;
    if (_hasPlayedOnce) return;
    if (!widget.autoPlayFirstTime) return;

    await _ensureMovieLoaded();
    if (_controller.videoItem == null) {
      // auto-play failed to load — just skip; keep thumb
      return;
    }

    setState(() => _isPlaying = true);
    _controller.value = 0;
    try {
      await _controller.forward();
      if (!mounted) return;
      setState(() {
        _isPlaying = false;
        _hasPlayedOnce = true;
      });
      widget.onFirstPlayComplete?.call();
    } catch (e) {
      _lastError = e;
      if (!mounted) return;
      setState(() => _isPlaying = false);
      // NEW: notify parent so it can unlock
      widget.onFirstPlayFailed?.call();
    }
  }

  Future<void> _loadAndMaybePlay() async {
    _decodeTried = false; // reset flag on new url
    await _ensureMovieLoaded();
    await _autoPlayIfNeeded();
  }

  Future<void> _replay() async {
    if (_isPlaying) return;
    if (widget.onTryPlay != null && !(await widget.onTryPlay!())) return;

    // announce start so parent sets lock + watchdog
    widget.onReplayStart?.call();

    try {
      await _ensureMovieLoaded();
      if (_controller.videoItem == null) {
        widget.onReplayError?.call(); // unlock on failure
        return;
      }
      if (!mounted) return;

      setState(() => _isPlaying = true);
      _controller.value = 0;
      await _controller.forward(from: 0);

      if (!mounted) return;
      setState(() => _isPlaying = false);
      widget.onReplayComplete?.call(); // unlock on success
    } catch (e) {
      _lastError = e;
      if (!mounted) return;
      setState(() => _isPlaying = false);
      widget.onReplayError?.call(); // unlock on error
    }
  }

  @override
  void didUpdateWidget(covariant GiftSvgaOnce old) {
    super.didUpdateWidget(old);

    // URL changed → reset and (maybe) play
    if (old.svgaUrl != widget.svgaUrl) {
      _hasPlayedOnce = false;
      _isPlaying = false;
      _controller.videoItem = null;
      _loadAndMaybePlay();
      return;
    }

    // same url, but now autoPlayFirstTime toggled to true (queue case)
    if (!old.autoPlayFirstTime && widget.autoPlayFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _autoPlayIfNeeded();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils.showLog(
        'widget.thumbnail url svga image ::::::   ${widget.thumbUrl}');
    final box = SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: _isPlaying
          ? SVGAImage(_controller)
          : GestureDetector(
              onTap: _replay,
              behavior: HitTestBehavior.opaque, // better hit box
              child: CachedNetworkImage(
                imageUrl: widget.thumbUrl,
                fit: BoxFit.cover,
              ),
            ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: box,
    );
  }
}
