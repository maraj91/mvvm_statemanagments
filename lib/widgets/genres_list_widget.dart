import 'package:flutter/material.dart';

class GenresListWidget extends StatefulWidget {
  const GenresListWidget({super.key, required this.genres});

  final List<String> genres;

  @override
  State<GenresListWidget> createState() => _GenresListWidgetState();
}

class _GenresListWidgetState extends State<GenresListWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.genres.length,
        (index) => chipWidget(widget.genres[index], context),
      ),
    );
  }
}

Widget chipWidget(String genre, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.4),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Text(
          genre,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}
