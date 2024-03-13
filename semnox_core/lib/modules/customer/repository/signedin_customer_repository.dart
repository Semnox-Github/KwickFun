import 'dart:convert';
import 'package:semnox_core/modules/customer/bl/customer_bl.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/utils/storage_service/storage_service.dart';

class SignedInCustomerRepository {
  static String get _customerId => "customerId";
  static CustomerDTO? _customerDTO;
  ExecutionContextDTO? _executionContextDTO;

  SignedInCustomerRepository(ExecutionContextDTO executionContextDTO) {
    _executionContextDTO = executionContextDTO;
  }

  Future<CustomerDTO?> getSignedInCustomer() async {
    var customerId = LocalStorage().get(_customerId);
    if (int.tryParse(customerId!)! > -1) {
      if (_customerDTO != null) {
        return _customerDTO;
      } else {
        _customerDTO = await CustomerBL.id(
                _executionContextDTO!, int.tryParse(customerId)!)
            .getCustomerDTObyId();
        return _customerDTO;
      }
    } else {
      throw Exception();
    }
  }

  Future<void> setSignedInCustomer(int customerId) async {
    await LocalStorage().save(_customerId, json.encode(customerId));
    _customerDTO = await CustomerBL.id(_executionContextDTO!, customerId)
        .getCustomerDTObyId();
  }
}
