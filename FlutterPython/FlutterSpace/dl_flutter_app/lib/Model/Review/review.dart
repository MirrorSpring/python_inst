class Review {
  final String reId;
  final String reText;
  final int reStarRating;
  final String toUserId;
  final String fromUserId1;

  String userName;
  String userPw;
  String userAddress;
  int userReliability;
  DateTime reInDate;

  Review({
    required this.reId,
    required this.reText,
    required this.reStarRating,
    required this.toUserId,
    required this.fromUserId1,
    required this.userName,
    required this.userPw,
    required this.userAddress,
    required this.userReliability,
    required this.reInDate,
  });

  // 생성자임
  // dart에서는 똑같은 생성자 만들 수 없다? 그래서 만든 거임
  // 뭐가 들어올지 몰라서 다이나믹
  Review.fromMap(Map<String, dynamic> res)
      : reId = res['reId'],
        reText = res['reText'],
        reStarRating = res['reStarRating'],
        toUserId = res['toUserId'],
        fromUserId1 = res['fromUserId1'],
        userName = res['userName'],
        userPw = res['userPw'],
        userAddress = res['userAddress'],
        userReliability = res['userReliability'],
        reInDate = res['reInDate'];

  // 뭐가 들어올지 몰라서 object
  Map<String, Object?> toMap() {
    return {
      'reId': reId,
      'reText': reText,
      'reStarRating': reStarRating,
      'toUserId': toUserId,
      'fromUserId1': fromUserId1,
      'userName': userName,
      'userPw': userPw,
      'userAddress': userAddress,
      'userReliability': userReliability,
      'reInDate': reInDate,
    };
  }
} //END
