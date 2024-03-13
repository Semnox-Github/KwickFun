import 'package:semnox_core/modules/parafait_defaults_configuration/provider/default_config.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/default_config_keys.dart';
import 'package:semnox_core/semnox_core.dart';

///
/// Extension Methods to format number based on default config.
///
extension FormatString on num {
  String formatToCurrencyCode() {
    final format =
        DefaultConfigProvider.getConfigFor(DefaultConfigKey.AMOUNT_WITH_CURRENCY_CODE);
    return format == null ? toCurrency() : NumberFormat(format).format(this);
  }

  String formatToCurrencySymbol() {
    final format = DefaultConfigProvider.getConfigFor(
        DefaultConfigKey.AMOUNT_WITH_CURRENCY_SYMBOL);
    return NumberFormat(format).format(this);
  }
}

extension FormatDateTime on DateTime? {
  String fromatToDateTime() {
    if (this == null) return "";
    final format = DefaultConfigProvider.getConfigFor(DefaultConfigKey.DATETIME_FORMAT);
    return DateFormat(format).format(this!);
  }

  String fromatToDate() {
    if (this == null) return "";
    final format = DefaultConfigProvider.getConfigFor(DefaultConfigKey.DATE_FORMAT);
    return DateFormat(format).format(this!);
  }
}

extension StringUtils on String {
  String maxTrim(int length, {String overflowChar = "..."}) {
    // if(this == null) return "";
    return this.length > length ? substring(0, length) + overflowChar : this;
  }
}
