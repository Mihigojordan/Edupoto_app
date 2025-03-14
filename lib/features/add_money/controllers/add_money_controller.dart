import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/add_money/domain/reposotories/add_money_repo.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/add_money/screens/web_screen.dart';

class AddMoneyController extends GetxController implements GetxService {
  final AddMoneyRepo addMoneyRepo;
  AddMoneyController({required this.addMoneyRepo});

 bool  _isLoading = false;
  String? _addMoneyWebLink;
  bool get isLoading => _isLoading;
  String? get addMoneyWebLink => _addMoneyWebLink;

  String _paymentMethod='mtn';
  String? get paymentMethod => _paymentMethod;




  Future<void> addMoney(double amount) async{
    _isLoading = true;
    update();
    Response response = await addMoneyRepo.addMoneyApi(amount : amount, paymentMethod: _paymentMethod);
      print('wwwwwwwwwwww${response.statusCode}');
    if(response.statusCode == 200){
      print('wpoooooooooooooooooooooooooooooooooooooooooooooo ${response.body}');
     _addMoneyWebLink =  response.body['data']['payment_link'];
     if(_addMoneyWebLink != null){
        print('ziiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii $_addMoneyWebLink');
       Get.offAll(()=> WebScreen(selectedUrl: _addMoneyWebLink!, isPaymentUrl: true));
     }
    }else{
        print('wfffffffffffffffffffffffffffffffffffffffffffffffffffffff');
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();


  }


  void setPaymentMethod(String? method, {isUpdate = true}) {
    _paymentMethod = method!;
   if(isUpdate){
     update();
   }
  }

}