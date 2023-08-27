class OnboardingModel {
  final String titleImage;
  final String describtion;
  final String imagePath;

  OnboardingModel({
    required this.titleImage,
    required this.describtion,
    required this.imagePath,
  });
}

List<OnboardingModel> onBoardInfo = [
  OnboardingModel(
    titleImage: 'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(5).png?alt=media&token=a32ea12f-01c1-457f-9821-d6f9a9ab76f6',
    describtion: 'مع المستقبل، لديك الفرصة لاكتشاف أكثر الوجهات السياحية إثارة في جميع أنحاء العالم. اختر الوجهة التي تحلم بزيارتها، وسنوفر لك حزم رحلات مخصصة تتناسب مع اهتماماتك وميزانيتك.',
    imagePath: 'https://firebasestorage.googleapis.com/v0/b/tatto-f6d81.appspot.com/o/Screenshot_1.png?alt=media&token=6dc49538-8f08-4551-a56f-f45696efac1c',
  ),
  OnboardingModel(
    titleImage: 'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(4).png?alt=media&token=4c0a2d9b-721c-4f7e-9537-1e9585ccdbe1',
    describtion: 'نتيح لك حجز تذاكر الطيران بكل يسر وسهولة. قم بتحديد وقت السفر والعودة، واحصل على أفضل العروض والأسعار المناسبة لك.',
    imagePath: 'https://firebasestorage.googleapis.com/v0/b/tatto-f6d81.appspot.com/o/Screenshot_2.png?alt=media&token=12b83ea0-e3e9-4676-8ef7-c34ca9507e4d',
  ),
  OnboardingModel(
    titleImage: 'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(3).png?alt=media&token=51c1b3e0-3a13-4ae2-81dd-8e002551f9dc',
    describtion: 'ستحصل على تجربة سفر فريدة لا مثيل لها. نحن نجمع بين الابتكار التكنولوجي والتجارب الثقافية لنقدم لك أفضل ما في السياحة العالمية. احجز رحلتك الأولى الآن ودعنا نجعل كل لحظة تجربة لا تُنسى.',
    imagePath: 'https://firebasestorage.googleapis.com/v0/b/tatto-f6d81.appspot.com/o/Screenshot_3.png?alt=media&token=254b9b8d-dbf1-43c4-8bac-f61a2d05f823',
  )
];
