import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Cause.dart';

Cause mockCause({int id = 1}){

  return Cause(
      actions: [],
      id: id,
      title: 'Charlie',
      icon: CustomIcons.ic_learning,
      description: 'yes',
      selected: true,
      headerImage: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fsea%2F&psig=AOvVaw1ZqXePp9rXfmRtXNyggrgA&ust=1639670834668000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNCc7P6X5vQCFQAAAAAdAAAAABAD'
  );
}