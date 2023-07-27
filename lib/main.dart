import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _weightController = TextEditingController(); // controle do peso
  final _heightController = TextEditingController(); // controle da altura

  final _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    _weightController.text = "";
    _heightController.text = "";
    _infoText = "Informe seus dados!";
  }

  void _calculate(){
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;
    double imc = weight / (height*height);

    setState(() { // da para usar o setState dos dois jeito (não precisa nos controllers porque o flutter já sabe que é para atualizar eles)
      if(imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                _resetFields();
              });
            },
            icon: const Icon(Icons.refresh)
          )
        ],
      ),
      backgroundColor: Colors.white60,
      
      body: SingleChildScrollView( // para conseguirmos rolar a tela
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),

        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          // vai tentar preencher toda a largura
          // como já colocamos um tamanho máximo, ele vai centralizar
        
          children: [
            const Icon(
              Icons.person_outlined,
              size: 120,
              color: Colors.blueGrey,
            ),
            
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.blueGrey),
              ),
              textAlign: TextAlign.center, // centralizar texto
              style: const TextStyle(color: Colors.blueGrey, fontSize: 25),
              controller: _weightController, 
              validator: (value) {
                if(value!.isEmpty){
                  return "Insira seu peso!";
                }
              },
            ),
            
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.blueGrey),
              ),
              textAlign: TextAlign.center, // centralizar texto
              style: const TextStyle(color: Colors.blueGrey, fontSize: 25),
              controller: _heightController,
              validator: (value){
                if(value!.isEmpty){
                  return "Insira sua altura!";
                }
              },
            ),
        
            Padding(
              padding:const EdgeInsets.only(top: 10.0, bottom: 10.0),
        
              child: SizedBox( // colocamos o container para conseguir colocar o botão de um tamanho que queremos
              height: 50,
        
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _calculate();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text(
                  "Calcular",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            ),
            
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 25
              ),
            ),
          ],
              ),
        ),
      )
    );
  }
}
