import 'package:flutter/material.dart';

/// Centraliza o conteúdo e limita a largura em telas grandes
/// (tablets/desktop), evitando listas e cards esticados de ponta a ponta.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveCenter({super.key, required this.child, this.maxWidth = 640});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
