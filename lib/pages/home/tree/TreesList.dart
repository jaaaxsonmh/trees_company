import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trees_co/utils/Fire.dart';
import 'package:trees_co/utils/MoneyConverter.dart';
import 'package:trees_co/utils/MyNavigator.dart';
import 'package:trees_co/utils/TreeInfo.dart';

class TreesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TreesList();
  }
}

class _TreesList extends State<TreesList> {
  static const TREE_CATEGORY = "Tree category";
  static const SOIL_DRAINAGE = "Soil Drainage";
  static const SUN = "Sun";
  static const MAINTENACE = "Maintenance";
  static const MAX_HEIGHT = "Max height";
  static const GROWTH_RATE = "Growth rate";

  static const PRICE_BEST_MATCH = "Best match";
  static const PRICE_LOW_TO_HIGH = "Low to High";
  static const PRICE_HIGH_TO_LOW = "High to Low";

  var baseFilters = <String>[
    TREE_CATEGORY,
    SOIL_DRAINAGE,
    SUN,
    MAX_HEIGHT,
    GROWTH_RATE,
  ];
  var secondaryFiltersSelected = <String>[];

  var filtersTreeCategoryList = <String>[
    'Conifer',
    'Groundcover',
    'Trees',
    'Shrubs'
  ];

  var filtersSoilDrainageList = <String>[
    TreeSoilDrainage.soil_drainage_fast,
    TreeSoilDrainage.soil_drainage_medium,
    TreeSoilDrainage.soil_drainage_low,
    TreeSoilDrainage.soil_drainage_anything,
  ];

  var filtersSunList = <String>[
    TreeSun.sun_sunny,
    TreeSun.sun_med,
    TreeSun.sun_shade,
    TreeSun.sun_anything,
  ];

  var filtersheightList = <String>[
    TreeMaxHeight.height_less_1m,
    TreeMaxHeight.height_1m_2m,
    TreeMaxHeight.height_2m_3m,
    TreeMaxHeight.height_more_3m,
  ];

  var filtersGrowthList = <String>[
    TreeGrowthRate.rate_fast,
    TreeGrowthRate.rate_medium,
    TreeGrowthRate.rate_slow
  ];

  var filtersPrice = <String>[
    PRICE_BEST_MATCH,
    PRICE_LOW_TO_HIGH,
    PRICE_HIGH_TO_LOW
  ];

  var selectedPrimaryFilter = "";
  var selectedSecondaryFilter = "";
  var selectedPriceFilter = PRICE_BEST_MATCH;

  var hideSecondSearch = 0.0;

  Query DEFAULT_FIREBASE = Firestore.instance.collection(Fire.trees);

  @override
  Widget build(BuildContext context) {
    var filterHintPrimary = "";
    var filterHintSecondary = selectedSecondaryFilter;
    var filterPrice = selectedPriceFilter;

    var fireBaseStream;

    if (selectedPrimaryFilter == "") {
      filterHintPrimary = "Filter";

      selectedPrimaryFilter = "";
      fireBaseStream = DEFAULT_FIREBASE;

      hideSecondSearch = 0.0;
    } else {
      filterHintPrimary = "Filter by: " + selectedPrimaryFilter;

      hideSecondSearch = 1.0;
    }

    if (selectedPrimaryFilter == TREE_CATEGORY) {
      secondaryFiltersSelected = filtersTreeCategoryList;
      fireBaseStream = DEFAULT_FIREBASE.where(Fire.TREE_CATEGORY,
          isEqualTo: selectedSecondaryFilter);
    } else if (selectedPrimaryFilter == SOIL_DRAINAGE) {
      secondaryFiltersSelected = filtersSoilDrainageList;

      fireBaseStream = DEFAULT_FIREBASE.where(Fire.TREE_SOIL_DRAINAGE,
          isEqualTo: selectedSecondaryFilter);
    } else if (selectedPrimaryFilter == SUN) {
      secondaryFiltersSelected = filtersSunList;

      fireBaseStream = DEFAULT_FIREBASE.where(Fire.TREE_SUN_REQ,
          isEqualTo: selectedSecondaryFilter);
    } else if (selectedPrimaryFilter == MAX_HEIGHT) {
      secondaryFiltersSelected = filtersheightList;

      fireBaseStream = DEFAULT_FIREBASE.where(Fire.TREE_MAX_HEIGHT,
          isEqualTo: selectedSecondaryFilter);
    } else if (selectedPrimaryFilter == GROWTH_RATE) {
      secondaryFiltersSelected = filtersGrowthList;

      fireBaseStream = DEFAULT_FIREBASE.where(Fire.TREE_GROWTH_RATE,
          isEqualTo: selectedSecondaryFilter);
    }


    if (selectedSecondaryFilter == "") {
      fireBaseStream = DEFAULT_FIREBASE;
    }

    if (filterPrice == PRICE_LOW_TO_HIGH) {
      fireBaseStream = fireBaseStream.orderBy(Fire.TREE_PRICE, descending: false);
    } else if (filterPrice == PRICE_HIGH_TO_LOW) {
      fireBaseStream = fireBaseStream.orderBy(Fire.TREE_PRICE, descending: true);
    }

    return new StreamBuilder<QuerySnapshot>(
      stream: fireBaseStream.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return new Center(
            child: new SizedBox(
              height: 50.0,
              width: 50.0,
              child: new CircularProgressIndicator(
                strokeWidth: 7.0,
              ),
            ),
          );
        return Column(
          children: <Widget>[
            new Wrap(
        children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Opacity(
                      opacity: hideSecondSearch,
                      child: new GestureDetector(
                          child: new Icon(Icons.remove_circle_outline),
                          onTap: () {
                            setState(() {
                              selectedPrimaryFilter = "";
                              selectedSecondaryFilter = "";

                              secondaryFiltersSelected = [];
                            });
                          }),
                    ),
                  ),
                  new DropdownButton<String>(
                    hint: Text(filterHintPrimary),
                    items: baseFilters.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPrimaryFilter = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    child: new Opacity(
                      opacity: hideSecondSearch,
                      child: new DropdownButton<String>(
                        hint: Text(filterHintSecondary),
                        items: secondaryFiltersSelected.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSecondaryFilter = value;
                          });
                        },
                      ),
                    ),
                  ),
                  new DropdownButton<String>(
                    hint: Text(filterPrice),
                    items: filtersPrice.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPriceFilter = value;
                      });
                    },
                  )
                ],
              ),
            new Expanded(
              child: new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  padding: const EdgeInsets.all(5.0),
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index])),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  var price = MoneyConverter().convert(document[Fire.TREE_PRICE]);
  return new Container(
    child: new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            key: new ValueKey(document.documentID),
            leading: new Image.network(document[Fire.TREE_IMAGE],
                width: 50.0, height: 50.0),
            title: new Text(document[Fire.TREE_TITLE],
                style: new TextStyle(fontSize: 20.0)),
            subtitle: new Text(document[Fire.TREE_CATEGORY]),
            trailing: new Text(price,
                style: new TextStyle(fontSize: 24.0, color: Colors.green)),
            onTap: () => _openNewsFullPage(context, document),
          ),
        ],
      ),
    ),
  );
}

_openNewsFullPage(BuildContext context, DocumentSnapshot document) {
  MyNavigator.goToTreeFullInfo(context, document);
}
