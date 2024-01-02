/**
 * Spacing naming follow similar convention as Material Design colors,
 * so that it's not necessary to have spacings like xxxxxsmall etc.
 * Three main spacings are defined as `small`, `medium` and `large`
 * and number next to it is the percentage value of the base size.
 * For example `small_150` = `small_100` * 150%
 */
abstract class Spacing {
  static const double small_100 = 8.0;

  static const double medium_100 = 16.0;
  static const double medium_125 = 20.0;
  static const double medium_150 = 20.0;

  static const double large_100 = 36.0;
}
