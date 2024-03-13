import 'package:semnox_core/modules/common_services/bl/generic_otp_bl.dart';
import 'package:semnox_core/modules/common_services/model/generic_otp_dto.dart';
import 'package:semnox_core/modules/common_services/model/generic_otp_request_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class GenericOtpUsecases {
  ExecutionContextDTO? _executionContextDTO;

  GenericOtpUsecases(ExecutionContextDTO executionContextDTO) {
    _executionContextDTO = executionContextDTO;
  }

  Future<GenericOtpDTO?> generateOTP(
      String phone, String email, String source) async {
    // Build GenericOtpRequestDTO
    var genericotprequestDTO =
        GenericOtpRequestDTO(emailId: email, phone: phone, source: source)
            .toJson();
    // Call createOtp API
    var genericotpDto = await GenericOtpBL(_executionContextDTO!)
        .createOtp(genericotprequestDTO);
    return genericotpDto;
  }
}
