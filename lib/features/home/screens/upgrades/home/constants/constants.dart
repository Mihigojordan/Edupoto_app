import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//colors
const Color kPrimaryColor = Color(0xFFEC407A);
const Color kSecondaryColor = Color(0xFFF48FB1);
const Color kpink100Color = Color(0xFFF8BBD0);
const Color kpinkAccent100Color = Color(0xFFFF80AB);
const Color kcyan50Color = Color(0xFFE0F7FA);
const Color kcyan100Color = Color(0xFFB2EBF2);
const Color kcyan200Color = Color(0xFF80DEEA);
const Color kcyanColor = Color(0xFF00BCD4);
const Color kblue200Color = Color(0xFF90CAF9);
const Color kblue300Color = Color(0xFF64B5F6);
const Color kblue100Color = Color(0xFFBBDEFB);
const Color kblue50Color = Color(0xFFE2F1FD);
 Color kTextBlackColor = const Color(0xFF313131);
const Color kTextSblackColor = Color(0xF0000000);
const Color kgrey900Color = Color(0xFF212121);
const Color kgrey800Color = Color(0xFF424242);
const Color kBlueGrey900Color = Color(0xFF263238);
const Color kBlueGrey800Color = Color(0xFF37474F);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);
const Color kyellowColor = Color(0xFFFFEB3B);
const Color kyellow800Color = Color(0xFFF8A900);
const Color kamber300Color = Color(0xFFFFD54F);
const Color korangeColor = Color(0xFFFF5722);
const Color korange400Color = Color(0xFFFF7043);
const Color korange300Color = Color(0xFFFF8A65);
const Color korange200Color = Color(0xFFFFAB91);
const Color korange100Color = Color(0xFFFFCCBC);

 const List<Map<String, String>> messages = [
    {
      'title': 'Assignment Submission Reminder',
      'message': 'Please ensure all students submit their assignments by Friday.',
    },
    {
      'title': 'School Closure Notice',
      'message': 'The school will be closed next Monday for maintenance.',
    },
    {
      'title': 'Parent-Teacher Meetings',
      'message': 'Parent-teacher meetings are scheduled for next week.',
    },
    {
      'title': 'Sports Day Reminder',
      'message': 'Reminder: School sports day is on the 25th of this month.',
    },
    {
      'title': 'Timetable Update',
      'message': 'Please check the updated timetable on the school portal.',
    },
    {
      'title': 'Library Renovation Notice',
      'message': 'The library will be closed for renovation next week.',
    },
    {
      'title': 'Science Project Reminder',
      'message': 'Students are required to bring their science projects tomorrow.',
    },
    {
      'title': 'Annual School Festival',
      'message': 'The annual school festival is coming up. Stay tuned for updates!',
    },
    {
      'title': 'PE Kit Reminder',
      'message': 'Please ensure your child brings their PE kit every Monday.',
    },
    {
      'title': 'Canteen Closure Notice',
      'message': 'The school canteen will be closed for cleaning this Friday.',
    },
    {
      'title': 'School Photos Reminder',
      'message': 'Reminder: School photos will be taken next Wednesday.',
    },
    {
      'title': 'Bus Schedule Update',
      'message': 'The school bus schedule has been updated. Please check the notice board.',
    },
    {
      'title': 'Uniform Requirement',
      'message': 'Students must wear their school uniform for the upcoming event.',
    },
    {
      'title': 'Career Guidance Session',
      'message': 'The school will host a career guidance session next month.',
    },
    {
      'title': 'Math Extra Classes',
      'message': 'Please ensure your child attends the extra classes for math.',
    },
    {
      'title': 'Field Trip Announcement',
      'message': 'The school will be organizing a field trip next week.',
    },
    {
      'title': 'Consent Forms Reminder',
      'message': 'Reminder: Submit the consent forms for the upcoming trip.',
    },
    {
      'title': 'Fire Safety Drill',
      'message': 'The school will be conducting fire safety drills tomorrow.',
    },
    {
      'title': 'Art Supplies Reminder',
      'message': 'Please ensure your child brings their art supplies for the workshop.',
    },
    {
      'title': 'Holiday Closure Notice',
      'message': 'The school will be closed for the holidays starting next week.',
    },
  ];

 const List<Map<String, dynamic>> reports = [
    {
      'title': 'Term 1 Report Card',
      'description': 'Academic performance report for Term 1.',
      'date': 'October 10, 2023',
      'fileUrl': 'https://example.com/reports/term1.pdf', // Replace with actual URL
    },
    {
      'title': 'Tuition Fee Receipt',
      'description': 'Receipt for tuition fee payment.',
      'date': 'October 5, 2023',
      'fileUrl': 'https://example.com/receipts/tuition.pdf', // Replace with actual URL
    },
    {
      'title': 'Sports Day Participation Certificate',
      'description': 'Certificate for participating in the Annual Sports Day.',
      'date': 'September 28, 2023',
      'fileUrl': 'https://example.com/certificates/sports.pdf', // Replace with actual URL
    },
    {
      'title': 'Library Fee Receipt',
      'description': 'Receipt for library fee payment.',
      'date': 'September 25, 2023',
      'fileUrl': 'https://example.com/receipts/library.pdf', // Replace with actual URL
    },
    {
      'title': 'Field Trip Permission Slip',
      'description': 'Permission slip for the upcoming field trip.',
      'date': 'September 20, 2023',
      'fileUrl': 'https://example.com/forms/field_trip.pdf', // Replace with actual URL
    },
  ];


  const List<Map<String, dynamic>> requirements =[
    {
      'title': 'Tuition Fees',
      'description': 'Payment for the current term.',
      'amount': 150000.00, // In Rwandan Francs (RWF)
    },
    {
      'title': 'School Uniform',
      'description': 'Purchase of new school uniform.',
      'amount': 25000.00,
    },
    {
      'title': 'Library Fees',
      'description': 'Annual library subscription fee.',
      'amount': 5000.00,
    },
    {
      'title': 'Sports Equipment',
      'description': 'Contribution for sports equipment.',
      'amount': 10000.00,
    },
    {
      'title': 'Field Trip',
      'description': 'Payment for the upcoming field trip.',
      'amount': 20000.00,
    },
    {
      'title': 'Exam Fees',
      'description': 'Fees for end-of-term exams.',
      'amount': 10000.00,
    },
    {
      'title': 'Art Supplies',
      'description': 'Purchase of art materials.',
      'amount': 5000.00,
    },
    {
      'title': 'School Bus Fees',
      'description': 'Monthly bus transportation fee.',
      'amount': 15000.00,
    },
    {
      'title': 'Lunch Program',
      'description': 'Monthly fee for the school lunch program.',
      'amount': 20000.00,
    },
    {
      'title': 'Science Lab Fees',
      'description': 'Contribution for lab materials.',
      'amount': 10000.00,
    },
    {
      'title': 'ICT Fees',
      'description': 'Fees for computer lab and ICT resources.',
      'amount': 10000.00,
    },
    {
      'title': 'Music Program',
      'description': 'Fees for music classes and instruments.',
      'amount': 15000.00,
    },
    {
      'title': 'School Development Fund',
      'description': 'Contribution for school infrastructure development.',
      'amount': 5000.00,
    },
    {
      'title': 'Health Insurance',
      'description': 'Annual health insurance fee for students.',
      'amount': 10000.00,
    },
    {
      'title': 'Textbooks',
      'description': 'Purchase of required textbooks.',
      'amount': 30000.00,
    },
    {
      'title': 'School Magazine',
      'description': 'Annual subscription for the school magazine.',
      'amount': 5000.00,
    },
    {
      'title': 'Graduation Fees',
      'description': 'Fees for graduation ceremony and gown.',
      'amount': 20000.00,
    },
    {
      'title': 'Cultural Day',
      'description': 'Contribution for cultural day activities.',
      'amount': 5000.00,
    },
    {
      'title': 'School ID Card',
      'description': 'Fee for student ID card.',
      'amount': 2000.00,
    },
    {
      'title': 'Parent-Teacher Association Fee',
      'description': 'Annual fee for PTA membership.',
      'amount': 5000.00,
    },
  ];

