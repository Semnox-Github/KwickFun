import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/repository/request/customer_service.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class CustomerRepository {
  CustomerService? _customerService;
  CustomerRepository(ExecutionContextDTO executionContextDTO) {
    _customerService = CustomerService(executionContextDTO);
  }

  Future<List<CustomerDTO>?> getCustomerDTOList(
      Map<CustomerDTOSearchParameter, dynamic> params) async {
    var customerDTOList =
        await _customerService?.getCustomerDTOList(searchParams: params);
    return customerDTOList;
  }

  Future<bool?> login(Map<String, dynamic> customerLoginRequestDTO) async {
    return await _customerService?.login(customerLoginRequestDTO);
  }
}
