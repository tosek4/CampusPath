class Exam {
  final String title;
  final String subject;
  final DateTime dateTime;
  final String location;
  final String locationName;

  Exam({
    required this.title,
    required this.subject,
    required this.dateTime,
    required this.location,
    required this.locationName,
  });
}

class ExamRepository {
  static final ExamRepository _instance = ExamRepository._internal();

  factory ExamRepository() => _instance;

  ExamRepository._internal();

  final List<Exam> _exams = [];

  List<Exam> get exams => _exams;

  void addExam(Exam exam) {
    _exams.add(exam);
  }

  void removeExam(Exam exam) {
    _exams.remove(exam);
  }
}
