import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/usermodel.dart';
import '../providers/authprovider.dart';
import '../providers/themeprovider.dart';
import '../providers/userprovider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  void _initializeData() {
    if (!_isInitialized) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (!userProvider.hasUsers) {
        userProvider.fetchUsers();
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

           if (_searchController.text.isNotEmpty) {
        _searchController.clear();
        userProvider.clearSearch();
      }

      await userProvider.refresh();


      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                const Text('Users refreshed successfully'),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to refresh users. Please try again.');
      }
    }
  }

  void _onUserTap(User user) {
    Navigator.pushNamed(context, '/user-detail', arguments: user);
  }

  void _onLogout() {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: isTablet ? 16 : 14),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                final auth = Provider.of<AuthProvider>(context, listen: false);
                await auth.logout();
                if (mounted) Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                if (mounted) {
                  _showErrorSnackBar('Failed to logout');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Logout',
              style: TextStyle(fontSize: isTablet ? 16 : 14),
            ),
          ),
        ],
      ),
    );
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

    final appBarHeight = isLargeScreen ? 80.0 : isTablet ? 70.0 : 56.0;
    final titleFontSize = isLargeScreen ? 28.0 : isTablet ? 24.0 : 20.0;
    final searchPadding = isTablet ? 24.0 : 16.0;
    final cardPadding = isTablet ? 20.0 : 16.0;
    final avatarSize = isTablet ? 60.0 : 50.0;
    final iconSize = isTablet ? 28.0 : 24.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            centerTitle: isTablet,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(isTablet ? 12 : 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.people_rounded,
                    size: isTablet ? 24 : 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: isTablet ? 16 : 12),
                Text(
                  'Users',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            actions: [
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 4),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.refresh_rounded,
                            size: iconSize,
                            color: Colors.white,
                          ),
                          onPressed: userProvider.isLoading ? null : _onRefresh,
                          tooltip: 'Refresh',
                        ),
                        if (userProvider.isLoading && userProvider.hasUsers)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 12,
                              height: 12,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 4),
                    child: IconButton(
                      icon: Icon(
                        themeProvider.isDarkMode
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        size: iconSize,
                        color: Colors.white,
                      ),
                      onPressed: themeProvider.toggleTheme,
                      tooltip: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 4),
                child: IconButton(
                  icon: Icon(
                    Icons.logout_rounded,
                    size: iconSize,
                    color: Colors.white,
                  ),
                  onPressed: _onLogout,
                  tooltip: 'Logout',
                ),
              ),
              SizedBox(width: isTablet ? 16 : 8),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.all(searchPadding),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(fontSize: isTablet ? 16 : 14),
                  decoration: InputDecoration(
                    hintText: 'Search users by name, email, username...',
                    hintStyle: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      color: Colors.grey.shade500,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: isTablet ? 24 : 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(
                        Icons.clear_rounded,
                        size: isTablet ? 24 : 20,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        Provider.of<UserProvider>(context, listen: false)
                            .clearSearch();
                        FocusScope.of(context).unfocus();
                      },
                    )
                        : null,
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
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 20 : 16,
                      vertical: isTablet ? 18 : 14,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {}); // Update suffixIcon visibility
                    Provider.of<UserProvider>(context, listen: false)
                        .searchUsers(value);
                  },
                ),
              ),
            ),

            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (userProvider.errorMessage.isNotEmpty && userProvider.hasUsers) {
                      _showErrorSnackBar(userProvider.errorMessage);
                    }
                  });

                  if (userProvider.isLoading && !userProvider.hasUsers) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: isTablet ? 80 : 60,
                            height: isTablet ? 80 : 60,
                            child: CircularProgressIndicator(
                              strokeWidth: isTablet ? 6 : 4,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: isTablet ? 24 : 16),
                          Text(
                            'Loading users...',
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                          SizedBox(height: isTablet ? 12 : 8),
                          Text(
                            'Please wait while we fetch the user data',
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (userProvider.errorMessage.isNotEmpty && !userProvider.hasUsers) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: Theme.of(context).primaryColor,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(isTablet ? 32 : 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      size: isTablet ? 80 : 64,
                                      color: Colors.red.shade400,
                                    ),
                                  ),
                                  SizedBox(height: isTablet ? 24 : 16),
                                  Text(
                                    'Oops! Something went wrong',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isTablet ? 24 : 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: isTablet ? 12 : 8),
                                  Text(
                                    userProvider.errorMessage,
                                    style: TextStyle(
                                      fontSize: isTablet ? 16 : 14,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: isTablet ? 16 : 12),
                                  Text(
                                    'Pull down to refresh or tap the button below',
                                    style: TextStyle(
                                      fontSize: isTablet ? 14 : 12,
                                      color: Colors.grey.shade500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: isTablet ? 32 : 24),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      try {
                                        await userProvider.retry();
                                      } catch (e) {
                                        _showErrorSnackBar('Failed to retry');
                                      }
                                    },
                                    icon: Icon(
                                      Icons.refresh_rounded,
                                      size: isTablet ? 20 : 18,
                                    ),
                                    label: Text(
                                      'Try Again',
                                      style: TextStyle(fontSize: isTablet ? 16 : 14),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 32 : 24,
                                        vertical: isTablet ? 16 : 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
                                      ),
                                      backgroundColor: Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (userProvider.users.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: Theme.of(context).primaryColor,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(isTablet ? 24 : 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.people_outline_rounded,
                                    size: isTablet ? 80 : 64,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                SizedBox(height: isTablet ? 24 : 16),
                                Text(
                                  'No users found',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 24 : 20,
                                  ),
                                ),
                                SizedBox(height: isTablet ? 12 : 8),
                                Text(
                                  _searchController.text.isNotEmpty
                                      ? 'Try adjusting your search terms'
                                      : 'No users available at the moment',
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    color: Colors.grey.shade500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: isTablet ? 8 : 6),
                                Text(
                                  'Pull down to refresh',
                                  style: TextStyle(
                                    fontSize: isTablet ? 14 : 12,
                                    color: Colors.grey.shade400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                    strokeWidth: 2.5,
                    displacement: 40.0,
                    child: Column(
                      children: [

                        if (_searchController.text.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: searchPadding,
                              vertical: isTablet ? 12 : 8,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  size: isTablet ? 18 : 16,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(width: isTablet ? 8 : 6),
                                Text(
                                  'Found ${userProvider.users.length} users',
                                  style: TextStyle(
                                    fontSize: isTablet ? 14 : 12,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: searchPadding),
                            itemCount: userProvider.users.length,
                            itemBuilder: (context, index) {
                              final user = userProvider.users[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: isTablet ? 16 : 12),
                                child: Card(
                                  elevation: 3,
                                  shadowColor: Colors.black.withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                  ),
                                  child: InkWell(
                                    onTap: () => _onUserTap(user),
                                    borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                    child: Padding(
                                      padding: EdgeInsets.all(cardPadding),
                                      child: Row(
                                        children: [

                                          Container(
                                            width: avatarSize,
                                            height: avatarSize,
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
                                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                user.name.isNotEmpty
                                                    ? user.name[0].toUpperCase()
                                                    : 'U',
                                                style: TextStyle(
                                                  fontSize: avatarSize * 0.4,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: isTablet ? 20 : 16),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user.name,
                                                  style: TextStyle(
                                                    fontSize: isTablet ? 18 : 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: isTablet ? 6 : 4),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.email_outlined,
                                                      size: isTablet ? 16 : 14,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                    SizedBox(width: isTablet ? 6 : 4),
                                                    Expanded(
                                                      child: Text(
                                                        user.email,
                                                        style: TextStyle(
                                                          fontSize: isTablet ? 15 : 14,
                                                          color: Colors.grey.shade600,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: isTablet ? 4 : 2),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone_outlined,
                                                      size: isTablet ? 16 : 14,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                    SizedBox(width: isTablet ? 6 : 4),
                                                    Expanded(
                                                      child: Text(
                                                        user.phone,
                                                        style: TextStyle(
                                                          fontSize: isTablet ? 15 : 14,
                                                          color: Colors.grey.shade600,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            padding: EdgeInsets.all(isTablet ? 8 : 6),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(isTablet ? 8 : 6),
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: isTablet ? 18 : 16,
                                              color: Theme.of(context).primaryColor,
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}