const List<Map<String, dynamic>> newsArticles =  [
    {
      'title': 'Annual Sports Day 2023',
      'date': 'October 10, 2023',
      'description': 'Join us for the Annual Sports Day on October 20th. Exciting events and prizes await!',
      'image': 'assets/image/sports_day.jpg', // Replace with actual image path
    },
    {
      'title': 'New Library Opening',
      'date': 'October 5, 2023',
      'description': 'Our new state-of-the-art library is now open for students. Explore a world of knowledge!',
      'image': 'assets/image/library.jpg', // Replace with actual image path
    },
    {
      'title': 'Parent-Teacher Meeting',
      'date': 'October 3, 2023',
      'description': 'The next parent-teacher meeting is scheduled for October 15th. Please confirm your attendance.',
      'image': 'assets/image/meeting.jpg', // Replace with actual image path
    },
    {
      'title': 'School Trip to the Museum',
      'date': 'September 28, 2023',
      'description': 'Students will visit the National Museum on October 12th. Consent forms must be submitted by October 5th.',
      'image': 'assets/image/museum.jpeg', // Replace with actual image path
    },
    {
      'title': 'Science Fair Winners',
      'date': 'September 25, 2023',
      'description': 'Congratulations to our students who won top prizes at the regional science fair!',
      'image': 'assets/image/science_fair.jpg', // Replace with actual image path
    },
  ];

const List<String> districtList = [
  "NYARUGENGE",
  "GASABO",
  "KICUKIRO",
  "NYANZA",
  "GISAGARA",
  "NYARUGURU",
  "HUYE",
  "NYAMAGABE",
  "RUHANGO",
  "MUHANGA",
  "KAMONYI",
  "KARONGI",
  "RUTSIRO",
  "RUBAVU",
  "NYABIHU",
  "NGORORERO",
  "RUSIZI",
  "NYAMASHEKE",
  "RULINDO",
  "GAKENKE",
  "MUSANZE",
  "BURERA",
  "GICUMBI",
  "RWAMAGANA",
  "NYAGATARE",
  "GATSIBO",
  "KAYONZA",
  "KIREHE",
  "NGOMA",
  "BUGESERA"
];

const productValueList = [
{"name":"Products","action":"ClassKit Voucher"},
{"name":"Birashoboka Edubox Contents","action":"ClassKit Voucher"},
{"name":"ShoeSize","action":"Shoebox Voucher"},
{"name":"Uniform","action":"Uniform Voucher"}
];

