import 'package:flutter/material.dart';

void main() {
  runApp(const UserPreferencesApp());
}

class UserPreferencesApp extends StatelessWidget {
  const UserPreferencesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        fontFamily: 'Roboto',
      ),
      home: const PreferencesScreen(),
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _notificationsEnabled = true;

  List<bool> _themeSelection = [false, true];

  String _selectedGender = 'Female';

  bool _acceptedTerms = true;

  double _fontSize = 20;

  final List<String> _interests = const [
    'Flutter',
    'AI',
    'Web Development',
    'Game Development',
  ];
  String _selectedInterest = 'Flutter';

  bool _showSavedBanner = true;

  int _currentStep = 1;

  final List<String> _stepLabels = const [
    'Personal Details',
    'Preferences',
    'Finish',
  ];

  void _resetPreferences() {
    setState(() {
      _notificationsEnabled = false;
      _themeSelection = [true, false];
      _selectedGender = 'Male';
      _acceptedTerms = false;
      _fontSize = 14;
      _selectedInterest = _interests.first;
      _showSavedBanner = false;
      _currentStep = 0;
    });
  }

  void _savePreferences() {
    setState(() {
      _showSavedBanner = true;
      if (_currentStep < _stepLabels.length - 1) {
        _currentStep++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2FD6),
        elevation: 0,
        title: const Text(
          'User Preferences',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _SectionCard(
            icon: Icons.notifications_none,
            iconColor: Colors.deepPurple,
            title: 'Enable Notifications',
            statusLabel: 'Notifications',
            statusValue: _notificationsEnabled ? 'Enabled' : 'Disabled',
            statusColor: _notificationsEnabled ? Colors.green : Colors.grey,
            trailing: Switch(
              value: _notificationsEnabled,
              activeColor: const Color(0xFF4A2FD6),
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
          ),

          _SectionCard(
            icon: Icons.palette_outlined,
            iconColor: Colors.orange,
            title: 'Choose Theme',
            statusLabel: 'Selected Mode',
            statusValue: _themeSelection[1] ? 'Dark' : 'Light',
            statusColor: Colors.deepPurple,
            content: ToggleButtons(
              isSelected: _themeSelection,
              borderRadius: BorderRadius.circular(24),
              selectedColor: Colors.white,
              fillColor: const Color(0xFF4A2FD6),
              color: Colors.deepPurple,
              constraints: const BoxConstraints(minHeight: 40, minWidth: 110),
              onPressed: (index) {
                setState(() {
                  _themeSelection = [index == 0, index == 1];
                });
              },
              children: const [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wb_sunny, size: 18),
                    SizedBox(width: 6),
                    Text('Light'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.nightlight_round, size: 18),
                    SizedBox(width: 6),
                    Text('Dark'),
                  ],
                ),
              ],
            ),
          ),

          _SectionCard(
            icon: Icons.person_outline,
            iconColor: Colors.pink,
            title: 'Select Gender',
            statusLabel: 'Selected Gender',
            statusValue: _selectedGender,
            statusColor: Colors.deepPurple,
            content: Row(
              children: ['Male', 'Female', 'Other'].map((gender) {
                return Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(gender, style: const TextStyle(fontSize: 13)),
                    value: gender,
                    groupValue: _selectedGender,
                    activeColor: const Color(0xFF4A2FD6),
                    onChanged: (value) {
                      setState(() => _selectedGender = value!);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          _SectionCard(
            icon: null,
            leading: Checkbox(
              value: _acceptedTerms,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() => _acceptedTerms = value!);
              },
            ),
            title: null,
            titleWidget: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 15),
                children: [
                  const TextSpan(text: 'I accept the '),
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: const TextStyle(
                      color: Color(0xFF4A2FD6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            statusLabel: 'Status',
            statusValue: _acceptedTerms ? 'Accepted' : 'Not Accepted',
            statusColor: _acceptedTerms ? Colors.green : Colors.red,
          ),

          _SectionCard(
            icon: Icons.text_fields,
            iconColor: Colors.blue,
            title: 'Font Size (Sample Text)',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text('10', style: TextStyle(color: Colors.grey)),
                    Expanded(
                      child: Slider(
                        value: _fontSize,
                        min: 10,
                        max: 30,
                        activeColor: const Color(0xFF4A2FD6),
                        onChanged: (value) {
                          setState(() => _fontSize = value);
                        },
                      ),
                    ),
                    const Text('30', style: TextStyle(color: Colors.grey)),
                    const SizedBox(width: 8),
                    Text(
                      'Current Size: ${_fontSize.round()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Flutter is Awesome!',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                ),
              ],
            ),
          ),

          _SectionCard(
            icon: Icons.favorite_border,
            iconColor: Colors.purple,
            title: 'Choose Your Interests (Select One)',
            statusLabel: 'Selected Interest',
            statusValue: _selectedInterest,
            statusColor: Colors.deepPurple,
            content: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _interests.map((interest) {
                final bool selected = interest == _selectedInterest;
                return ChoiceChip(
                  label: Text(interest),
                  selected: selected,
                  showCheckmark: true,
                  selectedColor: const Color(0xFF4A2FD6),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.deepPurple,
                  ),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF4A2FD6)),
                  onSelected: (_) {
                    setState(() => _selectedInterest = interest);
                  },
                );
              }).toList(),
            ),
          ),

          _SectionCard(
            icon: Icons.bolt,
            iconColor: Colors.amber,
            title: 'Quick Actions',
            content: Row(
              children: [
                ActionChip(
                  avatar: const Icon(Icons.refresh, size: 18),
                  label: const Text('Reset'),
                  onPressed: _resetPreferences,
                ),
                const SizedBox(width: 12),
                ActionChip(
                  avatar: const Icon(Icons.save, size: 18, color: Colors.white),
                  label: const Text('Save', style: TextStyle(color: Colors.white)),
                  backgroundColor: const Color(0xFF4A2FD6),
                  onPressed: _savePreferences,
                ),
              ],
            ),
          ),

          if (_showSavedBanner)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Preferences Saved Successfully!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _showSavedBanner = false),
                    child: const Text(
                      'DISMISS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          _SectionCard(
            icon: Icons.list_alt,
            iconColor: Colors.indigo,
            title: 'Profile Completion',
            content: _HorizontalStepper(
              labels: _stepLabels,
              currentStep: _currentStep,
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cancelled')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF4A2FD6)),
                    ),
                    child: const Text('CANCEL'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _savePreferences,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A2FD6),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('CONTINUE'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Widget? leading;
  final String? title;
  final Widget? titleWidget;
  final Widget? content;
  final Widget? trailing;
  final String? statusLabel;
  final String? statusValue;
  final Color? statusColor;

  const _SectionCard({
    this.icon,
    this.iconColor,
    this.leading,
    this.title,
    this.titleWidget,
    this.content,
    this.trailing,
    this.statusLabel,
    this.statusValue,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEDEDF2))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              leading ??
                  (icon != null
                      ? Icon(icon, color: iconColor, size: 22)
                      : const SizedBox.shrink()),
              if (leading != null || icon != null) const SizedBox(width: 10),
              Expanded(
                child: titleWidget ??
                    Text(
                      title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (content != null) ...[
            const SizedBox(height: 10),
            content!,
          ],
          if (statusLabel != null) ...[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                  children: [
                    TextSpan(text: '$statusLabel : '),
                    TextSpan(
                      text: statusValue,
                      style: TextStyle(
                        color: statusColor ?? Colors.deepPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HorizontalStepper extends StatelessWidget {
  final List<String> labels;
  final int currentStep;

  const _HorizontalStepper({
    required this.labels,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(labels.length * 2 - 1, (i) {
        if (i.isOdd) {
          final int leftStep = i ~/ 2;
          final bool lineDone = leftStep < currentStep;
          return Expanded(
            child: Container(
              height: 2,
              color: lineDone ? const Color(0xFF4A2FD6) : Colors.grey.shade300,
            ),
          );
        }
        final int step = i ~/ 2;
        final bool done = step < currentStep;
        final bool active = step == currentStep;
        final Color bg = done || active
            ? const Color(0xFF4A2FD6)
            : Colors.grey.shade400;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: bg,
              child: Text(
                '${step + 1}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              labels[step],
              style: TextStyle(
                fontSize: 10,
                color: active ? const Color(0xFF4A2FD6) : Colors.grey,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        );
      }),
    );
  }
}