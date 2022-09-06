/// Serializer a boolean which depends of user auth. These value will either be:
/// - A boolean -> true/false
/// - A string -> If authentifaction failed
bool authBooleanSerializer(dynamic value) {
  if (value == true) {
    return true;
  }
  return false;
}
