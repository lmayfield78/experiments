import 'package:company_profile_template/model/company.dart';

class RepoData {
  static final Company bawl = Company(
      name: "Law's Template App",
      location: "Austin, TX",
      logo: 'assets/logo.png',
      backDropPhoto: 'assets/bawp_creator.png',
      about: 'This is some wonderful text talking about what this app is about.',
      courses: <Course>[
        Course(
            title: 'Science Based Sixpack',
            thumbnail: 'assets/android_bootcamp.png',
            url: "https://shop.sixpackabs.com/shop/product/science-based-sixpack"),
        Course(
            title: 'Ignite TDX',
            thumbnail: 'assets/kotlin.png',
            url: 'https://google.com'),
        Course(
            title: 'Monster Mass',
            thumbnail: 'assets/java_design-pats.png',
            url: 'https://shop.sixpackabs.com/shop/product/monster-mass')
      ]



  );
}