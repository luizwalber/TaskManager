flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/locale/app_localization.dart


flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_messages.arb lib/l10n/intl_en.arb lib/l10n/intl_pt.arb lib/locale/app_localization.dart
