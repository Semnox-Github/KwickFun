import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/repository/customer_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class CustomerListBL {
  CustomerRepository? _customerRepository;
  ExecutionContextDTO? _executionContext;

  CustomerListBL(ExecutionContextDTO? executionContext) {
    _customerRepository = CustomerRepository(executionContext!);
    _executionContext = executionContext;
  }

  Future<List<CustomerDTO>?> getCustomerDTOList(
      Map<CustomerDTOSearchParameter, dynamic> params) async {
    var customerDTOList = await _customerRepository?.getCustomerDTOList(params);
    return customerDTOList;
  }
}
