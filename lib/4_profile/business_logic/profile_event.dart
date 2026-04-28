abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String bio;
  final String? location;
  final String? website;

  UpdateProfileEvent({
    required this.name,
    required this.bio,
    this.location,
    this.website,
  });
}
