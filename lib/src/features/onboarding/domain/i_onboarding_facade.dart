abstract class IOnboardingFacade {
  bool get onboardingComplete;

  Future<bool> completeOnboarding();
}
