import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/repository/signedin_customer_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class SignedInCustomerProvider {
  SignedInCustomerRepository? _signedInCustomerRepository;
  SignedInCustomerProvider(ExecutionContextDTO executionContextDTO) {
    _signedInCustomerRepository =
        SignedInCustomerRepository(executionContextDTO);
  }

  Future<CustomerDTO?> getSignedInCustomer() async {
    var customerDTO = await _signedInCustomerRepository?.getSignedInCustomer();
    return customerDTO;
  }

  Future<void> setSignedInCustomer(int customerId) async {
    await _signedInCustomerRepository?.setSignedInCustomer(customerId);
  }
}
