import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constants/constant_data.dart';
import '../constants/design_elements.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
  });

  final NoteItem note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${note.updatedAt.day.toString().padLeft(2, '0')}/${note.updatedAt.month.toString().padLeft(2, '0')}';

    final cardBrightness = ThemeData.estimateBrightnessForColor(note.color);
    final cardTextColor = cardBrightness == Brightness.dark ? Colors.white : Colors.black87;
    final chipBackground = cardBrightness == Brightness.dark
        ? cardTextColor.withOpacity(0.18)
        : Colors.white.withOpacity(0.94);
    final chipTextColor = cardBrightness == Brightness.dark ? cardTextColor : Colors.black87;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onDelete(),
              icon: Icons.delete_outline,
              label: 'Delete',
              borderRadius: BorderRadius.circular(24),
              backgroundColor: const Color(0xFFEF4444),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: note.color,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: chipBackground,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sticky_note_2,
                        color: cardTextColor,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        note.title,
                        style: noteTitleStyle.copyWith(color: cardTextColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: Text(
                    note.content,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: notePreviewStyle.copyWith(
                      color: cardTextColor.withOpacity(0.85),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(
                        note.category,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: chipTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      backgroundColor: chipBackground,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: cardTextColor.withOpacity(0.85),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
