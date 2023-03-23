class PostModel {
  final int poId;
  final int poHeart;
  final String poTitle;
  final String poContent;
  final int poPrice;
  final String poImage01;
  final String poImage02;
  final String poImage03;
  final int poViews;
  final int poState;
  final int poUser;

  PostModel({
    required this.poId,
    required this.poHeart,
    required this.poTitle,
    required this.poContent,
    required this.poPrice,
    required this.poImage01,
    required this.poImage02,
    required this.poImage03,
    required this.poViews,
    required this.poState,
    required this.poUser,
  });

  PostModel.fromMap(Map<String, dynamic> res)
      : poId = res['poId'],
        poHeart = res['poHeart'],
        poTitle = res['poTitle'],
        poContent = res['poContent'],
        poPrice = res['poPrice'],
        poImage01 = res['poImage01'],
        poImage02 = res['poImage02'],
        poImage03 = res['poImage03'],
        poViews = res['poViews'],
        poState = res['poState'],
        poUser = res['poUser'];
}
