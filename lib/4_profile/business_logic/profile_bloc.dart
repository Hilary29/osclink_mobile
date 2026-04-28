import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/services/profile_mock_data.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(ProfileLoaded(ProfileMockData.getCurrentUserProfile()));
  }

  void _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (state is! ProfileLoaded) return;
    final updated = (state as ProfileLoaded).profile.copyWith(
      name: event.name,
      bio: event.bio,
      location: event.location,
      website: event.website,
    );
    emit(ProfileLoaded(updated));
  }
}
