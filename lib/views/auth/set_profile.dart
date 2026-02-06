

// lib/views/auth/set_profile_all_screens.dart

import 'package:dating_app/views/languages/select_language_screen.dart';
import 'package:dating_app/views/navbar/navbar_screen.dart';
import 'package:dating_app/widgets/voice_input_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dating_app/providers/auth_provider.dart';

/// =======================
/// 1) SET PROFILE SCREEN
/// =======================
class SetProfile extends StatefulWidget {
  const SetProfile({super.key});

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  /// Internal gender value used for logic & avatars: 'Girl' or 'Boy'
  String? selectedGender;

  /// Computed text shown in the "Who are you?" field
  String get selectedGenderLabel {
    if (selectedGender == 'Girl') return 'Female';
    if (selectedGender == 'Boy') return 'Male';
    return 'Select';
  }

  DateTime? selectedDOB;

  // Text controllers for fields with mic
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nickNameController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  void _continuePressed() {
    // same UI behaviour + a bit of validation so provider doesn't crash
    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your gender first')),
      );
      return;
    }

    if (selectedDOB == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your date of birth')),
      );
      return;
    }

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    // 👉 Save to AuthProvider (no UI change)
    context.read<AuthProvider>().setBasicProfileInfo(
          name: _nameController.text.trim(),
          nickname: _nickNameController.text.trim(),
          genderInternal: selectedGender!, // 'Girl' / 'Boy'
          dob: selectedDOB!,
          referralCode: _referralController.text.trim(),
        );

    _showAvatarSelectionScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onBackground;
    final primary = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Set Profile',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                context: context,
                label: 'Name',
                hint: 'Enter your name',
                icon: Icons.person_outline,
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context: context,
                label: 'Nick Name',
                hint: 'Enter Nick name',
                icon: Icons.person_outline,
                controller: _nickNameController,
              ),
              const SizedBox(height: 16),

              // Gender field (opens modal, not typable)
              _buildGenderField(context),
              const SizedBox(height: 16),

              _buildDOBPicker(context),
              const SizedBox(height: 16),

              _buildTextField(
                context: context,
                label: 'Referral code',
                hint: 'Referral code',
                icon: Icons.card_giftcard_outlined,
                controller: _referralController,
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continuePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // WHO ARE YOU?  -> opens gender modal (not typable)
  // ---------------------------------------------------------------------------
  Widget _buildGenderField(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onBackground;
    final cardColor = theme.cardColor;

    final isSelected = selectedGender != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who are you?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _showGenderSelectionDialog(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person_outline,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : Colors.grey.shade400,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  selectedGenderLabel,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? textColor : Colors.grey.shade500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // DATE PICKER
  // ---------------------------------------------------------------------------
  Widget _buildDOBPicker(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onBackground;
    final cardColor = theme.cardColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of birth',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1970),
              lastDate: DateTime.now(),
            );

            if (picked != null) {
              setState(() {
                selectedDOB = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    color: Colors.grey.shade400, size: 20),
                const SizedBox(width: 12),
                Text(
                  selectedDOB == null
                      ? 'Select'
                      : '${selectedDOB!.day}/${selectedDOB!.month}/${selectedDOB!.year}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const Spacer(),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Generic TextField builder (with mic)
  // ---------------------------------------------------------------------------
  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onBackground;
    final cardColor = theme.cardColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
              // Mic button here
              suffixIcon: VoiceInputButton(controller: controller),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Gender Selection Dialog
  // ---------------------------------------------------------------------------
  void _showGenderSelectionDialog(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    String? tempSelected = selectedGender; // local state for dialog

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select your gender',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildGenderOption(
                          label: 'Girl',
                          imagePath: 'assets/womenicon.png',
                          bgColor: Colors.pink.shade100,
                          iconColor: Colors.pink,
                          isSelected: tempSelected == 'Girl',
                          onTap: () {
                            setStateDialog(() {
                              tempSelected = 'Girl';
                            });
                          },
                        ),
                        _buildGenderOption(
                          label: 'Boy',
                          imagePath: 'assets/manicon.png',
                          bgColor: Colors.blue.shade100,
                          iconColor: Colors.blue,
                          isSelected: tempSelected == 'Boy',
                          onTap: () {
                            setStateDialog(() {
                              tempSelected = 'Boy';
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.yellow.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange.shade400,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Select your Original Gender otherwise your account will be block',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: tempSelected != null
                            ? () {
                                // Save to main state, close dialog
                                setState(() {
                                  selectedGender = tempSelected;
                                });
                                Navigator.pop(dialogContext);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          disabledBackgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAvatarSelectionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvatarSelectionScreen(gender: selectedGender!),
      ),
    );
  }

  Widget _buildGenderOption({
    required String label,
    required String imagePath,
    required Color bgColor,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? iconColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 48, height: 48),
            const SizedBox(height: 8),
            Text(
              'Iam $label',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// 2) AVATAR SELECTION
/// =======================

// ---------------------------------------------------------------------------
class AvatarSelectionScreen extends StatefulWidget {
  final String gender; // 'Girl' or 'Boy'

  const AvatarSelectionScreen({super.key, required this.gender});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? selectedAvatarIndex;

  List<String> get avatarPaths {
    if (widget.gender == 'Girl') {
      return [
        'assets/girlimage1.png',
        'assets/girlimage2.png',
        'assets/girlimage3.png',
        'assets/girlimage4.png',
      ];
    } else {
      return [
        'assets/boyimage1.png',
        'assets/boyimage2.png',
        'assets/boyimage3.png',
        'assets/boyimage1.png',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select your Avatar',
          style: TextStyle(
            color: theme.colorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: avatarPaths.length,
                  itemBuilder: (context, index) {
                    return _buildAvatarOption(index);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedAvatarIndex != null
                      ? () async {
                          // 👇 Convert asset to File and store in provider
                          final auth =
                              context.read<AuthProvider>();

                          final assetPath =
                              avatarPaths[selectedAvatarIndex!];

                          await auth.setAvatarFromAsset(assetPath);

                          // then go to language screen (same as before)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectLanguageScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarOption(int index) {
    final isSelected = selectedAvatarIndex == index;
    final isGirl = widget.gender == 'Girl';
    final highlightColor = isGirl ? Colors.pink : Colors.blue;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAvatarIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? highlightColor : Colors.transparent,
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Image.asset(avatarPaths[index], fit: BoxFit.cover),
              ),
            ),
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


/// =======================
/// 3) LANGUAGE SCREEN
/// =======================
class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {"symbol": "En", "name": "English"},
    {"symbol": "हि", "name": "Hindi"},
    {"symbol": "తె", "name": "Telugu"},
    {"symbol": "ಕ", "name": "Kannada"},
    {"symbol": "മ", "name": "Malayalam"},
    {"symbol": "தமிழ்", "name": "Tamil"},
  ];

  void _continue() {
    // 👉 Save language into provider (no UI change)
    context.read<AuthProvider>().setLanguage(selectedLanguage);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WarningScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select your language',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // ⭐ 2 columns
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.7, // adjust height
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return _buildLanguageButton(
                    symbol: languages[index]["symbol"]!,
                    language: languages[index]["name"]!,
                    isSelected: selectedLanguage == languages[index]["name"],
                    onTap: () {
                      setState(() {
                        selectedLanguage = languages[index]["name"]!;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE0A62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton({
    required String symbol,
    required String language,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFFFF0066) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    symbol,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color:
                          isSelected ? const Color(0xFFFF0066) : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    language,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? const Color(0xFFFF0066) : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF0066),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// 4) WARNING SCREEN
/// =======================
class WarningScreen extends StatefulWidget {
  const WarningScreen({super.key});

  @override
  State<WarningScreen> createState() => _WarningScreenState();
}

class _WarningScreenState extends State<WarningScreen> {
  bool isChecked = false;

  Future<void> _submit() async {
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the warning before continuing.'),
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.completeProfile(context);

    if (!mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Warning',
                style: TextStyle(
                  color: Color(0xFFFFA500),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/warningimage.png'),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'If I misbehave with any user, I can be permanently blocked from this app.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isChecked ? const Color(0xFFFE0A62) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
