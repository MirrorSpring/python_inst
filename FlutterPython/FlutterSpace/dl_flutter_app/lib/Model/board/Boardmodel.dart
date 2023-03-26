class Board {
  final int poId;
  final int poHeart;
  final String poTitle;
  final String poContent;
  final String poPrice;
  final String poImage01;
  // final String poImage02;
  final String poInstrument;
  final int poViews;
  final int poState;
  // final DateTime poUpDate;
  // final DateTime timeonly;
  // ignore: non_constant_identifier_names
  final String u_userId;
  final String poUser;
  final String userAddress;
  final int userReliability;

  Board(
      {required this.poId,
      required this.poHeart,
      required this.poTitle,
      required this.poContent,
      required this.poPrice,
      required this.poImage01,
      // required this.poImage02,
      required this.poInstrument,
      required this.poViews,
      required this.poState,
      // required this.poUpDate,
      // required this.timeonly,
      required this.u_userId,
      required this.poUser,
      required this.userAddress,
      required this.userReliability});

  Board.fromMap(Map<String, dynamic> res)
      : poId = res['poId'],
        poHeart = res['poHeart'],
        poTitle = res['poTitle'],
        poContent = res['poContent'],
        poPrice = res['poPrice'],
        poImage01 = res['poImage01'],
        poInstrument = res['poInstrument'],
        poViews = res['poViews'],
        poState = res['poState'],
        u_userId = res['u_userId'],
        poUser = res['poUser'],
        userAddress = res['userAddress'],
        userReliability = res['userReliability'];

  Map<String, Object?> toMap() {
    return {
      'poId': poId,
      'poHeart': poHeart,
      'poTitle': poTitle,
      'poContent': poContent,
      'poPrice': poPrice,
      'poImage01': poImage01,
      'poInstrument': poInstrument,
      'poViews': poViews,
      'poState': poState,
      'u_userId': u_userId,
      'poUser': poUser,
      'userAddress': userAddress,
      'userReliability': userReliability
    };
  }
}
