import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/models/model_pokemon.dart';
import 'package:pokemon/services/service_pokemon.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> pData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset("assets/images/pokemon.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () async {
                List<Pokemon>? data;
                await ServicePokemon.getData()
                    .then((value) => data = value.pokemon);
                Navigator.pushNamed(context, "/search", arguments: data);
              },
              child: TextFormField(
                enabled: false,
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
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18.0),
            child: FutureBuilder(
              future: ServicePokemon.getData(),
              builder: (context, AsyncSnapshot<PokemonModel> snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snap.hasError) {
                  return Text("Error 404");
                } else {
                  List<Pokemon>? data = snap.data!.pokemon;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      // mainAxisSpacing: 10,
                      // childAspectRatio: 3 / 2.4,
                    ),
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return newFunc(index, data);
                    },
                  );
                }
              },
            ),
          )),
        ],
      ),
    ));
  }

  newFunc(int index, List<Pokemon> data) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/about", arguments: data[index]);
        },
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              // height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: const Color(0xffFC7CFF),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.09,
              top: -10,
              child: Image.network(data[index].img.toString()),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05,
              right: MediaQuery.of(context).size.width * 0.04,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xff676767),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "#" + data[index].num.toString(),
                      style: const TextStyle(
                          color: Color(0xffFC7CFF),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          data[index].name.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
