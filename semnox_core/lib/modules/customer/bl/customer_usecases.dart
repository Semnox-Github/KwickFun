import 'package:semnox_core/modules/common_services/bl/generic_otp_bl.dart';
import 'package:semnox_core/modules/common_services/bl/generic_otp_usecases.dart';
import 'package:semnox_core/modules/customer/bl/customer_bl.dart';
import 'package:semnox_core/modules/customer/bl/customer_list_bl.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_login_dto.dart';
import 'package:semnox_core/modules/customer/provider/signedn_customer_provider.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class CustomerUseCases {
  ExecutionContextDTO? _executionContextDTO;

  CustomerUseCases(ExecutionContextDTO? executionContextDTO) {
    _executionContextDTO = executionContextDTO;
  }

  Future<List<CustomerDTO>?>? getSignedInCustomer() async {
    return null;
  }

  Future<CustomerLoginDTO?> loginCustomerByOtp(String phoneoremail) async {
    var customerDTOList = await getCustomerByPhoneOrEmail(phoneoremail);
    CustomerLoginDTO? customerLoginDTO;
    if (customerDTOList!.isNotEmpty) {
      if (customerDTOList.length > 1) {
        throw Exception("Duplicate Customer found");
      }
      // Generate OTP
      CustomerDTO identifiedCustomer =
          customerDTOList[0]; // profileDTO phone and email and source
      var genericotpDto = await GenericOtpUsecases(_executionContextDTO!)
          .generateOTP(identifiedCustomer.phone!, identifiedCustomer.email!,
              "LOGIN_OTP_EVENT");
      // call api to generate the OTP
      // create a new instance of the customerloginmodel
      customerLoginDTO = CustomerLoginDTO(
          customerId: customerDTOList.first.id, otpId: genericotpDto?.id);
      // assign customer id to model
      // assign otp id to model
    } else {
      throw Exception("Customer not found");
    }
    return customerLoginDTO;
  }

  Future<bool?> validateCustomerLoginOTP(
      int customerId, int otpId, String otp) async {
    // step 1 - cal API with OTP id and OTP to validate is the OTP is correct
    bool? isValidOtp =
        await GenericOtpBL(_executionContextDTO!).validateOTP(otpId, otp);
    // if OTP is invalid throw exception
    if (isValidOtp == false) {
      throw Exception("Invalid OTP");
    }

    if (isValidOtp == true) {
      await SignedInCustomerProvider(_executionContextDTO!)
          .setSignedInCustomer(customerId);
    }
    // not get the customer details using API for customer id
    return isValidOtp;
  }

  Future<bool?> loginCustomerbyPassword(
      String phoneoremail, String password) async {
    var customerDTOList = await getCustomerByPhoneOrEmail(phoneoremail);
    bool? isValidCustomer = false;
    if (customerDTOList!.isNotEmpty) {
      if (customerDTOList.length > 1) {
        throw Exception("Duplicate Customer found");
      }
      // Call CustomerLogin API

      isValidCustomer =
          await CustomerBL.dto(_executionContextDTO!, customerDTOList.first)
              .login(password);

      if (isValidCustomer == true) {
        await SignedInCustomerProvider(_executionContextDTO!)
            .setSignedInCustomer(customerDTOList.first.id!);
      }
    } else {
      throw Exception("Customer not found");
    }
    return isValidCustomer;
  }

  Future<List<CustomerDTO>?>? getCustomerByPhoneOrEmail(
      String phoneoremail) async {
    Map<CustomerDTOSearchParameter, dynamic> params = {
      CustomerDTOSearchParameter.buildChildRecords: true, // check
      CustomerDTOSearchParameter.loadAdultOnly: true,
      CustomerDTOSearchParameter.phoneOrEmail: phoneoremail,
    };
    var customerDTOList =
        await CustomerListBL(_executionContextDTO).getCustomerDTOList(params);
    return customerDTOList;
  }

  Future<List<CustomerDTO>?>? resetPassword() async {
    return null;
  }

  Future<void> forgotPassword() async {}
}
