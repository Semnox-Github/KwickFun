import 'package:semnox_core/modules/common_services/model/generic_otp_dto.dart';
import 'package:semnox_core/modules/common_services/repository/request/generic_otp_service.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class GenericOtpRepository {
  GenericOtpService? _genericOtpService;
  GenericOtpRepository(ExecutionContextDTO executionContextDTO) {
    _genericOtpService = GenericOtpService(executionContextDTO);
  }

  Future<GenericOtpDTO?> createOtp(
      Map<String, dynamic> genericotprequestDTO) async {
    var genericOtpDTO = await _genericOtpService?.createOtp(genericotprequestDTO);
    return genericOtpDTO;
  }

  Future<bool?> validateOTP(int otpId, String otp) async {
    bool? isValidOtp = await _genericOtpService?.validateOTP(otpId, otp);
    return isValidOtp;
  }
}
