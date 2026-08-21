import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController pageController = PageController();

  int currentPage = 0;

  final List<Map<String, String>> pages = [

    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Find Your Next\nFavorite Movie Here',
      'description':
      'Get access to a huge library of movies to suit your taste. You will surely like it.',
    },

    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Discover Movies',
      'description':
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    },

    {
      'image': 'assets/images/onboarding3.png',
      'title': 'Explore All Genres',
      'description':
      'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    },

    {
      'image': 'assets/images/onboarding4.png',
      'title': 'Create Watchlists',
      'description':
      'Save movies to your watchlist to keep track of what you want to watch next.',
    },

    {
      'image': 'assets/images/onboarding5.png',
      'title': 'Rate, Review, and Learn',
      'description':
      'Share your thoughts on the movies you watched and help others discover great movies.',
    },

    {
      'image': 'assets/images/onboarding6.png',
      'title': 'Enjoy Your Movies',
      'description':
      'Choose your favorite movie and enjoy watching it anytime you want.',
    },
  ];

  // Next Page
  void nextPage() {
    if (currentPage < pages.length - 1) {

      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

    } else {

      print('Finish');

    }
  }

  // Previous Page
  void previousPage() {
    if (currentPage > 0) {

      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff121212),

      body: PageView.builder(
        controller: pageController,

        itemCount: pages.length,

        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },

        itemBuilder: (context, index) {

          return Stack(
            children: [

              // Background Image
              SizedBox(
                width: double.infinity,
                height: double.infinity,

                child: Image.asset(
                  pages[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),

              // Dark Gradient
              Container(
                width: double.infinity,
                height: double.infinity,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,

                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      const Color(0xff121212),
                    ],

                    stops: const [
                      0.4,
                      0.6,
                      0.9,
                    ],
                  ),
                ),
              ),

              // Bottom Content
              Align(
                alignment: Alignment.bottomCenter,

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.fromLTRB(
                    25,
                    20,
                    25,
                    25,
                  ),

                  decoration: const BoxDecoration(
                    color: Color(0xff121212),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [

                      // Title
                      Text(
                        pages[index]['title']!,
                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Description
                      Text(
                        pages[index]['description']!,
                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Next Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,

                        child: ElevatedButton(
                          onPressed: nextPage,

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xffffc107),

                            foregroundColor: Colors.black,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                          ),

                          child: Text(
                            currentPage == 0
                                ? 'Explore Now'
                                : currentPage ==
                                pages.length - 1
                                ? 'Finish'
                                : 'Next',

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Back Button
                      if (currentPage > 0)
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 8),

                          child: SizedBox(
                            width: double.infinity,
                            height: 40,

                            child: OutlinedButton(
                              onPressed: previousPage,

                              style:
                              OutlinedButton.styleFrom(
                                foregroundColor:
                                const Color(0xffffc107),

                                side: const BorderSide(
                                  color: Color(0xffffc107),
                                ),

                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                ),
                              ),

                              child: const Text(
                                'Back',
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 15),

                      // Page Indicator
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: List.generate(
                          pages.length,

                              (dotIndex) {

                            return Container(
                              margin:
                              const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),

                              width:
                              currentPage == dotIndex
                                  ? 18
                                  : 6,

                              height: 6,

                              decoration: BoxDecoration(
                                color:
                                currentPage == dotIndex
                                    ? const Color(
                                    0xffffc107)
                                    : Colors.white30,

                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}