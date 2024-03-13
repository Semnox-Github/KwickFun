import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/modules/sites/repository/sites_view_repository.dart';

class SitesViewBL {
  SiteViewRepository? _sitesViewRepository;
  SiteViewDTO? _siteViewDTO;
  ExecutionContextDTO? _executionContext;

  SitesViewBL.id(ExecutionContextDTO executionContext, int id) {
    _executionContext = executionContext;
    _sitesViewRepository = SiteViewRepository();
    _siteViewDTO = _sitesViewRepository?.getSiteById(id);
  }

  SitesViewBL.dto(
      ExecutionContextDTO executionContext, SiteViewDTO siteViewDTO) {
    _executionContext = executionContext;
    _sitesViewRepository = SiteViewRepository();
    _siteViewDTO = siteViewDTO;
  }

  SiteViewDTO? getSiteViewDTO() {
    return _siteViewDTO;
  }
}

class SitesViewListBL {
  SiteViewRepository? _siteViewRepository;
  ExecutionContextDTO? _executionContext;

  SitesViewListBL(ExecutionContextDTO? executionContext) {
    _siteViewRepository = SiteViewRepository();
    _executionContext = executionContext;
  }

  Future<List<SiteViewDTO>?> getSites() async {
    return await _siteViewRepository!.getSiteViewDTOList(_executionContext!);
  }

  Future<List<SiteViewDTO>?> getSitesWithoutMaster() async {
    var sitesViewDTO = await getSites();
    sitesViewDTO?.removeWhere((item) => item.isMasterSite == true);
    return sitesViewDTO;
  }

  // SiteViewDTO
  Future<List<SiteViewDTO>?> getMasterSite() async {
    var sitesViewDTO = await getSites();
    // ignore: unnecessary_null_comparison
    if (sitesViewDTO == null) throw Exception("Sites Not Found");
    sitesViewDTO.removeWhere((item) => item.isMasterSite == false);
    return sitesViewDTO;
  }
}