const participantLists = <Map<dynamic,String>>[
    {"code": "310504", "name": "GS ST MICHEL DE MUBUGA"},
    {"code": "110206", "name": "TVET KANYINYA"},
    {"code": "110502", "name": "COLLEGE DE BUTAMWA"},
    {"code": "110803", "name": "COLLEGE SAINT ANDRE"},
    {"code": "110912", "name": "LYCEE DE KIGALI"},
    {"code": "110913", "name": "LYCEE NOTRE-DAME DE CITEAUX"},
    {"code": "120101", "name": "ES BUMBOGO"},
    {"code": "120423", "name": "FAWE GIRLS SCHOOL"},
    {"code": "120524", "name": "FOREVER TVET SCHOOL"},
    {"code": "121106", "name": "INTERNATIONAL TECHNICAL SCHOOL OF KIGALI"},
    {"code": "130222", "name": "DON BOSCO TECHNICAL SCHOOL"},
    {"code": "130405", "name": "KAGARAMA S S"},
    {"code": "130606", "name": "LYCEE DE KICUKIRO APADE"},
    {"code": "131003", "name": "ESSA NYARUGUNGA"},
    {"code": "131022", "name": "ES KANOMBE /EFOTEC"},
    {"code": "130906", "name": "IPRC TSS/ KIGALI"},
    {"code": "210103", "name": "COLLEGE DU CHRIST-ROI"},
    {"code": "210104", "name": "COLLEGE MARANATHA"},
    {"code": "210105", "name": "HANIKA ANGLICAN INTEGRATED POLYTECHNIC (HAIP)"},
    {"code": "210106", "name": "E S DU SAINT-ESPRIT DE NYANZA"},
    {"code": "210108", "name": "E.SC.L.M.NYANZA"},
    {"code": "210111", "name": "ESPANYA"},
    {"code": "210112", "name": "G.S.MATER DEI"},
    {"code": "210117", "name": "IGIHOZO ST PETER"},
    {"code": "210128", "name": "KAVUMU TVET SCHOOL"},
    {"code": "210129", "name": "BUSASAMANA TSS"},
    {"code": "210201", "name": "COLLEGE MONT SION APADEM"},
    {"code": "210503", "name": "SAINTE TRINITE NYANZA TVET SCHOOL"},
    {"code": "210511", "name": "NYANZA TSS"},
    {"code": "210512", "name": "INGENZI TRINITY SCHOOL"},
    {"code": "210605", "name": "LYCEE DE NYANZA"},
    {"code": "210614", "name": "HVP GATAGARA TVET SCHOOL"},
    {"code": "210618", "name": "NYANZA HILLS ACADEMY"},
    {"code": "210702", "name": "EAV MAYAGA"},
    {"code": "220102", "name": "E.S GIKONKO"},
    {"code": "220108", "name": "GIKONKO TVET SCHOOL"},
    {"code": "220301", "name": "COLLEGE ST BERNARD KANSI"},
    {"code": "220306", "name": "G.S ST FRANCOIS D"},
    {"code": "220312", "name": "COLLEGE ST JOSEPH DE KANSI"},
    {"code": "221005", "name": "MUSHA ADVENTIST TVET SCHOOL"},
    {"code": "221104", "name": "G.S ST PHILIPPE NERI DE GISAGARA"},
    {"code": "221303", "name": "ST KIZITO SAVE TVET SCHOOL"},
    {"code": "221304", "name": "G.S STE BERNADETTE SAVE"},
    {"code": "221311", "name": "TTC SAVE"},
    {"code": "230107", "name": "G.S RUNYOMBYI I"},
    {"code": "230207", "name": "TTC SAINT JEAN BAPTISTE CYAHINDA"},
    {"code": "230302", "name": "COLLEGE IMANZI"},
    {"code": "230312", "name": "G.S.M.VERBE KIBEHO"},
    {"code": "230313", "name": "GROUPE SCOLAIRE MARIE MERCI KIBEHO"},
    {"code": "230317", "name": "KIBEHO TSS"},
    {"code": "230507", "name": "NYAMYUMBA SECONDARY SCHOOL"},
    {"code": "230603", "name": "TVET MUTOVU"},
    {"code": "230606", "name": "GS BIGUGU"},
    {"code": "231105", "name": "NYAGISOZI TSS"},
    {"code": "231307", "name": "G.S.BTR.RWAMIKO"},
    {"code": "240405", "name": "ECOLE SECONDAIRE MBOGO"},
    {"code": "240512", "name": "LYCEE DE RUSATIRA"},
    {"code": "240714", "name": "ES MUTUNDA"},
    {"code": "240903", "name": "CJSM NGOMA"},
    {"code": "240912", "name": "G.SC.GATAGARA"},
    {"code": "240913", "name": "GS DES PARENTS"},
    {"code": "240924", "name": "RWABUYE TSS"},
    {"code": "240943", "name": "KABUTARE TSS"},
    {"code": "240947", "name": "PETIT SEMINAIRE BAPTISTE"},
    {"code": "240948", "name": "ENDP KARUBANDA"},
    {"code": "240949", "name": "MSGR FELICIEN MUBILIGI CATHOLIC TSS"},
    {"code": "240950", "name": "G.S.O BUTARE"},
    {"code": "240952", "name": "IPRC HUYE"},
    {"code": "241110", "name": "SAINT MARY'S HIGH SCHOOL KIRUHURA"},
    {"code": "241303", "name": "E.S.SAINT JEAN BOSCO SIMBI"},
    {"code": "250103", "name": "E.S BISHYIGA"},
    {"code": "250206", "name": "GSNDP CYANIKA"},
    {"code": "250302", "name": "DON BOSCO NTSS"},
    {"code": "250303", "name": "E.S SUMBA"},
    {"code": "250307", "name": "ESC NYAMAGABE"},
    {"code": "250312", "name": "GS KIGEME A"},
    {"code": "250506", "name": "ES.KADUHA"},
    {"code": "250507", "name": "GS.KADUHA"},
    {"code": "251406", "name": "ES MUSHUBI"},
    {"code": "251601", "name": "E.S MUDASOMWA"},
    {"code": "251708", "name": "TTC MBUGA"},
    {"code": "260103", "name": "ES MURAMA"},
    {"code": "260104", "name": "ESAPAG"},
    {"code": "260115", "name": "GITISI TVET SCHOOL"},
    {"code": "260201", "name": "ES MUKINGI"},
    {"code": "260202", "name": "ECOLE DES SCIENCES BYIMANA"},
    {"code": "260204", "name": "GSNDL BYIMANA"},
    {"code": "260215", "name": "MPANDA TSS"},
    {"code": "260301", "name": "COLLEGE KARAMBI"},
    {"code": "260311", "name": "ST JOSEPH TSS NZUKI"},
    {"code": "260402", "name": "ES KINAZI"},
    {"code": "260413", "name": "KINAZI TSS A"},
    {"code": "260608", "name": "VUNGA TVET"},
    {"code": "260903", "name": "COLLEGE DE BETHEL"},
    {"code": "260904", "name": "ES KIGOMA"},
    {"code": "260905", "name": "ES RUHANGO"},
    {"code": "260906", "name": "ES SAINT TRINITE"},
    {"code": "260907", "name": "E T SAINTE TRINITE/TSS"},
    {"code": "260909", "name": "GS INDANGABUREZI"},
    {"code": "260925", "name": "LYCEE DE RUHANGO"},
    {"code": "270113", "name": "ITER RUTOBWE"},
    {"code": "270120", "name": "HAIP/SHYOGWE TVET SCHOOL"},
    {"code": "270303", "name": "ES NYAKABANDA"},
    {"code": "270315", "name": "TSS SAINT SYLVAN KIBANGU"},
    {"code": "270403", "name": "NYABIKENKE TVET SCHOOL"},
    {"code": "270414", "name": "KIYUMBA TVET SCHOOL"},
    {"code": "270501", "name": "ACEJ KARAMA"},
    {"code": "270601", "name": "ACODES MUSHISHIRO"},
    {"code": "270605", "name": "BULINGA TVET SCHOOL"},
    {"code": "270811", "name": "G.S.ST JOSEPH"},
    {"code": "270858", "name": "RWANDA SCHOOL OF CREATIVE ARTS AND MUSIC"},
    {"code": "271002", "name": "CNDC/NTARABANA"},
    {"code": "271204", "name": "G.S.SHYOGWE"},
    {"code": "271211", "name": "ST PETER COLLEGE"},
    {"code": "271213", "name": "TTC MUHANGA"},
    {"code": "271215", "name": "JAM FRED NKUNDA TVET SCHOOL"},
    {"code": "280312", "name": "KAYENZI TVET SCHOOL"},
    {"code": "280403", "name": "ES RUTOBWE"},
    {"code": "280512", "name": "SAINT IGNACE TSS"},
    {"code": "280705", "name": "FR RAMON KABUGA TSS"},
    {"code": "281101", "name": "COLLEGE APPEC"},
    {"code": "281109", "name": "GS REMERA RUKOMA"},
    {"code": "281203", "name": "ES MARIE ADELAIDE"},
    {"code": "281218", "name": "RUNDA TVET SCHOOL"},
    {"code": "310101", "name": "COLLEGE STE MARIE KIBUYE"},
    {"code": "310127", "name": "IPRC KARONGI TSS"},
    {"code": "310203", "name": "ECOLE SEC DELASSOMPTION DE BIRAMBO"},
    {"code": "310204", "name": "ES URUMURI"},
    {"code": "310208", "name": "GS SAINT JOSEPH BIRAMBO"},
    {"code": "310214", "name": "SAINT JOSEPH BIRAMBO TVET SCHOOL"},
    {"code": "310301", "name": "ES BISESERO"},
    {"code": "310501", "name": "ES MUBUGA"},
    {"code": "310604", "name": "ES KIRINDA"},
    {"code": "310621", "name": "IPK KIRINDA"},
    {"code": "310714", "name": "ES MUNZANGA"},
    {"code": "310802", "name": "ES GASENYI"},
    {"code": "310901", "name": "ES RUBENGERA"},
    {"code": "310922", "name": "TTC RUBENGERA"},
    {"code": "310925", "name": "RUBENGERA II TSS"},
    {"code": "310931", "name": "IPESAR TSS RUBENGERA"},
    {"code": "311020", "name": "ES RUGABANO"},
    {"code": "311326", "name": "GS GISOVU"},
    {"code": "320108", "name": "COLLEGE INDASHYIKIRWA"},
    {"code": "320202", "name": "COLLEGE DE LA PAIX"},
    {"code": "320303", "name": "ES CYIMBIRI"},
    {"code": "320701", "name": "ES MURUNDA"},
    {"code": "320901", "name": "ES APAKAPE"},
    {"code": "321002", "name": "GS BUMBA"},
    {"code": "321012", "name": "BUMBA TVET SCHOOL"},
    {"code": "321110", "name": "ES NYABIRASI"},
    {"code": "330204", "name": "GS SAINT MATHIEU DE BUSASAMANA"},
    {"code": "330409", "name": "ECOLE DES SCIENCES DE GISENYI"},
    {"code": "330411", "name": "ENP/TTC/GACUBA II"},
    {"code": "330415", "name": "ESTG/ GISENYI"},
    {"code": "330503", "name": "CSW/APEFOC"},
    {"code": "330601", "name": "G.S MUTURA I"},
    {"code": "331002", "name": "ECOLE D ART DE NYUNDO"},
    {"code": "331003", "name": "G.S NDA NYUNDO"},
    {"code": "331204", "name": "COLLEGE DE GISENYI INYEMERAMIHIGO"},
    {"code": "340105", "name": "BIGOGWE TSS"},
    {"code": "340301", "name": "CBK/ KABAYA"},
    {"code": "340601", "name": "ECOLE DES LETTRES DE GATOVU"},
    {"code": "340717", "name": "COLLEGE APARPE"},
    {"code": "340722", "name": "RWANDA CODING ACADEMY"},
    {"code": "340903", "name": "KIBISABO TVET SCHOOL"},
    {"code": "340904", "name": "KIBIHEKANE TVET SCHOOL"},
    {"code": "340905", "name": "G.S RAMBURA (F)"},
    {"code": "340906", "name": "G.S RAMBURA (G)"},
    {"code": "350201", "name": "COLLEGE ADEC RUHANGA"},
    {"code": "350211", "name": "ES MUHORORO"},
    {"code": "350216", "name": "ETO GATUMBA TSS"},
    {"code": "350309", "name": "CHARLES LWANGA TSS"},
    {"code": "350502", "name": "COL AMIZERO"},
    {"code": "350707", "name": "C.I.C. NDUBA"},
    {"code": "350901", "name": "ES NYABISINDU"},
    {"code": "350904", "name": "G.S MUBUGANGALI"},
    {"code": "350906", "name": "GS GISHOMA"},
    {"code": "351002", "name": "COLLEGE DE LA PAIX KAMEMBE"},
    {"code": "351010", "name": "TTC MURURU"},
    {"code": "351011", "name": "TTC MURURU (TVET SCHOOL)"},
    {"code": "351102", "name": "ESSA NYAMASHEKE"},
    {"code": "351103", "name": "TTC/NYAMASHEKE"},
    {"code": "351104", "name": "E S GIHUNDWE"},
    {"code": "351110", "name": "ECOLE DE SCIENCES DE GIHUNDWE"},
    {"code": "351402", "name": "TTC MURURU"},
    {"code": "360105", "name": "COLLEGE SAINTE BERNADETTE DE SHANGI"},
    {"code": "360110", "name": "COLLEGE ADVENTISTE DE NGOMA"},
    {"code": "360202", "name": "APRODECI NYAMYUMBA"},
    {"code": "360205", "name": "ETO SAINT PIERRE DE KIRAMBO"},
    {"code": "360301", "name": "LYCEE DE NYANGE"},
    {"code": "360305", "name": "G.S.NTARAMA"},
    {"code": "360311", "name": "VTC NYANGE"},
    {"code": "360509", "name": "ES MATABA"},
    {"code": "360701", "name": "ES NKOMBO"},
    {"code": "360804", "name": "ES KAMIMBWE"},
    {"code": "360901", "name": "TTC SAINTE THERESE"},
    {"code": "360905", "name": "COLLEGE SAINT BERNARD NYAMAGABE"},
    {"code": "361108", "name": "ES SHANGI"},
    {"code": "361202", "name": "COLLEGE SAINTE MARIE REINA NYAMASHEKE"},
    {"code": "361304", "name": "E T SAINTE THERESE/TSS"},
    {"code": "410209", "name": "ES MWOGO"},
    {"code": "410310", "name": "ES NYARUGUNGA"},
    {"code": "420103", "name": "E.S.NYAMIRAMA"},
    {"code": "420107", "name": "GS SAINT DOMINIQUE"},
    {"code": "420208", "name": "RWIMBOGO ACADEMY"},
    {"code": "420302", "name": "GS ST PIERRE ZAZA"},
    {"code": "420403", "name": "ES MUHANGA"},
    {"code": "420601", "name": "E.S.H. MWANGANDE"},
    {"code": "420707", "name": "ES SUNDURA"},
    {"code": "420709", "name": "GS KIBANGU"},
    {"code": "420710", "name": "G.S. NYARUGENGE"},
    {"code": "420805", "name": "COLLEGE DE L'ESPOIR"},
    {"code": "421201", "name": "COLLEGE GITWE"},
    {"code": "430102", "name": "G.S NTAMBA"},
    {"code": "430106", "name": "GS KANGALI"},
    {"code": "430107", "name": "E.S KIGARAMA"},
    {"code": "430208", "name": "ES MUHIMA"},
    {"code": "430220", "name": "E.S MAHINDU"},
    {"code": "430306", "name": "GS NDORABIKENE"},
    {"code": "440115", "name": "E.S KIBUNGO"},
    {"code": "440211", "name": "GS KADUHA"},
    {"code": "440305", "name": "ES MAGANA"},
    {"code": "440315", "name": "G.S NYABIKORE"},
    {"code": "440402", "name": "E.S KABIRIZI"},
    {"code": "440703", "name": "ES KANYONZA"},
    {"code": "440906", "name": "GS RAMBURA"},
    {"code": "440913", "name": "GS KIGABIRO"},
    {"code": "440914", "name": "GS MURAMBI"},
    {"code": "441001", "name": "G.S MARIA KIBUNGO"},
    {"code": "441007", "name": "GS ST ANTOINE KABUGA"},
    {"code": "441008", "name": "G.S ST ANTOINE NYAMIRAMA"},
    {"code": "441209", "name": "E.S GIKONGORO"},
    {"code": "441210", "name": "G.S MUBUNGA"},
    {"code": "441309", "name": "GS BUNYENZI"},
    {"code": "450103", "name": "E.S KAMBUKUBWA"},
    {"code": "450202", "name": "E.S.A/ KIGARAMA"},
    {"code": "450306", "name": "ES GITAGATANGA"},
    {"code": "450509", "name": "GS MUGANZO"},
    {"code": "450511", "name": "GS BUREGA"},
    {"code": "450707", "name": "GS ST MARIE DE LA PAIX"},
    {"code": "450802", "name": "GS ST PAUL KIGARAMA"},
    {"code": "450901", "name": "GS NTWALI"},
    {"code": "450903", "name": "G.S.MUZAZI"},
    {"code": "460204", "name": "E.S KINIGI"},
    {"code": "460303", "name": "GS GITARAMA"},
    {"code": "460502", "name": "ES KABUYE"},
    {"code": "460503", "name": "E.S BUKOBA"},
    {"code": "460703", "name": "GS ST LUKE GISOZI"},
    {"code": "460707", "name": "GS KIRARI"},
    {"code": "460804", "name": "E.S BIRYOGO"},
    {"code": "460805", "name": "GS HORIZON"},
    {"code": "470101", "name": "G.S KABUGA"},
    {"code": "470204", "name": "E.S.N MUMENYI"},
    {"code": "470307", "name": "E.S KIBUNGO"},
    {"code": "470503", "name": "ES RUGEMBANA"},
    {"code": "470602", "name": "GS KIVU"},
    {"code": "470604", "name": "G.S ST ANDRE MWANGAZA"},
    {"code": "470708", "name": "GS MURUNDI"},
    {"code": "470904", "name": "E.S NTOBO"},
    {"code": "471104", "name": "G.S RUHANGO"},
    {"code": "471201", "name": "G.S.RUKOMBA"},
    {"code": "471302", "name": "G.S KABUGA"},
    {"code": "471304", "name": "G.S KIGALI"},
    {"code": "480201", "name": "G.S RUGENZI"},
    {"code": "480205", "name": "GS KINYINYA"},
    {"code": "480215", "name": "G.S ST LUC DE GATETE"},
    {"code": "480303", "name": "GS KIRAMBO"},
    {"code": "480405", "name": "ES KIRAMBO"},
    {"code": "480511", "name": "G.S. TEBE"},
    {"code": "480705", "name": "GS NYABIKONI"},
    {"code": "490105", "name": "GS GIKUNDIRE"},
    {"code": "490207", "name": "GS NYABICUCHE"},
    {"code": "490304", "name": "G.S. NYAMIRAMA"},
    {"code": "490405", "name": "E.S NAMA"},
    {"code": "490503", "name": "G.S ST MARTIN GAKENKE"},
    {"code": "490705", "name": "G.S. KANYAMISHYA"},
    {"code": "490906", "name": "GS ST LUC NIRAGIRE"},
    {"code": "490907", "name": "G.S. TWESE NIRAGIRE"},
    {"code": "500102", "name": "E.S MURASIGARA"},
    {"code": "500204", "name": "GS GITARAGA"},
    {"code": "500502", "name": "G.S.MUNIGA"},
    {"code": "500804", "name": "GS MUGANDI"},
    {"code": "510204", "name": "GS KATABI"},
    {"code": "510302", "name": "E.S ST MARY NAKIMU"},
    {"code": "510303", "name": "G.S NYAGIHANGI"},
    {"code": "510405", "name": "E.S KAGUMBA"},
    {"code": "510503", "name": "GS JACQUELINE NIBANDE"},
    {"code": "510507", "name": "GS DUMASI"},
    {"code": "510709", "name": "GS MUNIGA"},
    {"code": "520108", "name": "G.S KAMERE"},
    {"code": "520206", "name": "GS KIRUHURA"},
    {"code": "520304", "name": "G.S KAGABO"},
    {"code": "520305", "name": "G.S MAHINDU"},
    {"code": "520401", "name": "E.S KIVUMBI"},
    {"code": "520404", "name": "G.S NYARUSANGE"},
    {"code": "520509", "name": "GS TUNDURA"},
    {"code": "520705", "name": "G.S MUHOGO"},
    {"code": "520807", "name": "GS RWANDA"},
    {"code": "520809", "name": "GS NYAMASHEKE"},
    {"code": "530206", "name": "G.S KABURANDE"},
    {"code": "530303", "name": "E.S KANYINYA"},
    {"code": "530507", "name": "GS NYAMANA"},
    {"code": "530511", "name": "GS MAJIGA"},
    {"code": "530513", "name": "G.S MATISSI"},
    {"code": "530805", "name": "G.S RUGAZI"},
    {"code": "540102", "name": "E.S ST ANTOINE"},
    {"code": "540202", "name": "E.S ST PAUL KIMIHURURA"},
    {"code": "540305", "name": "G.S MUYUMBA"},
    {"code": "540408", "name": "G.S MUHANGA"},
    {"code": "540507", "name": "GS MUKAMANA"},
    {"code": "540605", "name": "E.S MUSHUBI"},
    {"code": "540702", "name": "G.S.MUSHA"},
    {"code": "540703", "name": "GS CYAHINA"},
    {"code": "540902", "name": "G.S MUHUMBI"},
    {"code": "550107", "name": "E.S RUKAMBA"},
    {"code": "550110", "name": "GS GIHUNDA"},
    {"code": "550207", "name": "E.S KIRUNDO"},
    {"code": "550208", "name": "G.S NYARUSANGE"},
    {"code": "550408", "name": "G.S KIBUMBA"},
    {"code": "550502", "name": "E.S MARIA D'APOSTOLAT"},
    {"code": "550604", "name": "G.S KALINDA"},
    {"code": "550706", "name": "GS NYAMPINGA"},
    {"code": "550707", "name": "GS KABARORE"},
    {"code": "550902", "name": "G.S MUKAGATANA"},
    {"code": "551001", "name": "GS NYAMUTSI"},
    {"code": "551002", "name": "G.S MUYUMBA"},
    {"code": "551006", "name": "E.S ST THERESE"},
    {"code": "560204", "name": "G.S KABURAME"},
    {"code": "560303", "name": "E.S KIBUMBA"},
    {"code": "560404", "name": "G.S KIGEME"},
    {"code": "560506", "name": "G.S KIVURUGA"},
    {"code": "560703", "name": "E.S GIKONDO"},
    {"code": "560804", "name": "G.S KIBORO"},
    {"code": "570100", "name": "E.S KIGARAMA"},
    {"code": "570305", "name": "GS KAMIRANZE"},
    {"code": "570308", "name": "G.S NYAMUZA"},
    {"code": "580504", "name": "E.S SHAYO"},
    {"code": "580601", "name": "G.S.MUSHA"},
    {"code": "580604", "name": "E.S SHYINGO"},
    {"code": "580701", "name": "GS SHYINGO"},
    {"code": "580903", "name": "G.S KABAZI"},
    {"code": "580904", "name": "E.S KIGARAMA"},
    {"code": "580905", "name": "G.S MUHUMBI"},
    {"code": "590303", "name": "G.S KIGARAMA"},
    {"code": "590404", "name": "G.S KAGERA"},
    {"code": "590505", "name": "E.S.MUNIGA"},
    {"code": "590707", "name": "G.S.RUTARE"},
    {"code": "590809", "name": "G.S KAREMBE"},
    {"code": "600101", "name": "GS MUTIMA"},
    {"code": "600304", "name": "G.S.NGOMA"},
    {"code": "600701", "name": "GS SHYINGO"},
    {"code": "600706", "name": "E.S MAHINDU"},
    {"code": "600802", "name": "GS RUHANGA"},
    {"code": "610101", "name": "G.S.MUHUMBI"},
    {"code": "610204", "name": "E.S KIBUMBA"},
    {"code": "610603", "name": "G.S NYANZA"},
    {"code": "610802", "name": "GS KANYINYA"},
    {"code": "620202", "name": "G.S NYABISHENGE"},
    {"code": "620303", "name": "GS NTIBURUSHWA"},
    {"code": "620501", "name": "G.S NDORA"},
    {"code": "620503", "name": "GS ST PAUL NYABIGINA"},
    {"code": "620603", "name": "E.S KIBUMBA"},
    {"code": "630201", "name": "E.S KIMIRINGA"},
    {"code": "630202", "name": "GS ST JOHN KIVURUGA"},
    {"code": "630401", "name": "E.S NYAMIHUNGA"},
    {"code": "630405", "name": "E.S KANDU"},
    {"code": "640104", "name": "GS SAINT LUC DE KABUGA"},
    {"code": "640208", "name": "GS KABURENGA"},
    {"code": "640301", "name": "G.S ST PAUL NYABICUCHE"},
    {"code": "640303", "name": "E.S KAREMBWE"},
    {"code": "640601", "name": "G.S ST MARIE D'HELVETIE"},
    {"code": "640703", "name": "G.S ST ANDRE"},
    {"code": "650104", "name": "E.S ST ANTOINE KIBUYE"},
    {"code": "650108", "name": "G.S NYARUGUNGA"},
    {"code": "650301", "name": "G.S NYAMISHEMBE"},
    {"code": "650401", "name": "E.S ST PAUL DE KIBUYE"},
    {"code": "650406", "name": "GS NDARAMBA"},
    {"code": "650502", "name": "E.S ST PIERRE DE KIGALI"},
    {"code": "650507", "name": "E.S ST LUC KAMBA"},
    {"code": "650602", "name": "E.S NYIRANKIREHE"},
    {"code": "650704", "name": "G.S NYARUTSU"},
    {"code": "650902", "name": "E.S GITAGATANGA"},
    {"code": "660104", "name": "G.S NTERA"},
    {"code": "660302", "name": "G.S RUSORORO"},
    {"code": "660604", "name": "GS ST MARIE RUSORORO"},
    {"code": "670103", "name": "G.S KIBUNGO"},
    {"code": "670202", "name": "GS NYABIKORE"},
    {"code": "670203", "name": "GS ST JOSEPH RUSORORO"},
    {"code": "670402", "name": "E.S MUREMBE"},
    {"code": "670701", "name": "E.S ST MARIE KIZIGU"},
    {"code": "670705", "name": "G.S ST PAUL RUSORORO"},
    {"code": "680501", "name": "G.S NTAMBA"},
    {"code": "680606", "name": "GS MUHIMA"},
    {"code": "690103", "name": "G.S KABUMBA"},
    {"code": "690202", "name": "G.S ST ANTOINE DE KIBUYE"},
    {"code": "690203", "name": "GS ST MARIE DE LA PAIX"},
    {"code": "690303", "name": "E.S MUREMBE"},
    {"code": "700204", "name": "GS MUGANDA"},
    {"code": "700301", "name": "GS MUGANZA"},
    {"code": "700401", "name": "G.S MURAMBI"},
    {"code": "700601", "name": "GS NYAKIBUYE"},
    {"code": "700804", "name": "E.S ST MARIE NYAMASHEKE"},
    {"code": "700805", "name": "GS NYAMASHEKE"},
    {"code": "710206", "name": "GS ST MARIE KIGALI"},
    {"code": "710504", "name": "E.S ST MARTIN"},
    {"code": "710505", "name": "E.S ST PIERRE KABUGA"},
    {"code": "710604", "name": "G.S MUKURA"},
    {"code": "710805", "name": "GS MUREMBE"},
    {"code": "710806", "name": "GS MUKINGI"},
    {"code": "710901", "name": "GS KIMIHURURA"},
    {"code": "720104", "name": "GS MURAMBI"},
    {"code": "720209", "name": "G.S KIGALI"},
    {"code": "720502", "name": "G.S GIKONDO"},
    {"code": "720504", "name": "E.S KIGARAMA"},
    {"code": "720506", "name": "G.S MUGAMBI"},
    {"code": "730203", "name": "E.S KAGANA"},
    {"code": "730301", "name": "GS KIKABO"},
    {"code": "740301", "name": "G.S RUBAYA"},
    {"code": "740604", "name": "G.S NYABIKORE"},
    {"code": "740705", "name": "G.S KIGALI"},
    {"code": "740707", "name": "E.S KABIRIZI"},
    {"code": "740802", "name": "G.S MUKARAMA"},
    {"code": "740805", "name": "G.S KAGINA"},
    {"code": "740806", "name": "G.S. RUKOMO"},
    {"code": "740903", "name": "E.S MUREMBE"},
    {"code": "740905", "name": "GS MURASIRANE"},
    {"code": "750101", "name": "GS NYABISINDU"},
    {"code": "750301", "name": "G.S RUGENGA"},
    {"code": "750403", "name": "E.S RUSORORO"},
    {"code": "750501", "name": "E.S NYABIKORE"},
    {"code": "750601", "name": "G.S RUGENGA"},
    {"code": "750703", "name": "G.S ST LUC DE KIGALI"},
    {"code": "750905", "name": "E.S NYAMIBU"},
    {"code": "751001", "name": "E.S NYAGISUMBI"},
    {"code": "760102", "name": "E.S KIGALI"},
    {"code": "760205", "name": "GS KIMIHURURA"},
    {"code": "760301", "name": "E.S GITARAMA"},
    {"code": "760602", "name": "E.S GIKONDO"},
    {"code": "760604", "name": "G.S MURAMBI"},
    {"code": "760802", "name": "E.S KABUSANZA"},
    {"code": "760901", "name": "G.S MURAMBI"},
    {"code": "760905", "name": "G.S KIMIHURURA"},
    {"code": "761002", "name": "E.S GIHANGA"},
    {"code": "770101", "name": "GS KAMAKWATU"},
    {"code": "770204", "name": "G.S MUSHYIRA"},
    {"code": "770301", "name": "G.S KAMIRANZE"},
    {"code": "770403", "name": "G.S KAMARABA"},
    {"code": "770507", "name": "GS KIVUMBI"},
    {"code": "770601", "name": "E.S KINAZI"},
    {"code": "780401", "name": "E.S KAYUMBA"},
    {"code": "780501", "name": "GS NDIHIRE"},
    {"code": "780503", "name": "G.S KIMIHURURA"},
    {"code": "790501", "name": "E.S KINAZI"},
    {"code": "790601", "name": "E.S ST PAUL DE KIGALI"},
    {"code": "790902", "name": "GS KANYINYA"},
    {"code": "790903", "name": "GS KIGARAMA"},
    {"code": "800205", "name": "GS ST ANTOINE DE KIGALI"},
    {"code": "800301", "name": "GS NYABIKONI"},
    {"code": "800701", "name": "E.S ST PIERRE DE KIGALI"},
    {"code": "800705", "name": "G.S ST ANTOINE KIGALI"},
    {"code": "810101", "name": "GS MURAMBI"},
    {"code": "810204", "name": "E.S ST MARIE NYAMASHEKE"},
    {"code": "810301", "name": "E.S ST ANTOINE KIBUNGO"},
    {"code": "810701", "name": "G.S NYABIKONI"},
    {"code": "810703", "name": "GS MUGANZA"},
    {"code": "810801", "name": "E.S MURATINA"},
    {"code": "820106", "name": "G.S RUGARURA"},
    {"code": "820301", "name": "G.S ST LUC KIGALI"},
    {"code": "820302", "name": "G.S KAZABA"},
    {"code": "820401", "name": "E.S ST PAUL KIGALI"},
    {"code": "820505", "name": "GS RUGENZI"},
    {"code": "820601", "name": "GS KAMIHU"},
    {"code": "830204", "name": "E.S RUTARE"},
    {"code": "830301", "name": "G.S NYAMIHU"},
    {"code": "830502", "name": "GS KALIMBA"},
    {"code": "830507", "name": "GS RUGANO"},
    {"code": "840103", "name": "E.S KIVUMBI"},
    {"code": "840204", "name": "G.S MAHINDU"},
    {"code": "840301", "name": "G.S GIHUNDWE"},
    {"code": "840501", "name": "E.S MURASIRANE"},
    {"code": "840601", "name": "E.S GIKAMBI"},
    {"code": "840701", "name": "GS ST MARIE KIGALI"},
    {"code": "840902", "name": "GS KIBUYE"},
    {"code": "841001", "name": "G.S RUSHYIRA"},
    {"code": "850205", "name": "E.S NYABIKORE"},
    {"code": "850207", "name": "E.S KIMIRINGA"},
    {"code": "850209", "name": "E.S KAZABA"},
    {"code": "850601", "name": "G.S KAGINA"},
    {"code": "860101", "name": "GS ST PAUL KIGALI"},
    {"code": "860301", "name": "GS NDIHIRE"},
    {"code": "860601", "name": "GS RUGANA"},
    {"code": "870201", "name": "G.S ST PIERRE KIGALI"},
    {"code": "870203", "name": "G.S NYAKIZU"},
    {"code": "870601", "name": "G.S KAGINA"},
    {"code": "870603", "name": "G.S KIBUNGO"},
    {"code": "870701", "name": "G.S KIBUNGO"},
    {"code": "880102", "name": "GS ST ANTOINE DE KIGALI"},
    {"code": "880103", "name": "E.S KIMIHURURA"},
    {"code": "890102", "name": "G.S KAYUMBA"},
    {"code": "890207", "name": "E.S ST MARIE KIGALI"},
    {"code": "890405", "name": "GS MURAMBI"},
    {"code": "900103", "name": "E.S GITARAMA"},
    {"code": "900206", "name": "GS GITARAMA"},
    {"code": "900601", "name": "E.S KIGALI"},
    {"code": "900607", "name": "G.S ST THERESE"},
    {"code": "900801", "name": "E.S MAHINDU"},
    {"code": "910101", "name": "E.S KANYINYA"},
    {"code": "910202", "name": "G.S MURAMBI"},
    {"code": "910205", "name": "GS MURAMBI"},
    {"code": "910301", "name": "E.S MUNIGA"},
    {"code": "920101", "name": "E.S KIBUYE"},
    {"code": "920301", "name": "G.S. NYABIKORE"},
    {"code": "920501", "name": "G.S ST MARIE KIGALI"},
    {"code": "930104", "name": "E.S KIMIHURURA"},
    {"code": "930201", "name": "GS ST PAUL NYAMIRAMBO"},
    {"code": "940102", "name": "GS MURAMBI"},
    {"code": "940201", "name": "E.S NDARAGI"},
    {"code": "950303", "name": "G.S NYABIKORE"},
    {"code": "950401", "name": "E.S ST LUC KIGALI"},
    {"code": "960102", "name": "E.S GIKONDO"},
    {"code": "960203", "name": "G.S GIKONDO"},
    {"code": "960304", "name": "GS ST PAUL RUKUNDO"},
    {"code": "970102", "name": "G.S MUKAMANA"},
    {"code": "970201", "name": "GS KANYINYA"},
    {"code": "980101", "name": "E.S NYAMIHUNGA"},
  

];

