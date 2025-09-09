import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authprovider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isFormValid = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _animationController.forward();

    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.contains('@');

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final success = await authProvider.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, '/users');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isTablet = width > 600;
    final isLargeScreen = width > 900;

    final cardWidth = isLargeScreen ? 450.0 : isTablet ? 400.0 : width * 0.9;
    final logoSize = isTablet ? 100.0 : 80.0;
    final titleFontSize = isLargeScreen ? 32.0 : isTablet ? 28.0 : 24.0;
    final subtitleFontSize = isTablet ? 18.0 : 16.0;
    final buttonHeight = isTablet ? 60.0 : 50.0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: cardWidth,
                    child: Card(
                      elevation: isTablet ? 12 : 8,
                      shadowColor: Colors.black.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor.withOpacity(0.95),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isTablet ? 32.0 : 28.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // App Logo with animation
                              TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 800),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: Container(
                                      width: logoSize,
                                      height: logoSize,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context).primaryColor,
                                            Theme.of(context).primaryColor.withOpacity(0.7),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).primaryColor.withOpacity(0.4),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.people_rounded,
                                        size: logoSize * 0.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: isTablet ? 32 : 24),


                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              SizedBox(height: isTablet ? 12 : 8),
                              Text(
                                'Sign in to continue to your account',
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isTablet ? 40 : 32),


                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [

                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(fontSize: isTablet ? 16 : 14),
                                        decoration: InputDecoration(
                                          labelText: 'Email Address',
                                          hintText: 'Enter your email',
                                          prefixIcon: Container(
                                            margin: const EdgeInsets.all(12),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.email_outlined,
                                              size: isTablet ? 20 : 18,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: isTablet ? 20 : 16,
                                            vertical: isTablet ? 20 : 16,
                                          ),
                                        ),
                                        validator: (value) => Provider.of<AuthProvider>(
                                          context,
                                          listen: false,
                                        ).validateEmail(value),
                                      ),
                                    ),
                                    SizedBox(height: isTablet ? 20 : 16),


                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscurePassword,
                                        style: TextStyle(fontSize: isTablet ? 16 : 14),
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          hintText: 'Enter your password',
                                          prefixIcon: Container(
                                            margin: const EdgeInsets.all(12),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.lock_outlined,
                                              size: isTablet ? 20 : 18,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              size: isTablet ? 24 : 20,
                                              color: Colors.grey.shade600,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword = !_obscurePassword;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade50,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: isTablet ? 20 : 16,
                                            vertical: isTablet ? 20 : 16,
                                          ),
                                        ),
                                        validator: (value) => Provider.of<AuthProvider>(
                                          context,
                                          listen: false,
                                        ).validatePassword(value),
                                      ),
                                    ),
                                    SizedBox(height: isTablet ? 32 : 24),


                                    Consumer<AuthProvider>(
                                      builder: (context, authProvider, child) {
                                        // Show error via SnackBar
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          if (authProvider.errorMessage.isNotEmpty) {
                                            _showErrorSnackBar(authProvider.errorMessage);
                                          }
                                        });

                                        return Container(
                                          width: double.infinity,
                                          height: buttonHeight,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                            gradient: _isFormValid && !authProvider.isLoading
                                                ? LinearGradient(
                                              colors: [
                                                Theme.of(context).primaryColor,
                                                Theme.of(context).primaryColor.withOpacity(0.8),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                                : null,
                                            color: !_isFormValid || authProvider.isLoading
                                                ? Colors.grey.shade300
                                                : null,
                                            boxShadow: _isFormValid && !authProvider.isLoading
                                                ? [
                                              BoxShadow(
                                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                                : null,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: (_isFormValid && !authProvider.isLoading) ? _login : null,
                                              borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                              child: Center(
                                                child: authProvider.isLoading
                                                    ? SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                      Colors.grey.shade600,
                                                    ),
                                                  ),
                                                )
                                                    : Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.login_rounded,
                                                      size: isTablet ? 22 : 20,
                                                      color: _isFormValid ? Colors.white : Colors.grey.shade600,
                                                    ),
                                                    SizedBox(width: isTablet ? 12 : 8),
                                                    Text(
                                                      'Sign In',
                                                      style: TextStyle(
                                                        fontSize: isTablet ? 18 : 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: _isFormValid ? Colors.white : Colors.grey.shade600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}