
// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:lab_money_5/enums/category_type.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lab_money_5/localization/category_type_localization.dart';
import 'package:lab_money_5/repositories/category_repository/DTO/category.dart';
import 'package:lab_money_5/repositories/category_repository/category_repository.dart';
import 'package:lab_money_5/repositories/category_repository/errors/category_update_errors.dart';
import 'package:lab_money_5/repositories/category_repository/view_models/category_update_view_model.dart';

class CategoryUpdatingPage extends StatefulWidget
{
  final int categoryId;
  final CategoryRepository categories;
  final void Function() onUpdate;

  const CategoryUpdatingPage({super.key, required this.categoryId, required this.categories, required this.onUpdate});

  @override
  State<StatefulWidget> createState() => CategoryUpdatingPageState();
}

class CategoryUpdatingPageState extends State<CategoryUpdatingPage>
{
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  Color _color = Colors.blue;
  CategoryType _type = CategoryType.loss;
  String _nameValidationErrorText = '';

  @override
  void initState()
  {
    super.initState();

    Category category = widget.categories.get(widget.categoryId)!;
    _name = category.getName();
    _color = category.getColor();
    _type = category.getType();
  }

  List<DropdownMenuItem<CategoryType>> _getCategoryTypes()
  {
    return CategoryType.values.map((CategoryType type)
    {
      return DropdownMenuItem<CategoryType>(
        value: type,
        child: Text(CategoryTypeLocalization.localize(type)),
      );
    }).toList();
  }

  void _negotiateColor()
  {
    showDialog(
      context: context,
      builder: (context)
      {
        return AlertDialog(
          title: const Text('Цвет категории'),
          content: BlockPicker(
            pickerColor: _color,
            onColorChanged: (color)
            {
              setState(() {
                _color = color;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              child: const Text('Закрыть'),
            ),
          ],
        );
      }
    );
  }

  void _setValidationErrorForNameInputField(String msg)
  {
    setState(() {
      _nameValidationErrorText = msg;
    });
  }

  void _saveChanges() async
  {
    final category = CategoryUpdateViewModel(id: widget.categoryId, name: _name, type: _type, color: _color);
    final errors = CategoryUpdateErrors();
    await widget.categories.update(category, errors);

    if (errors.hasAny())
    {
      if (errors.isAlreadyExists())
        _setValidationErrorForNameInputField('Категория с таким названием уже существует');
      if (errors.isNameRequired())
        _setValidationErrorForNameInputField('Введите название категории');
      return;
    }

    widget.onUpdate();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменение категории'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _name,
                onChanged: (value)
                {
                  setState(() {
                    _name = value;
                  });
                },

                decoration: InputDecoration(
                  labelText: 'Название',
                  errorText: _nameValidationErrorText,
                  border: const OutlineInputBorder()
                ),
              ),

              DropdownButtonFormField(
                items: _getCategoryTypes(),
                value: _type,
                onChanged: (CategoryType? type)
                {
                  if (type == null)
                    return;

                  setState(() {
                    _type = type;
                  });
                },

                decoration: const InputDecoration(
                  labelText: 'Тип категории',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: _negotiateColor,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueGrey)
                  ),
                ),
              ),
              const SizedBox(height: 16,),

              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Сохранить изменения'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
