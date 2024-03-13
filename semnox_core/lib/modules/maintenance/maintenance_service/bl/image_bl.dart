import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/model/images_dto.dart';
import 'package:semnox_core/modules/maintenance/maintenance_service/repositories/image_repositories.dart';

class ImageBL {
  ImageDTO? _imageDTO;
  ExecutionContextDTO? _executionContext;
  ImageRepositories? _imageRepositories;
  int? _id;

  ImageBL.id(ExecutionContextDTO executionContext, int? id) {
    _id = id;
    _executionContext = executionContext;
    _imageRepositories = ImageRepositories(_executionContext!);
  }

  ImageBL.dto(ExecutionContextDTO executionContext, ImageDTO imageDTO) {
    _executionContext = executionContext;
    _imageDTO = imageDTO;
    _imageRepositories = ImageRepositories(_executionContext!);
  }

  Future<int> postImageDTO(
      Map<ImageSearchParameter, dynamic> postsearchparams) async {
    var result =
        await _imageRepositories!.postImageDto(_imageDTO!, postsearchparams);
    return result;
  }

  Future<bool> postfileupload() async {
    bool result = await _imageRepositories!.postfileupload(_imageDTO!);
    return result;
  }

  Future<void> getfileupload() async {
    await _imageRepositories!.getfileupload(_imageDTO!);
  }

  Future<int> saveImage() async {
    return await _imageRepositories!.saveImage(_imageDTO!);
  }
}

class ImageListBL {
  late ExecutionContextDTO _executionContext;
  ImageListBL(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
  }

  Future<List<ImageDTO>> getimageDTOList(
      Map<ImageSearchParameter, dynamic> searchparams) async {
    return await ImageRepositories(_executionContext)
        .getimageDTOList(searchparams);
  }
}
