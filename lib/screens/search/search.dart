import 'package:flutter/material.dart';
import 'package:pokemon/models/model_pokemon.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.data}) : super(key: key);

  List<Pokemon> data;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List searchedPokemon = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            hintText: "Buscar Pokemon",
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onChanged: (v) {
            searchedPokemon.clear();

            widget.data.forEach(
              (element) {
                if (element.name!.toLowerCase().contains(v)) {
                  searchedPokemon.add(element);
                  setState(() {});
                }
              },
            );
            if (v.length == 0) {
              searchedPokemon.clear();
              setState(() {});
            }
          },
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/about",
                      arguments: searchedPokemon[index]);
                },
                isThreeLine: true,
                title: Text(searchedPokemon[index].name.toString()),
                subtitle: Text("#" + searchedPokemon[index].num.toString()),
                leading: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.network(
                    searchedPokemon[index].img.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          itemCount: searchedPokemon.length),
    );
  }
}
