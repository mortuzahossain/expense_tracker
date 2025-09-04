import 'package:flutter/cupertino.dart';
import 'add_edit_category_screen.dart';

enum CategoryListType { expense, income }

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoryListType _selectedType = CategoryListType.expense;

  // Placeholder data
  final Map<CategoryListType, List<Map<String, dynamic>>> _categories = {
    CategoryListType.expense: [
      {'name': 'Food', 'icon': CupertinoIcons.shopping_cart},
      {'name': 'Transport', 'icon': CupertinoIcons.bus},
      {'name': 'Shopping', 'icon': CupertinoIcons.bag},
      {'name': 'Bills', 'icon': CupertinoIcons.doc_text},
      {'name': 'Entertainment', 'icon': CupertinoIcons.film},
      {'name': 'Health', 'icon': CupertinoIcons.heart},
    ],
    CategoryListType.income: [
      {'name': 'Salary', 'icon': CupertinoIcons.money_dollar},
      {'name': 'Freelance', 'icon': CupertinoIcons.briefcase},
      {'name': 'Investment', 'icon': CupertinoIcons.chart_pie},
      {'name': 'Gift', 'icon': CupertinoIcons.gift},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentCategories = _categories[_selectedType]!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Categories'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddEditCategoryScreen(),
              ),
            );
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTypeSelector(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentCategories.length,
                itemBuilder: (context, index) {
                  final category = currentCategories[index];
                  return _buildCategoryItem(
                    context,
                    category['name'] as String,
                    category['icon'] as IconData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return CupertinoSlidingSegmentedControl<CategoryListType>(
      groupValue: _selectedType,
      onValueChanged: (CategoryListType? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedType = newValue;
          });
        }
      },
      children: const <CategoryListType, Widget>{
        CategoryListType.expense: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Expense'),
        ),
        CategoryListType.income: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Income'),
        ),
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, String name, IconData icon) {
    return CupertinoListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 24),
      ),
      title: Text(name),
      trailing: const Icon(CupertinoIcons.right_chevron),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => const AddEditCategoryScreen(),
          ),
        );
      },
    );
  }
}
