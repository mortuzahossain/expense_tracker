import 'package:floor/floor.dart';
import '../../models/category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM Category')
  Future<List<Category>> findAllCategories();

  @Query('SELECT * FROM Category WHERE type = :type')
  Stream<List<Category>> findCategoriesByType(CategoryType type);

  @insert
  Future<void> insertCategory(Category category);

  @update
  Future<void> updateCategory(Category category);

  @delete
  Future<void> deleteCategory(Category category);

  @Query('SELECT * FROM Category')
  Future<List<Category>> getAllCategories();
}
