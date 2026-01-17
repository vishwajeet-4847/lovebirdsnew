class VipPlanPrivilegeModel {
  final bool status;
  final String message;
  final VipPrivilegeData? data;

  VipPlanPrivilegeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VipPlanPrivilegeModel.fromJson(Map<String, dynamic> json) {
    return VipPlanPrivilegeModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null ? VipPrivilegeData.fromJson(json['data']) : null,
    );
  }
}

class VipPrivilegeData {
  final String id;
  final String vipFrameBadge;
  final int audioCallDiscount;
  final int videoCallDiscount;
  final int randomMatchCallDiscount;
  final int topUpCoinBonus;
  final int freeMessages;

  VipPrivilegeData({
    required this.id,
    required this.vipFrameBadge,
    required this.audioCallDiscount,
    required this.videoCallDiscount,
    required this.randomMatchCallDiscount,
    required this.topUpCoinBonus,
    required this.freeMessages,
  });

  factory VipPrivilegeData.fromJson(Map<String, dynamic> json) {
    return VipPrivilegeData(
      id: json['_id'] ?? '',
      vipFrameBadge: json['vipFrameBadge'] ?? '',
      audioCallDiscount: json['audioCallDiscount'] ?? 0,
      videoCallDiscount: json['videoCallDiscount'] ?? 0,
      randomMatchCallDiscount: json['randomMatchCallDiscount'] ?? 0,
      topUpCoinBonus: json['topUpCoinBonus'] ?? 0,
      freeMessages: json['freeMessages'] ?? 0,
    );
  }
}
