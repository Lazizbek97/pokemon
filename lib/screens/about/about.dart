import 'package:flutter/material.dart';
import 'package:pokemon/models/model_pokemon.dart';
import 'package:pokemon/screens/about/detailed_data.dart';
import 'package:pokemon/services/service_pokemon.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key, required this.data}) : super(key: key);

  Pokemon data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Image.asset("assets/images/pokemon.png"),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left_outlined),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      List<Pokemon>? data;
                      await ServicePokemon.getData()
                          .then((value) => data = value.pokemon);
                      Navigator.pushNamed(context, "/search", arguments: data);
                    },
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      enabled: false,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.segment_outlined,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.fromLTRB(20, 60, 20, 10),
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: const Color(0xffFC7CFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "#" + data.num.toString(),
                          style: const TextStyle(
                              color: Color(0xffFC7CFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        Text(
                          data.name.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.15,
                  bottom: 20,
                  child: Image.network(
                    data.img.toString(),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Fuego",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 12),
                      primary: const Color(0xffFCA600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Valador",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 12),
                      primary: const Color(0xff0083FC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  DetailedDatas(
                    data: data,
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: SizedBox(
                      height: 100,
                      width: 200,
                      child: Image.asset("assets/images/botton_img.png"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
