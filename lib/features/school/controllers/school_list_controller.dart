import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/history/domain/models/transaction_model.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/school/domain/repositories/school_list_repo.dart';
import 'package:hosomobile/util/app_constants.dart';

class SchoolListController extends GetxController implements GetxService{
  final SchoolListRepo schoolListRepo;
  SchoolListController({required this.schoolListRepo});

  int? _pageSize;
  bool _isLoading = false;
  bool _firstLoading = true;
  bool get firstLoading => _firstLoading;
  int _offset = 1;
  int get offset =>_offset;
  int _schoolListIndex = 0;


  List<int> _offsetList = [];
  List<int> get offsetList => _offsetList;

  List<SchoolLists> _schoolList  = [];
  List<SchoolLists> get schoolList => _schoolList;

  List<SchoolLists> _headteacherMessageList  = [];
  List<SchoolLists> get headteacherMessageList => _headteacherMessageList;

  List<SchoolLists> _classRequirementList = [];
  List<SchoolLists> get classRequirementList => _classRequirementList;

  List<SchoolLists> _tuitionFeeList = [];
  List<SchoolLists> get tuitionFeeList => _tuitionFeeList;

  List<SchoolLists> _domitoryEssentialList = [];
  List<SchoolLists> get domitoryEssentialList => _domitoryEssentialList;

  List<SchoolLists> _textBookList = [];
  List<SchoolLists> get textBookList => _textBookList;

  List<SchoolLists> _cashOutList = [];
  List<SchoolLists> get cashOutList => _cashOutList;

  List<SchoolLists> _withdrawList = [];
  List<SchoolLists> get withdrawList => _withdrawList;

  List<SchoolLists> _paymentList = [];
  List<SchoolLists> get paymentList => _paymentList;



  int? get pageSize => _pageSize;
  bool get isLoading => _isLoading;
  int get schoolListIndex => _schoolListIndex;

  void showBottomLoader() {
    _isLoading = true;
    update();
  }


  Future getSchoolListData(int offset, {bool reload = false}) async{
    if(reload) {
      _offsetList = [];
      _schoolList = [];
      _headteacherMessageList = [];
      _classRequirementList = [];
      _tuitionFeeList = [];
      _domitoryEssentialList = [];
      _textBookList =[];
      _cashOutList = [];
      _withdrawList = [];
      _paymentList = [];
    }
    _offset = offset;
    if(!_offsetList.contains(offset)) {
      _offsetList.add(offset);

      Response response = await schoolListRepo.getSchoolList(offset);
      print('this is the controllers response xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ${response.body}');
      if(response.body['transactions'] != null && response.body['transactions'] != {} && response.statusCode==200){
        _schoolList = [];
        _headteacherMessageList=[];
        _classRequirementList = [];
        _tuitionFeeList = [];
        _domitoryEssentialList = [];
        _textBookList =[];
        _cashOutList = [];
        _withdrawList = [];
        _paymentList = [];

        response.body['transactions'].forEach((transactionHistory) {
          SchoolLists history = SchoolLists.fromJson(transactionHistory);
          if(history.transactionType == AppConstants.headteacherMessage){
            _headteacherMessageList.add(history);
          }else if(history.transactionType == AppConstants.classRequirement){
            _classRequirementList.add(history);
          }else if(history.transactionType == AppConstants.tuitionFee){
            _tuitionFeeList.add(history);
          }else if(history.transactionType == AppConstants.dormitoryEssential){
            _domitoryEssentialList.add(history);
          }else if(history.transactionType == AppConstants.textBook){
            _textBookList.add(history);
          }else if(history.transactionType == AppConstants.withdraw){
            _withdrawList.add(history);
          }else if(history.transactionType == AppConstants.payment){
            _paymentList.add(history);
          }else if(history.transactionType == AppConstants.cashOut){
            _cashOutList.add(history);
          }_schoolList.add(history);
        });
        _pageSize = TransactionModel.fromJson(response.body).totalSize;
      }else{
        ApiChecker.checkApi(response);
      }

      _isLoading = false;
      _firstLoading = false;
      update();
    }

  }

  void setIndex(int index) {
    _schoolListIndex = index;
    update();
  }

}