class AppString {
  static const String appName = "Adeo test";
  static const String primaryFont = "Poppins";
  static const String appWelcome = "Welcome to the\nAdeo Experience";
  static const String subscriptionPrompt =
      "You currently have \n NO Subscriptions. \n\n First take a DIAGNOSTIC TEST \n to determine the right course \n for you. ";
  static const String next = 'Next';
  static const String skip = 'Skip';
  static const String selectLevel = "Select your level";
  static const String selectClass = "Select your class";
  static const String score = 'Score';
  static const String rank = 'Rank';
  static const String timeTaken = 'Time taken';
  static var buySubscription ='Buy Subscription';

  static List levelOptions = [
    {'name': 'Primary', 'value': 1},
    {'name': 'Junior High', 'value': 2},
    {'name': 'Senior High', 'value': 3},
    {'name': 'Tertiary', 'value': 4},
  ];

  static List classOptions = [
    {'name': 'english', 'value': 1},
    {'name': 'ict', 'value': 2},
    {'name': 'social', 'value': 3},
    {'name': 'french', 'value': 4},
    {'name': 'math', 'value': 5},
    {'name': 'science', 'value': 6},
  ];

}
