import 'package:dietary_works_capstone/data/model/dummy_model.dart';
import 'package:dietary_works_capstone/widget/card_recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const Align(
              alignment: Alignment.center,
              child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: [
                    Tab(text:'Untuk Anda'),
                    Tab(text:'Rating Teratas'),
                    Tab(text:'Durasi Singkat'),
                  ]
              ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: 329,
            child: TabBarView(
              children: [
                ListView.builder(
                    itemCount: catalog.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      final CatalogModel product = catalog[index];
                      return CardRecipe(catalog: product);
                    }
                ),
                ListView.builder(
                    itemCount: catalog.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      final CatalogModel product = catalog[index];
                      return CardRecipe(catalog: product);
                    }
                ),
                ListView.builder(
                    itemCount: catalog.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      final CatalogModel product = catalog[index];
                      return CardRecipe(catalog: product);
                    }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
