import 'dart:core';
import 'dart:io' as io;
import 'dart:ui';

import 'package:adv_fab/adv_fab.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:camping_fanatics/models/fruits.dart';
import 'package:camping_fanatics/providers/site_provider.dart';
import 'package:camping_fanatics/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:trie/trie.dart';

class ShoppingForm extends StatefulWidget {
  final AdvFabController formController;
  ShoppingForm({this.formController});
  @override
  ShoppingFormState createState() => ShoppingFormState();
}

class ShoppingFormState extends State<ShoppingForm> {
  String currentText = "";
  List<String> added = [];
  SimpleAutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> _formKey = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> _autoCompleteFormKey =
      new GlobalKey();
  int tag = 0;
  List<String> options = ['Quantity', 'Lbs', 'Box', 'bag'];
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  String valueStored = "qty";
  String amountLabel = "qty";

  @override
  void initState() {
    super.initState();
  }

  String storeValue(index) {
    switch (index) {
      case 0:
        return "qty";
        break;
      case 1:
        return "lbs";
        break;
      case 2:
        return "box";
        break;
      case 3:
        return "bag";
        break;
      default:
        return null;
    }
  }

  void updateItemList() {
    Provider.of<SiteProvider>(context, listen: false).addItem(
      Fruit(
          name: "${itemNameController.text}",
          amount: "${itemQuantityController.text}",
          image: "assets/images/${itemNameController.text}.png",
          quantity: "$valueStored",
          color: Color(0XFF558948),
          rating: 4.5),
    );
  }

