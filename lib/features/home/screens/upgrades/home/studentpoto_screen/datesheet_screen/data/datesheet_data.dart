import 'package:flutter/material.dart';

class DataSheet {
  final int date;
  final String monthName;
  final String subjectName;
  final String dayName;
  final String time;
  final String images;
  final Icon icon;

  DataSheet(this.date, this.monthName, this.subjectName, this.dayName,
      this.time, this.images, this.icon);
}

List<DataSheet> dateSheet = [
  DataSheet(11, 'JAN', 'Anna Makinda', 'Minutes ago', '9:00am',
      'assets/images1/makinda.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(12, 'JAN', 'Mwalimu Kichugu', 'Minutes ago', '10:00am',
      'assets/icons1/profile.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(13, 'JAN', 'John Ndugai', 'Minutes ago', '9:30am',
      'assets/images1/ndugai.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(14, 'JAN', 'Godwin Gondwe', 'Minutes ago', '11:00am',
      'assets/images1/gondwee.webp', const Icon(Icons.play_arrow_rounded)),
  DataSheet(15, 'JAN', 'Samia Suluhu Hassan', 'Minutes ago', '9:00am',
      'assets/images1/samia.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(16, 'JAN', 'Mwakiembe', 'Hours', '11:00am',
      'assets/images1/Mwakyembe.jpg', const Icon(Icons.play_arrow_rounded)),
];
List<DataSheet> dateSheet1 = [
  DataSheet(
      11,
      'JAN',
      'No student will fail this year...',
      'Minutes ago',
      '9:00am',
      'assets/images1/ndalichako2.jpg',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(12, 'JAN', 'The Unseen Life of A Teacher', 'Minutes ago', '10:00am',
      'assets/icons1/teacherlife.png', const Icon(Icons.play_arrow)),
  DataSheet(13, 'JAN', 'Visited schools in Dar es salaam', 'Minutes ago',
      '9:30am', 'assets/icons1/datasheet.ico', const Icon(Icons.document_scanner)),
  DataSheet(
      14,
      'JAN',
      'Visited schools in Dar es salaam',
      'Minutes ago',
      '9:30am',
      'assets/icons1/datasheet.ico',
      const Icon(Icons.document_scanner_sharp)),
  DataSheet(15, 'JAN', 'Visited schools in Dar es salaam', 'Minutes ago',
      '9:30am', 'assets/images1/ndalichako4.jpg', const Icon(Icons.audiotrack)),
  DataSheet(16, 'JAN', 'Visited schools in Dar es salaam', 'Minutes ago',
      '9:30am', 'assets/images1/ndalichako4.jpg', const Icon(Icons.audiotrack)),
  DataSheet(
      17,
      'JAN',
      'Visited schools in Dar es salaam',
      'Minutes ago',
      '9:30am',
      'assets/images1/ndalichako4.jpg',
      const Icon(Icons.play_arrow_rounded)),
];
List<DataSheet> dateSheet2 = [
  DataSheet(11, 'JAN', 'Mathematics', 'Minutes ago', '9:00am', '',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(12, 'JAN', 'Physics', 'Minutes ago', '10:00am', '',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(13, 'JAN', 'Biology', 'Minutes ago', '9:30am', '',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(14, 'JAN', 'Chemistry', 'Minutes ago', '11:00am', '',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(15, 'JAN', 'English', 'Minutes ago', '9:00am', '',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(16, 'JAN', 'Bible Study', 'Minutes ago', '11:00am', '',
      const Icon(Icons.play_arrow_rounded)),
];
List<DataSheet> dateSheet3 = [
  DataSheet(11, 'JAN', 'She is doing good for that', 'Minutes ago', '9:00am',
      'assets/images1/schoolboy.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'I like her she knows what she is doing',
      'Minutes ago',
      '10:00am',
      'assets/images1/schoolboyf1.jpg',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      13,
      'JAN',
      'Don\'t forget us youth mom we don\'t have a job',
      'Minutes ago',
      '9:30am',
      'assets/images1/teacher.jpg',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(14, 'JAN', 'I love her', 'Minutes ago', '11:00am',
      'assets/images1/student_profile.jpeg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(15, 'JAN', 'Salary is the problem', 'Minutes ago', '9:00am',
      'assets/images1/schoolgirl.webp', const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      16,
      'JAN',
      'Do us a favour mom we are teachers and we work in hard environment',
      'Minutes ago',
      '11:00am',
      'assets/images1/babyclass.jpg',
      const Icon(Icons.play_arrow_rounded)),
];

List<DataSheet> dateSheet4 = [
  DataSheet(11, 'JAN', 'Sn 01: Eps 06', 'Minutes ago', '9:00am',
      'assets/icons1/Tichapoto Button.png', const Icon(Icons.play_arrow_rounded)),
  DataSheet(12, 'JAN', 'Sn 01: Eps 05', 'Minutes ago', '10:00am',
      'assets/icons1/Tichapoto Button.png', const Icon(Icons.play_arrow_rounded)),
  DataSheet(13, 'JAN', 'Sn 01: Eps 04', 'Minutes ago', '9:30am',
      'assets/icons1/Tichapoto Button.png', const Icon(Icons.play_arrow_rounded)),
  DataSheet(14, 'JAN', 'Sn 01: Eps 03', 'Minutes ago', '11:00am',
      'assets/icons1/Tichapoto Button.png', const Icon(Icons.play_arrow_rounded)),
  DataSheet(15, 'JAN', 'Sn 01: Eps 02', 'Minutes ago', '9:00am',
      'assets/icons1/Tichapoto Button.png', const Icon(Icons.play_arrow_rounded)),
  DataSheet(16, 'JAN', 'Sn 01: Eps 01', 'Minutes ago', '11:00am',
      'assets/icons1/Tichapoto Button.png', const Icon(Icons.play_arrow_rounded)),
];
List<DataSheet> dateSheet5 = [
  DataSheet(11, 'JAN', 'Sn 1: Ep 07\n Kid dancing', 'Minutes ago', '9:00am',
      'assets/icons1/shikabamba1.png', const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Sn 1: Ep 06\n Kids doing yoga',
      'Minutes ago',
      '10:00am',
      'assets/icons1/shikabamba1.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Sn 1: Ep 05\n Kids doing yoga',
      'Minutes ago',
      '10:00am',
      'assets/icons1/shikabamba1.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Sn 1: Ep 04 \nKids doing yoga',
      'Minutes ago',
      '10:00am',
      'assets/icons1/shikabamba1.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Sn 1: Ep 03 \n Kids doing yoga',
      'Minutes ago',
      '10:00am',
      'assets/icons1/shikabamba1.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Sn 1: Ep 02\n Kids doing yoga',
      'Minutes ago',
      '10:00am',
      'assets/icons1/shikabamba1.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Sn 1: Ep 01\n Kids doing yoga',
      'Minutes ago',
      '10:00am',
      'assets/icons1/shikabamba1.png',
      const Icon(Icons.play_arrow_rounded)),
];

List<DataSheet> dateSheet6 = [
  DataSheet(11, 'JAN', 'Sn 01: Eps 06', 'Minutes ago', '9:00am',
      'assets/icons1/english club.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(12, 'JAN', 'Sn 01: Eps 05', 'Minutes ago', '10:00am',
      'assets/icons1/english club.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(13, 'JAN', 'Sn 01: Eps 04', 'Minutes ago', '9:30am',
      'assets/icons1/english club.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(14, 'JAN', 'Sn 01: Eps 03', 'Minutes ago', '11:00am',
      'assets/icons1/english club.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(15, 'JAN', 'Sn 01: Eps 02', 'Minutes ago', '9:00am',
      'assets/icons1/english club.jpg', const Icon(Icons.play_arrow_rounded)),
  DataSheet(16, 'JAN', 'Sn 01: Eps 01', 'Minutes ago', '11:00am',
      'assets/icons1/english club.jpg', const Icon(Icons.play_arrow_rounded)),
];

List<DataSheet> dateSheet7 = [
  DataSheet(
      11,
      'JAN',
      'Issue 04',
      'assets/icons1/issue1.jpg',
      'assets/icons1/datasheet.ico',
      'assets/icons1/deals1.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Issue 03',
      'assets/icons1/issue1.jpg',
      'assets/icons1/datasheet.ico',
      'assets/icons1/deals2.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Issue 02',
      'assets/icons1/issue1.jpg',
      'assets/icons1/datasheet.ico',
      'assets/icons1/deals2.png',
      const Icon(Icons.play_arrow_rounded)),
  DataSheet(
      12,
      'JAN',
      'Issue 01',
      'assets/icons1/issue1.jpg',
      'assets/icons1/datasheet.ico',
      'assets/icons1/deals2.png',
      const Icon(Icons.play_arrow_rounded)),
];

List<DataSheet> dateSheet8 = [
  DataSheet(11, 'JAN', 'Vol 01: Section 03', 'Hours ago', '9:00am',
      'assets/icons1/rabbit.jpg', const Icon(Icons.audiotrack)),
  DataSheet(12, 'JAN', 'Vol 01: Section 02', 'Yesterday', '10:00am',
      'assets/icons1/rabbit.jpg', const Icon(Icons.audiotrack)),
  DataSheet(13, 'JAN', 'Vol 01: Section 01', 'Two weeks ago', '9:30am',
      'assets/icons1/rabbit.jpg', const Icon(Icons.audiotrack)),
];

List<String> dateSheetString = [
  'Chair of Parliament',
  'Minister of Education and Ajira',
  'Member of Parliament',
  'Regional Commitioner',
  'Tanzania President',
  'Member of CCM',
];
List<String> jrCategory = [
  'Current Affairs',
  'My Shule',
  'The World of Twiga',
  'Zac and Zoe',
  'Character Education',
  'Personal Hygiene',
  'Reproductive Health',
  'Career Guidance',
  'Environmental Education',
  'Digital Literacy',
  'Financial Literacy',
  'National History',
  'STEM Projects',
  'Story tell',
];
List<String> srCategory = [
  'Current Affairs',
  'My Shule',
  'School Clubs',
  'Juma and Neema',
  'Character Education',
  'Personal Hygiene',
  'Reproductive Health',
  'Career Guidance',
  'Environmental Education',
  'Digital Literacy',
  'Financial Literacy',
  'National History',
  'STEM Projects',
];
List<String> pdfChaptres = [
  'Volume 01',
  'Minister of Education and Ajira',
  'Member of Parliament',
  'Regional Commitioner',
  'Tanzania President',
  'Member of CCM',
];
