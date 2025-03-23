import 'package:didatikids/components/text_input_component.dart';
import 'package:didatikids/themes/standart.dart';
import 'package:didatikids/utils/form_utils.dart';
import 'package:didatikids/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  String _selectedIcon = "add";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2026),
    );

    if (picked != null) {
      setState(() {
        _birthdayController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _selectAvatar() async {
    final selectedIcon = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Avatar(),
        );
      },
    );

    if (selectedIcon != null) {
      setState(() {
        _selectedIcon = selectedIcon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var frameWidth = MediaQuery.of(context).size.width * 0.80;
    var frameHeight = MediaQuery.of(context).size.height * 0.60;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: backgroundMainColor, size: 30),
        title: Text(
          'Adicionar Perfil',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Super Funnel',
            color: backgroundMainColor,
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: backgroundMainColor,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _selectAvatar,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:
                        _selectedIcon != "add"
                            ? Image.asset(
                              'assets/images/icon_$_selectedIcon.png', // Atualiza o ícone dinamicamente
                              fit: BoxFit.cover,
                            )
                            : Icon(
                              Icons.add,
                              size: 70,
                              color: backgroundMainColor,
                            ),
                  ),
                ),
              ),
              SizedBox(
                width: frameWidth,
                height: frameHeight,
                child: Column(
                  children: [
                    TextInputComponent(
                      label: 'Nome',
                      validator: (value) => null,
                      inputType: TextInputType.name,
                      controller: _nameController,
                      readOnly: false,
                      suffixIcon: null,
                      handleTap: () => {},
                      mainColor: inputMainColor,
                      hideText: false,
                      hint: '',
                    ),

                    SizedBox(height: 5),

                    TextInputComponent(
                      label: 'Data de nascimento',
                      validator: (value) => validateBirthday(value),
                      inputType: TextInputType.text,
                      controller: _birthdayController,
                      readOnly: true,
                      suffixIcon: Icon(Icons.calendar_today),
                      handleTap: _selectDate,
                      mainColor: inputMainColor,
                      hideText: false,
                      hint: '',
                    ),

                    SizedBox(height: 30),

                    ListInputComponent(),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 350,
                height: 75,
                decoration: BoxDecoration(
                  color: backgroundSecondColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Criar Perfil",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: "Super Funnel",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    var frameWidth = MediaQuery.of(context).size.width * 0.80;
    var frameHeight = MediaQuery.of(context).size.height * 0.70;

    return Container(
      width: frameWidth,
      height: frameHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "Avatar",
            style: TextStyle(
              fontSize: 50,
              fontFamily: "Super Funnel",
              color: backgroundMainColor,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "dog");
                },
                child: Profile(name: "", icon: "dog", iconWidth: 100),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "uni");
                },
                child: Profile(name: "", icon: "uni", iconWidth: 100),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "duck");
                },
                child: Profile(name: "", icon: "duck", iconWidth: 100),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, "robot");
                },
                child: Profile(name: "", icon: "robot", iconWidth: 100),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListInputComponent extends StatefulWidget {
  const ListInputComponent({super.key});

  @override
  _ListInputComponentState createState() => _ListInputComponentState();
}

class _ListInputComponentState extends State<ListInputComponent> {
  // Lista de opções
  final List<String> listaOpcoes = [
    "Matemática",
    "Português",
    "Ciências",
    "Geografia",
    "História",
  ];

  // Lista para armazenar os itens selecionados
  final List<String> opcoesSelecionadas = [];

  // Controla se a lista está expandida ou não
  bool icExpandirLista = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              icExpandirLista = !icExpandirLista;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                //Deixar com borda ou nem???
                color: Colors.black,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  opcoesSelecionadas.isEmpty
                      ? "Selecione as matérias favoritas"
                      : opcoesSelecionadas.join(", "),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  overflow: TextOverflow.ellipsis, //Limita o texto a uma linha
                ),
                Icon(
                  icExpandirLista ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (icExpandirLista)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: ListView.builder(
              shrinkWrap: true, //Permite que a lista se ajuste ao conteúdo
              itemCount: listaOpcoes.length,
              itemBuilder: (context, index) {
                final opcao = listaOpcoes[index];
                return CheckboxListTile(
                  title: Text(opcao),
                  value: opcoesSelecionadas.contains(opcao),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        opcoesSelecionadas.add(opcao); //Adiciona à lista
                      } else {
                        opcoesSelecionadas.remove(opcao); //Remove da lista
                      }
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
