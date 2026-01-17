class SocketEvents {
  static const String error = "error";
  static const String connectError = "connect_error";

  // ================= For Chat =================== //
  static const String messageSent = "chatMessageSent";
  static const String messageSeen = "chatMessageSeen";
  static const String chatGiftSent = "chatGiftSent";

  // ================= For Call =================== //
  static const String callRinging = "callRinging"; // Private Call

  static const String ringingStarted = "ringingStarted"; // Random Call
  static const String callConnected = "callConnected"; // callSender
  static const String callIncoming = "callIncoming"; // callReceiver
  static const String callResponseHandled = "callResponseHandled";
  static const String callRejected = "callRejected";
  static const String callAnswerReceived = "callAnswerReceived";
  static const String callCancelled = "callCancelled";
  static const String callFinished = "callFinished";
  static const String videoGiftSent = "videoGiftSent";
  static const String callDisconnected = "callDisconnected";
  static const String callCoinCharged = "callCoinCharged";
  static const String insufficientCoins = "insufficientCoins";
  static const String callAutoEnded = "callAutoEnded";
  static const String callCoinChargedForFakeCall =
      "callCoinChargedForFakeCall"; // Fake call

  // ================= For Live Streaming =================== //
  static const String liveRoomJoin = "liveRoomJoin";
  static const String liveJoinerCount = "liveJoinerCount";
  static const String removeLiveJoiner = "removeLiveJoiner";
  static const String liveCommentBroadcast = "liveCommentBroadcast";
  static const String liveGiftSent = "liveGiftSent";
  static const String liveGiftReceived = "liveGiftReceived";
  static const String liveStreamEnd = "liveStreamEnd";
  static const String liveStreamStatusCheck = "liveStreamStatusCheck";
}
