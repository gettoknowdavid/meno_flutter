abstract class IOnboardingFacade {
  bool get onboardingComplete;

  Future<void> completeOnboarding();
}