  List<String> getSuggestions(value) {
    Trie trie = new Trie.list(suggestionsList);
    return trie.getAllWordsWithPrefix(value);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: itemNameController,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  suggestionsCallback: (pattern) async {
                    return getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(
                        suggestion,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    itemNameController.text = suggestion;
                  },
                ),
                Container(
                  child: ChipsChoice<int>.single(
                    direction: Axis.horizontal,
                    choiceActiveStyle: C2ChoiceStyle(
                      elevation: 20,
                      pressElevation: 1,
                      borderColor: Colors.transparent,
                      color: Colors.green,
                      labelStyle: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    choiceStyle: C2ChoiceStyle(
                      elevation: 5,
                      color: Colors.orange,
                      borderColor: Colors.transparent,
                      labelStyle: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                    value: tag,
                    onChanged: (val) => {
                      valueStored = storeValue(val),
                      setState(() => tag = val),
                    },
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: itemQuantityController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: valueStored,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    isExtended: true,
                    elevation: 15,
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                    onPressed: () {
                      print("Item: ${itemNameController.text} ");
                      print("$valueStored: ${itemQuantityController.text} ");
                      widget.formController.collapseFAB();
                      updateItemList();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> suggestionsList = [
  "apple",
  "apricot",
  "avocado",
  "banana",
  "bell pepper red",
  "bell pepper green",
  "bell pepper yellow",
  "bilberry",
  "blackberry",
  "blackcurrant",
  "blood orange",
  "blueberry",
  "boysenberry",
  "breadfruit",
  "canary melon",
  "cantaloupe",
  "cherimoya",
  "cherry",
  "chili pepper",
  "clementine",
  "cloudberry",
  "coconut",
  "cranberry",
  "cucumber",
  "currant",
  "damson",
  "date",
  "dragonfruit",
  "durian",
  "eggplant",
  "elderberry",
  "feijoa",
  "fig",
  "goji berry",
  "gooseberry",
  "grapes",
  "grapefruit",
  "guava",
  "honeydew",
  "huckleberry",
  "jackfruit",
  "jambul",
  "jujube",
  "kiwi fruit",
  "kumquat",
  "lemon",
  "lime",
  "loquat",
  "lychee",
  "mandarine",
  "mango",
  "mulberry",
  "nectarine",
  "nut",
  "olive",
  "orange",
  "pamelo",
  "papaya",
  "passionfruit",
  "peach",
  "pear",
  "persimmon",
  "physalis",
  "pineapple",
  "plum",
  "pomegranate",
  "pomelo",
  "purple mangosteen",
  "quince",
  "raisin",
  "rambutan",
  "raspberry",
  "redcurrant",
  "rock melon",
  "salal berry",
  "satsuma",
  "star fruit",
  "strawberry",
  "tamarillo",
  "tangerine",
  "tomato",
  "ugli fruit",
  "watermelon",
  "acorn squash",
  "alfalfa sprout",
  "amaranth",
  "anise",
  "artichoke",
  "arugula",
  "asparagus",
  "aubergine",
  "azuki bean",
  "banana squash",
  "basil",
  "bean sprout",
  "beet",
  "black bean",
  "black-eyed pea",
  "bok choy",
  "borlotti bean",
  "broad beans",
  "broccoflower",
  "broccoli",
  "brussels sprout",
  "butternut squash",
  "cabbage",
  "calabrese",
  "caraway",
  "carrot",
  "cauliflower",
  "cayenne pepper",
  "celeriac",
  "celery",
  "chamomile",
  "chard",
  "chayote",
  "chickpea",
  "chives",
  "cilantro",
  "collard green",
  "corn",
  "corn salad",
  "courgette",
  "cucumber",
  "daikon",
  "delicata",
  "dill",
  "eggplant",
  "endive",
  "fennel",
  "fiddlehead",
  "frisee",
  "garlic",
  "gem squash",
  "ginger",
  "green bean",
  "green pepper",
  "habanero",
  "herbs and spice",
  "horseradish",
  "hubbard squash",
  "jalapeno",
  "jerusalem artichoke",
  "jicama",
  "kale",
  "kidney bean",
  "kohlrabi",
  "lavender",
  "leek ",
  "legume",
  "lemon grass",
  "lentils",
  "lettuce",
  "lima bean",
  "mamey",
  "mangetout",
  "marjoram",
  "mung bean",
  "mushroom",
  "mustard green",
  "navy bean",
  "new zealand spinach",
  "nopale",
  "okra",
  "onion",
  "oregano",
  "paprika",
  "parsley",
  "parsnip",
  "patty pan",
  "pea",
  "pinto bean",
  "potato",
  "pumpkin",
  "radicchio",
  "radish",
  "rhubarb",
  "rosemary",
  "runner bean",
  "rutabaga",
  "sage",
  "scallion",
  "shallot",
  "skirret",
  "snap pea",
  "soy bean",
  "spaghetti squash",
  "spinach",
  "squash",
  "sweet potato",
  "tabasco pepper",
  "taro",
  "tat soi",
  "thyme",
  "topinambur",
  "tubers",
  "turnip",
  "wasabi",
  "water chestnut",
  "watercress",
  "white radish",
  "yam",
  "zucchini",
  "bagel",
  "baguette",
  "boule",
  "brioche",
  "casalinga",
  "chapati",
  "ciabatta",
  "cornbread",
  "crumpet",
  "epi",
  "ficelle",
  "flatbread",
  "focaccia",
  "fruit bread",
  "hamburger bun",
  "hotdog bun",
  "hardtack",
  "lavash",
  "matzoh",
  "muffin",
  "naan",
  "pain au levain",
  "pain de mie",
  "pane d'olive",
  "paratha",
  "pita",
  "potato bread",
  "pretzel",
  "pumpernickel",
  "roti",
  "rugbrød",
  "rye",
  "scone",
  "soda bread",
  "sourdough",
  "tortilla",
  "baklava",
  "bomboloni",
  "canelé",
  "cinnamon roll",
  "croissant",
  "cronut",
  "doughnut",
  "éclair",
  "gulab jamun",
  "kouign-amann",
  "mille-feuille",
  "morning bun",
  "pain au chocolat",
  "pastel de nata",
  "profiterole",
  "rugelach",
  "shortcake",
  "stollen",
  "strudel",
  "toaster strudel",
  "Angelica",
  "Basil",
  "Holy Basil",
  "Thai Basil",
  "Bay leaf",
  "Indian Bay leaf",
  "Boldo",
  "Borage",
  "Chervil",
  "Chives",
  "Garlic Chives",
  "Cicely",
  "Coriander leaf",
  "Cilantro",
  "Bolivian Coriander",
  "Vietnamese Coriander",
  "Culantro",
  "Cress",
  "Curry leaf",
  "Dill",
  "Epazote",
  "Hemp",
  "Hoja santa",
  "Houttuynia cordata",
  "Hyssop",
  "Jimbu",
  "Kinh gioi",
  "Lavender",
  "Lemonbalm",
  "Lemongrass",
  "Lemonmyrtle",
  "Lemonverbena",
  "Limnophila aromatica",
  "Lovage",
  "Marjoram",
  "Mint",
  "Mugwort",
  "Mitsuba",
  "Oregano",
  "Parsley",
  "Perilla",
  "Rosemary",
  "Rue",
  "Sage",
  "Savory",
  "Sansho",
  "Shiso",
  "Sorrel",
  "Tarragon",
  "Thyme",
  "Woodruff",
  "Aonori",
  "Ajwain",
  "Allspice",
  "Amchoor",
  "Anise",
  "Star Anise",
  "Asafoetida",
  "Camphor",
  "Caraway",
  "Cardamom",
  "Black Cardamom",
  "Cassia",
  "Celery powder",
  "Celery seed",
  "Charoli",
  "Chenpi",
  "Cinnamon",
  "Clove",
  "Coriander seed",
  "Cubeb",
  "Cumin",
  "Nigella sativa",
  "Bunium persicum",
  "Dill",
  "Dill seed",
  "Fennel",
  "Fenugreek",
  "Fingerroot",
  "Greater Galangal",
  "Lesser Galangal",
  "Garlic",
  "Ginger",
  "Aromatic Ginger",
  "Golpar",
  "Grains of Paradise",
  "Grains of Selim",
  "Horseradish",
  "Juniper berry",
  "Kokum",
  "Korarima",
  "Dried Lime",
  "Liquorice",
  "Litsea cubeba",
  "Mace",
  "Mango-ginger",
  "Mastic",
  "Mahlab",
  "Black Mustard",
  "Brown Mustard",
  "White Mustard",
  "Nigella",
  "Njangsa",
  "Nutmeg",
  "Alligator Pepper",
  "Brazilian Pepper",
  "Chili Pepper",
  "Cayenne pepper",
  "Paprika",
  "Long Pepper",
  "Peruvian Pepper",
  "East Asian Pepper",
  "Sichuan Pepper",
  "Sansho",
  "Tasmanian Pepper",
  "Black Peppercorn",
  "Green Peppercorn",
  "White Peppercorn",
  "Pomegranate seed",
  "Poppy seed",
  "Radhuni",
  "Rose",
  "Saffron",
  "Salt",
  "Sarsaparilla",
  "Sassafras",
  "Sesame",
  "Shiso",
  "Sumac",
  "Tamarind",
  "Tonka bean",
  "Turmeric",
  "Uzazi",
  "Vanilla",
  "Voatsiperifery",
  "Wasabi",
  "Yuzu",
  "Zedoary",
  "Zereshk",
  "Zest",
  "Adjika",
  "Advieh",
  "Baharat",
  "Beau Monde seasoning",
  "Berbere",
  "Bouquet garni",
  "Buknu",
  "Chaat masala",
  "Chaunk",
  "Chili powder",
  "Crab boil",
  "Curry powder",
  "Doubanjiang",
  "Douchi",
  "Duqqa",
  "Fines herbes",
  "Five-spice powder",
  "Garam masala",
  "Garlic powder",
  "Garlic salt",
  "Gochujang",
  "Harissa",
  "Hawaij",
  "Herbes de Provence",
  "Idli podi",
  "Jamaican jerk spice",
  "Khmeli suneli",
  "Lemon pepper",
  "Mitmita",
  "Mixed spice",
  "Montreal steak seasoning",
  "Mulling spices",
  "Old Bay Seasoning",
  "Onion powder",
  "Panch phoron",
  "Persillade",
  "Powder-douce",
  "Pumpkin pie spice",
  "Qâlat daqqa",
  "Quatre épices",
  "Ras el hanout",
  "Recado rojo",
  "Sharena sol",
  "Shichimi",
  "Tabil",
  "Tandoori masala",
  "Vadouvan",
  "Yuzukosho",
  "Za'atar"
];