const classLists=[
  {"name": "N1", "number": "1"},
  {"name": "N2", "number": "2"},
  {"name": "N3", "number": "3"},
  {"name": "P1", "number": "4"},
  {"name": "P2", "number": "5"},
  {"name": "P3", "number": "6"},
  {"name": "P4", "number": "7"},
  {"name": "P5", "number": "8"},
  {"name": "P6", "number": "9"},
  {"name": "S1", "number": "10"},
  {"name": "S2", "number": "11"},
  {"name": "S3", "number": "12"},
  {"name": "S4", "number": "13"},
  {"name": "S5", "number": "14"},
  {"name": "S6", "number": "15"}
]
;

const studentInfo=[
  {"code": "230305160425", "name": "Nizeyimana Emmanuel", "class_id":"N1"},
  {"code": "230309230070", "name": "NSHIMIYIMANA Remy", "class_id":"N2"},
  {"code": "230309230182", "name": "UZAMUKUNDA Sifa", "class_id":"P1"},
  {"code": "230309230068", "name": "IRANKUNDA Claude", "class_id":"P3"},
  {"code": "231203190503", "name": "KALIZA YUBAHWE Beline", "class_id":"S1"}
]
;

//default value
const kDefaultPadding = 20.0;





const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const sizedBox10 = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);
const sizedBox5 = SizedBox(
  width: kDefaultPadding / 4,
);
var sizedBox05h = const SizedBox(
  height: 10,
);
var sizedBox15 = const SizedBox(
  height: 15,
);
const kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

