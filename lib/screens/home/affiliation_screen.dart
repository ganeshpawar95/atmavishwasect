import 'package:atmavishwasect/providers/affiliation_provider.dart';
import 'package:atmavishwasect/providers/category_provider.dart';
import 'package:atmavishwasect/screens/home/home_screen.dart';
import 'package:atmavishwasect/utilites/helper.dart';
import 'package:atmavishwasect/widgets/affiliation_card.dart';
import 'package:atmavishwasect/widgets/custom_inkwell_btn.dart';
import 'package:atmavishwasect/widgets/custom_modal.dart';
import 'package:atmavishwasect/widgets/custom_text.dart';
import 'package:atmavishwasect/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AffiliationScreen extends StatefulWidget {
  const AffiliationScreen({super.key});

  @override
  State<AffiliationScreen> createState() => _AffiliationScreenState();
}

class _AffiliationScreenState extends State<AffiliationScreen> {
  String? _selectedCategory;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AffiliationProvider>(
        context,
        listen: false,
      ).fetchAffiliations();
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final provider = Provider.of<AffiliationProvider>(context, listen: false);
    provider.setFilters(
      name: _nameController.text.trim(),
      category: _categoryController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: CustomInkWell(
            onTap: () => Helper.toRemoveUntiScreen(context, HomeScreen()),
            child: Icon(Icons.arrow_back),
          ),
          title: CustomText(
            title: "Tie-ups",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        body: Column(
          children: [
            TextInput(
              hint: "Search by Name",
              controller: _nameController,
              onSubmitted: (_) => _applyFilters(),
            ),
            Consumer<CategoryProvider>(
              builder: (context, categoryProvider, _) {
                // if (categoryProvider.isLoading) {
                //   return Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Center(child: CircularProgressIndicator()),
                //   );
                // }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    dropdownColor: const Color(
                      0xFF008374,
                    ), // Set dropdown background color
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ), // For selected value
                    hint: const Text(
                      "Select Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: Color(0xFF008374),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    value: _selectedCategory,
                    items: categoryProvider.categories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        _categoryController.text = value ?? '';
                      });
                      _applyFilters();
                    },
                  ),
                );
              },
            ),

            Expanded(
              child: Consumer<AffiliationProvider>(
                builder: (context, provider, _) {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          !provider.isLoading &&
                          !provider.hasReachedMax) {
                        provider.fetchAffiliations();
                      }
                      return false;
                    },
                    child: provider.isLoading && provider.affiliations.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : provider.affiliations.isEmpty
                        ? Center(
                            child: Text(
                              'No data found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              _applyFilters();
                            },
                            child: ListView.builder(
                              itemCount:
                                  provider.affiliations.length +
                                  (provider.isLoading ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index < provider.affiliations.length) {
                                  final item = provider.affiliations[index];
                                  return AffiliationCard(
                                    name: item.name,
                                    address: item.address,
                                    contact_no: item.contactNo,
                                    image_path: item.image_url,
                                    onTap: () {
                                      showCustomModal(
                                        context: context,
                                        title: item.name,
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 3),
                                            CustomText(
                                              title: item.address,
                                              textAlign: TextAlign.start,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(height: 3),
                                            CustomText(
                                              title: item.contactNo,
                                              textAlign: TextAlign.start,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(height: 8),
                                            if (item.image_url.isNotEmpty)
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  item.image_url,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  // Loader at bottom for pagination
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// 
