import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/state.dart';
import 'package:e_commerce/home/widgets/product.dart';
import 'package:e_commerce/home/widgets/scrollHorizontal.dart';
import 'package:e_commerce/home/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // search
              SliverToBoxAdapter(child: Search()),

              // categories
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: SizedBox(
                    height: 65,
                    child: state is GetCategoriesLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ScrollHorizontal(
                            listOfCategories: cubit.listOfCategories,
                            item: cubit.selectedCategory,
                            changeItem: (val) => cubit.changeCategory(val),
                          ),
                  ),
                ),
              ),

              // products
              SliverFillRemaining(
                child: state is HomeLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 5,
                        ),
                        child: cubit.listOfProducts.isNotEmpty
                            ? Product(listOfProducts: cubit.listOfProducts)
                            : const Center(child: Text('No products found')),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
