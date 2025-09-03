
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/features/home/domain/models/payment_model.dart';
import 'package:hosomobile/features/home/domain/reposotories/payment_repo.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController implements GetxService{
  final PaymentRepo paymentRepo;
  PaymentController({required this.paymentRepo});
  bool _isLoading = false;
  List<PaymentModel>? _paymentmentList;

  bool get isLoading => _isLoading;
  List<PaymentModel>? get paymentList => _paymentmentList;

  Future getPaymentList(bool reload , {bool isUpdate = true}) async {
    if(_paymentmentList == null || reload) {
      _paymentmentList = null;
      _isLoading = true;

      if(isUpdate){
        update();
      }
    }
    if(_paymentmentList == null ) {
      _paymentmentList = [];
      Response response = await paymentRepo.makePaymentApi();
      if(response.body != null && response.body != {} && response.statusCode == 200){
        _paymentmentList = [];
        response.body.forEach((website) {_paymentmentList!.add(PaymentModel.fromJson(website));});
      }else{
        _paymentmentList = [];
        ApiChecker.checkApi(response);

      }

      _isLoading = false;
      update();

    }
  }


}