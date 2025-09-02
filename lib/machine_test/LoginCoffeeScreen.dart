import 'package:bloc_demo/machine_test/RegisterScreen.dart';
import 'package:flutter/material.dart';

import 'CoffeeLoginScreen.dart';

class CoffeeOnboardingScreen extends StatelessWidget {
  const CoffeeOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:const Color(0x000000),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF5A3E2B),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [

              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/image9.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),


              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF5A3E2B).withOpacity(0.1),
                        const Color(0xFF5A3E2B).withOpacity(0.3),
                        const Color(0xFF5A3E2B).withOpacity(0.7),
                        const Color(0xFF5A3E2B).withOpacity(0.95),
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                ),
              ),


              Padding(
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.08, // 8% horizontal padding
                  size.height * 0.07, // top padding relative to screen
                  size.width * 0.08,
                  size.height * 0.05, // bottom padding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Row(
                      children: [
                        _buildProgressDot(true),
                        const SizedBox(width: 8),
                        _buildProgressDot(false),
                        const SizedBox(width: 8),
                        _buildProgressDot(false),
                      ],
                    ),

                    const Spacer(),


                    Column(
                      children: [

                        Text(
                          'Unlock bean\nsecrets',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.12, // responsive font size
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.1,
                            shadows: const [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 10,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height * 0.03),


                        Text(
                          'Lorem ipsum dolor sit amet consectetur.\nVestibulum eget blandit mattis',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            color: const Color(0xCCFFFFFF),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.1),

                    Column(
                      children: [
                                             SizedBox(
                          width: double.infinity,
                          height: size.height * 0.065,
                          child: ElevatedButton(
                            onPressed: () {
                                                   Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen(),));
                                                        },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD4A574),
                              foregroundColor: const Color(0xFF5A3E2B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.02),
                        SizedBox(
                          width: double.infinity,
                          height: size.height * 0.065,
                          child: OutlinedButton(
                            onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => CoffeeLoginScreen(),));
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(
                                color: Color(0xFFD4A574),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressDot(bool isActive) {
    return Container(
      width: 24,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: isActive
            ? const Color(0xFFD4A574)
            : Colors.white.withOpacity(0.3),
      ),
    );
  }
}