const kBottomBorderRadius = BorderRadius.only(
  bottomRight: Radius.circular(20),
  bottomLeft: Radius.circular(20),
);

const kBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
  bottomRight: Radius.circular(20),
  bottomLeft: Radius.circular(20),
);

const ktextBlack = TextStyle(
  color: Colors.black,
  fontSize: 10,
  fontWeight: FontWeight.w700,
);
const ktextBlack12 = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontWeight: FontWeight.w700,
);

const ktextBlack14 = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

const ktextBBlack = TextStyle(
  color: Colors.black,
  fontSize: 10,
  fontWeight: FontWeight.bold,
);

const ktextBBlack16 = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const ktextBBlack14 = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const ktextLight = TextStyle(
  color: kTextLightColor,
  fontSize: 10,
  // fontWeight: FontWeight.w700,
);

const ktextLight14 = TextStyle(
  color: kTextLightColor,
  fontSize: 14,
  // fontWeight: FontWeight.w700,
);

const ktextLight16 = TextStyle(
  color: kTextLightColor,
  fontSize: 16,
  // fontWeight: FontWeight.w700,
);

const ktextPBlack = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);
const ktextPWhite = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

const ktextGrey = TextStyle(
  color: kgrey800Color,
  fontSize: 10,
  // fontWeight: FontWeight.w700,
);

