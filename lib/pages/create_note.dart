import 'package:flutter/material.dart';
import '../constants/constant_data.dart';
import '../constants/design_elements.dart';
import '../services/firestore_notes.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key, this.note});

  final NoteItem? note;

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Color _selectedColor;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.note?.color ?? noteColors[4];
    _selectedCategory = widget.note?.category ?? noteCategories[1];
    _titleController.text = widget.note?.title ?? '';
    _contentController.text = widget.note?.content ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState?.validate() ?? false) {
      final note = NoteItem(
        id: widget.note?.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        color: _selectedColor,
        category: _selectedCategory,
        updatedAt: DateTime.now(),
      );

      if (widget.note == null) {
        await FirestoreNotes.addNote(note);
      } else {
        await FirestoreNotes.updateNote(note);
      }

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Create note' : 'Edit note'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _saveNote,
            child: const Text('Save'),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Give your note a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          hintText: 'Write your note here...',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: null,
                        minLines: 10,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 18),
                      Text('Select a note color', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 56,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: noteColors.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final color = noteColors[index];
                            final selected = color == _selectedColor;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedColor = color),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: selected ? 54 : 46,
                                height: selected ? 54 : 46,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: color.withOpacity(0.25),
                                            blurRadius: 12,
                                            offset: const Offset(0, 6),
                                          )
                                        ]
                                      : null,
                                  border: Border.all(
                                    color: selected
                                        ? Theme.of(context).colorScheme.onSurface
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text('Category', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: noteCategories
                            .where((category) => category != noteCategories.first)
                            .map((category) {
                          final selected = category == _selectedCategory;
                          return ChoiceChip(
                            label: Text(category),
                            selected: selected,
                            onSelected: (_) => setState(() {
                              _selectedCategory = category;
                            }),
                            selectedColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.24),
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            labelStyle: TextStyle(
                              color: selected
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: _saveNote,
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('Save note'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
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
    );
  }
}

/*
AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Color.fromARGB(255, 226, 226, 226).withOpacity(0.5)),
                  child: Image.asset(
                    "assets/icons/save.png",
                    width: 30,
                    height: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ]),
 */
/*

  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tileColor.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5),
                    child: ColoredCircle(colorNumber: index),
                  );
                }),

 */