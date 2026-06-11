import 'package:flutter/material.dart';

const Map<String, IconData> _kPolicyIcons = {
  'policy.rules': Icons.rule,
  'policy.cleaning': Icons.cleaning_services,
  'policy.pets': Icons.pets,
  'policy.security': Icons.security,
  'policy.parking': Icons.local_parking,
};

IconData iconForPolicy(String code) =>
    _kPolicyIcons[code.trim().toLowerCase()] ?? Icons.policy_outlined;
