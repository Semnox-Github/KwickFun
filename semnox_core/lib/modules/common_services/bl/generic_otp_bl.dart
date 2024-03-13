import 'package:semnox_core/modules/common_services/model/generic_otp_dto.dart';
import 'package:semnox_core/modules/common_services/repository/generic_otp_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class GenericOtpBL {
  GenericOtpRepository? _genericOtpRepository;
  GenericOtpDTO? _genericOtpDTO;

  GenericOtpBL.id(ExecutionContextDTO executionContextDTO, int id) {
    _genericOtpRepository = GenericOtpRepository(executionContextDTO);
  }

  GenericOtpBL.dto(
      ExecutionContextDTO executionContextDTO, GenericOtpDTO genericOtpDTO) {
    _genericOtpRepository = GenericOtpRepository(executionContextDTO);
    _genericOtpDTO = genericOtpDTO;
  }

  GenericOtpBL(ExecutionContextDTO executionContextDTO) {
    _genericOtpRepository = GenericOtpRepository(executionContextDTO);
  }

  Future<GenericOtpDTO?> createOtp(
      Map<String, dynamic> genericotprequestDTO) async {
    _genericOtpDTO =
        await _genericOtpRepository?.createOtp(genericotprequestDTO);
    return _genericOtpDTO;
  }

  Future<bool?> validateOTP(int otpId, String otp) async {
    bool? isValidOtp =
        await _genericOtpRepository?.validateOTP(otpId, otp);
    return isValidOtp;
  }
}
