import 'package:e_commerce/common/widgets/loader.dart';
import 'package:e_commerce/features/search/services/search_services.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchProduct();
  }

  void fetchSearchProduct() async {
    products = await searchServices.fetchSearchedProduct(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return products == null ? const Loader() : Scaffold(
      body: Center(
        child: Text(widget.searchQuery),
      ),
    );
  }
}
