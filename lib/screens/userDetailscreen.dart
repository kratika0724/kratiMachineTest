import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/usermodel.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;


    final isTablet = width > 600;
    final isLargeScreen = width > 900;


    final avatarSize = isLargeScreen ? 120.0 : isTablet ? 100.0 : 80.0;
    final titleFontSize = isLargeScreen ? 28.0 : isTablet ? 24.0 : 22.0;
    final subtitleFontSize = isLargeScreen ? 18.0 : isTablet ? 16.0 : 14.0;
    final bodyFontSize = isLargeScreen ? 16.0 : isTablet ? 15.0 : 14.0;
    final smallFontSize = isLargeScreen ? 14.0 : isTablet ? 13.0 : 12.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: height * 0.35,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.02),
                      // User Avatar
                      Container(
                        width: avatarSize,
                        height: avatarSize,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                            style: TextStyle(
                              fontSize: avatarSize * 0.4,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Text(
                        '@${user.username}',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                children: [
                  SizedBox(height: height * 0.01),

                  _buildSection(
                    context: context,
                    title: 'Contact Information',
                    icon: Icons.contact_phone_rounded,
                    children: [
                      _buildContactTile(
                        context: context,
                        icon: Icons.email_rounded,
                        label: 'Email',
                        value: user.email,
                        onTap: () => _copyToClipboard(context, user.email, 'Email'),
                        fontSize: bodyFontSize,
                      ),
                      _buildContactTile(
                        context: context,
                        icon: Icons.phone_rounded,
                        label: 'Phone',
                        value: user.phone,
                        onTap: () => _copyToClipboard(context, user.phone, 'Phone'),
                        fontSize: bodyFontSize,
                      ),
                      _buildContactTile(
                        context: context,
                        icon: Icons.language_rounded,
                        label: 'Website',
                        value: user.website,
                        onTap: () => _copyToClipboard(context, user.website, 'Website'),
                        fontSize: bodyFontSize,
                      ),
                    ],
                    width: width,
                    height: height,
                  ),

                  SizedBox(height: height * 0.025),

                  _buildSection(
                    context: context,
                    title: 'Address Information',
                    icon: Icons.location_on_rounded,
                    children: [
                      _buildAddressInfo(context, width, height, bodyFontSize, smallFontSize),
                    ],
                    width: width,
                    height: height,
                  ),

                  SizedBox(height: height * 0.025),

                  _buildSection(
                    context: context,
                    title: 'Company Information',
                    icon: Icons.business_rounded,
                    children: [
                      _buildCompanyInfo(context, width, height, bodyFontSize, smallFontSize),
                    ],
                    width: width,
                    height: height,
                  ),

                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
    required double width,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(width * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(width * 0.02),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(width * 0.02),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: width * 0.06,
                  ),
                ),
                SizedBox(width: width * 0.03),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.045,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required double fontSize,
  }) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: fontSize * 0.85,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.copy_rounded,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressInfo(BuildContext context, double width, double height, double fontSize, double smallFontSize) {
    return Container(
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddressRow(
            context: context,
            icon: Icons.home_rounded,
            label: 'Street Address',
            value: '${user.address.street}, ${user.address.suite}',
            fontSize: fontSize,
          ),
          SizedBox(height: height * 0.01),
          _buildAddressRow(
            context: context,
            icon: Icons.location_city_rounded,
            label: 'City',
            value: user.address.city,
            fontSize: fontSize,
          ),
          SizedBox(height: height * 0.01),
          _buildAddressRow(
            context: context,
            icon: Icons.markunread_mailbox_rounded,
            label: 'Zip Code',
            value: user.address.zipcode,
            fontSize: fontSize,
          ),
          if (user.address.geo.lat.isNotEmpty && user.address.geo.lng.isNotEmpty) ...[
            SizedBox(height: height * 0.01),
            _buildAddressRow(
              context: context,
              icon: Icons.gps_fixed_rounded,
              label: 'Coordinates',
              value: '${user.address.geo.lat}, ${user.address.geo.lng}',
              fontSize: fontSize,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddressRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required double fontSize,
  }) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize * 0.85,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyInfo(BuildContext context, double width, double height, double fontSize, double smallFontSize) {
    return Container(
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCompanyRow(
            context: context,
            icon: Icons.business_center_rounded,
            label: 'Company Name',
            value: user.company.name,
            fontSize: fontSize,
          ),
          SizedBox(height: height * 0.015),
          _buildCompanyRow(
            context: context,
            icon: Icons.format_quote_rounded,
            label: 'Catch Phrase',
            value: user.company.catchPhrase,
            fontSize: fontSize,
          ),
          SizedBox(height: height * 0.015),
          _buildCompanyRow(
            context: context,
            icon: Icons.work_outline_rounded,
            label: 'Business',
            value: user.company.bs,
            fontSize: fontSize,
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required double fontSize,
  }) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize * 0.85,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}