import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  int? docId;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? selectedTime;
  String? category;

  Habit({
    this.docId,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.selectedTime,
    this.category,
  });

  // Habit.fromJson(Map<String, dynamic> json) {
  //   docId = json['id'];
  //   title = json['title'];
  //   note = json['note'];
  //   isCompleted = json['isCompleted'];
  //   date = json['date'];
  //   selectedTime = json['time'];
  //   category = json['category'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.docId;
  //   data['title'] = this.title;
  //   data['note'] = this.note;
  //   data['isCompleted'] = this.isCompleted;
  //   data['date'] = this.date;
  //   data['time'] = this.selectedTime;
  //   data['category'] = this.category;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': docId,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'time': selectedTime,
      'category': category,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      docId: map['id'] != null ? map['id'] : null,
      title: map['title'] as String,
      note: map['note'] as String,
      isCompleted: map['isCompleted'] as int,
      date: map['date'] as String,
      selectedTime: map['time'] as String,
      category: map['category'] as String,
    );
  }

  factory Habit.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Habit(
      docId: doc['id'],
      title: doc['title'],
      note: doc['note'],
      isCompleted: doc['isCompleted'],
      date: doc['date'],
      selectedTime: doc['time'],
      category: doc['category'],
    );
  }
}