const ktextWhite = TextStyle(
  color: Colors.white,
  fontSize: 10,
  // fontWeight: FontWeight.w700,
);



final kInputTextStyle = GoogleFonts.poppins(
    color: kTextBlackColor, fontSize: 12, fontWeight: FontWeight.w500);
final kTextWhiteTitle = GoogleFonts.poppins(
    color: kTextBlackColor, fontSize: 12, fontWeight: FontWeight.w500);
final kHintTextStyle=  GoogleFonts.poppins(
    color: kTextBlackColor, fontSize: 12, fontWeight: FontWeight.w500);  
    final kLabelTextStyle=  GoogleFonts.poppins(
    color: kTextBlackColor, fontSize:12, fontWeight: FontWeight.w500);  


   final kInputTextStyle10 = GoogleFonts.poppins(
    color: kTextBlackColor, fontSize:10, fontWeight: FontWeight.w500);
final kTextWhiteTitle10 = GoogleFonts.poppins(
    color: kTextBlackColor, fontSize:10, fontWeight: FontWeight.w500);
final kHintTextStyle10=  GoogleFonts.poppins(
    color: kTextBlackColor, fontSize:10, fontWeight: FontWeight.w500);  
final kLabelTextStyle10=  GoogleFonts.poppins(
    color: kTextBlackColor, fontSize:10, fontWeight: FontWeight.w500);  


final kTextWhiteStyle = GoogleFonts.poppins(
  color: kTextWhiteColor,
  fontSize: 10,
);

//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
