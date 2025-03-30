abstract class IOnboardingFacade {
  Future<bool> get onboardingComplete;

  Future<void> completeOnboarding();
}
