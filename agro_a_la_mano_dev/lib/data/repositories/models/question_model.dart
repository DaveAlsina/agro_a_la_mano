class QuestionModel {
  final String id;
  final String question;
  final String details;
  final String theme;
  final String picture;
  final dynamic answer;

  QuestionModel(
      {required this.id,
      required this.question,
      required this.details,
      required this.theme,
      required this.picture,
      required this.answer});
}
