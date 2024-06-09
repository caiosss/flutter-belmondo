import 'package:flutter/material.dart';
import 'package:aplicacao_mobile/Telas/home_page_qrcode.dart';

void main() => runApp(const PresencePageApp());

class PresencePageApp extends StatelessWidget {
  const PresencePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PresencePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PresencePage extends StatefulWidget {
  final userId;
  const PresencePage({super.key, this.userId});

  @override
  State<PresencePage> createState() => PresencePageState();
}

class PresencePageState extends State<PresencePage> {
  final List<String> estados = [
    'CE', 'SP', 'RJ', 'MG', 'RS', 'SC', 'PR', 'BA', 'PE', 'PA',
    'AM', 'ES', 'GO', 'MT', 'MS', 'DF', 'RO', 'AC', 'TO', 'AP',
    'RR', 'AL', 'SE', 'MA', 'PI'
  ];

  final Map<String, List<String>> cidadesPorEstado = {
    'CE': ['Fortaleza', 'Caucaia', 'Juazeiro do Norte', 'Maracanaú', 'Sobral', 'Crato', 'Itapipoca', 'Maranguape', 'Iguatu', 'Quixadá', 'Aquiraz', 'Canindé', 'Tianguá', 'Quixeramobim', 'Russas', 'Pacajus', 'Camocim', 'Icó', 'Acaraú', 'Morada Nova', 'Horizonte', 'Crateús', 'Pacatuba', 'Aracati', 'Limoeiro do Norte', 'Eusébio', 'Santa Quitéria', 'Tauá', 'São Gonçalo do Amarante', 'Itapajé', 'Barbalha', 'Campos Sales', 'Massapê', 'Mombaça', 'Acopiara', 'Granja', 'Trairi', 'Viçosa do Ceará', 'Cascavel', 'Pedra Branca', 'Guaraciaba do Norte', 'Paracuru', 'Ipu', 'Baturité', 'Santana do Cariri', 'Chorozinho', 'Boa Viagem', 'São Benedito', 'Redenção', 'Nova Russas', 'Várzea Alegre', 'Palmácia', 'Aracoiaba', 'Madalena', 'Capistrano', 'Amontada', 'Ubajara', 'Aratuba', 'Missão Velha', 'Lavras da Mangabeira', 'Pentecoste', 'Marco', 'Croatá', 'Pacoti', 'Barroquinha', 'Farias Brito', 'Forquilha', 'Guaramiranga', 'Icapuí', 'Ipaporanga', 'Irauçuba', 'Jijoca de Jericoacoara', 'Jaguaribe', 'Milagres', 'Orós', 'Piquet Carneiro', 'Pindoretama', 'Poranga', 'Quixeré', 'Reriutaba', 'Senador Pompeu', 'Solonópole', 'Tabuleiro do Norte', 'Tururu', 'Uruoca', 'Varjota'],
    'SP': ['São Paulo', 'Campinas', 'Santos', 'São Bernardo do Campo', 'Guarulhos', 'Osasco', 'Ribeirão Preto', 'Sorocaba', 'São José dos Campos', 'Santo André', 'Mogi das Cruzes', 'Jundiaí', 'Piracicaba', 'Bauru', 'Franca', 'Carapicuíba', 'Itaquaquecetuba', 'São Vicente', 'Taubaté', 'Barueri', 'Embu das Artes', 'Cotia', 'Suzano', 'Taboão da Serra', 'Sumaré', 'Mauá', 'Marília', 'Indaiatuba', 'Presidente Prudente', 'Itapevi', 'Araraquara', 'Hortolândia', 'Itapecerica da Serra', 'Americana', 'Limeira', 'Ferraz de Vasconcelos', 'Bragança Paulista', 'Pindamonhangaba', 'Santana de Parnaíba', 'Araçatuba', 'Atibaia', 'Itapetininga', 'Guarujá', 'Catanduva', 'Birigui', 'Avaré', 'Salto', 'Assis', 'Ourinhos', 'Botucatu', 'Itu', 'Mogi Guaçu', 'Franco da Rocha', 'Caieiras', 'Votorantim', 'Araras', 'Guaratinguetá', 'Valinhos', 'Jacareí', 'Caraguatatuba', 'Poá', 'Praia Grande', 'Paulínia', 'Itatiba', 'Tatuí', 'São Carlos', 'Leme', 'Monte Mor', 'Itu', 'Mogi Mirim', 'Ubatuba', 'Lorena', 'Registro', 'Vargem Grande Paulista', 'Jaboticabal', 'Itanhaém', 'Campo Limpo Paulista', 'Ilhabela', 'São Roque', 'Cravinhos', 'Caçapava', 'Taquaritinga', 'Barretos', 'Capivari', 'São Sebastião', 'Penápolis', 'Piraju', 'Ituverava', 'Pirassununga', 'Guararapes', 'Vargem Grande do Sul', 'Jales', 'Bertioga', 'Santa Bárbara d\'Oeste', 'Sertãozinho', 'Itapira'],
    'RJ': ['Rio de Janeiro', 'Niterói', 'São Gonçalo', 'Duque de Caxias', 'Nova Iguaçu', 'Belford Roxo', 'São João de Meriti', 'Petrópolis', 'Volta Redonda', 'Campos dos Goytacazes', 'Magé', 'Itaboraí', 'Macaé', 'Angra dos Reis', 'Teresópolis', 'Cabo Frio', 'Barra Mansa', 'Mesquita', 'Nilópolis', 'Resende', 'Queimados', 'Maricá', 'Rio das Ostras', 'Itaguaí', 'Nova Friburgo', 'Saquarema', 'Japeri', 'Araruama', 'Paracambi', 'Três Rios', 'Paraíba do Sul', 'Seropédica', 'São Pedro da Aldeia', 'Casimiro de Abreu', 'Piraí', 'Quatis', 'Porto Real', 'Mangaratiba', 'Conceição de Macabu', 'Bom Jardim', 'Cantagalo', 'Valença', 'Miguel Pereira', 'Paty do Alferes', 'Pinheiral', 'Sapucaia', 'Cordeiro', 'Cachoeiras de Macacu', 'Iguaba Grande', 'Silva Jardim', 'Engenheiro Paulo de Frontin', 'Arraial do Cabo', 'São Francisco de Itabapoana', 'Porciúncula', 'Natividade', 'Miracema', 'Bom Jesus do Itabapoana', 'Carapebus', 'São Fidélis', 'São José do Vale do Rio Preto', 'São João da Barra', 'Laje do Muriaé', 'Italva', 'Itaocara', 'Cambuci', 'Quissamã', 'Aperibé', 'Varre-Sai', 'Macuco', 'Sumidouro', 'Rio Claro', 'Rio Bonito', 'Cardoso Moreira'],
    'MG': ['Belo Horizonte', 'Uberlândia', 'Contagem'],
    'RS': ['Porto Alegre', 'Caxias do Sul', 'Pelotas'],
    'SC': ['Florianópolis', 'Joinville', 'Blumenau'],
    'PR': ['Curitiba', 'Londrina', 'Maringá'],
    'BA': ['Salvador', 'Feira de Santana', 'Vitória da Conquista'],
    'PE': ['Recife', 'Olinda', 'Jaboatão dos Guararapes'],
    'PA': ['Belém', 'Ananindeua', 'Santarém'],
    'AM': ['Manaus', 'Parintins', 'Itacoatiara'],
    'ES': ['Vitória', 'Vila Velha', 'Serra'],
    'GO': ['Goiânia', 'Anápolis', 'Aparecida de Goiânia'],
    'MT': ['Cuiabá', 'Várzea Grande', 'Rondonópolis'],
    'MS': ['Campo Grande', 'Dourados', 'Três Lagoas'],
    'DF': ['Brasília', 'Taguatinga', 'Ceilândia'],
    'RO': ['Porto Velho', 'Ji-Paraná', 'Ariquemes'],
    'AC': ['Rio Branco', 'Cruzeiro do Sul', 'Sena Madureira'],
    'TO': ['Palmas', 'Araguaína', 'Gurupi'],
    'AP': ['Macapá', 'Santana', 'Laranjal do Jari'],
    'RR': ['Boa Vista', 'Rorainópolis', 'Caracaraí'],
    'AL': ['Maceió', 'Arapiraca', 'Palmeira dos Índios'],
    'SE': ['Aracaju', 'Nossa Senhora do Socorro', 'Lagarto'],
    'MA': ['São Luís', 'Imperatriz', 'Caxias'],
    'PI': ['Teresina', 'Parnaíba', 'Picos']
  };

  String? estadoSelecionado;
  String? cidadeSelecionada;

  @override
  Widget build(BuildContext context) {

    List<String> cidades = [];
    if (estadoSelecionado != null && cidadesPorEstado.containsKey(estadoSelecionado)) {
      cidades = cidadesPorEstado[estadoSelecionado]!;
    } else {
      cidades = cidadesPorEstado.values.expand((list) => list).toList();
    }

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: 130,
        backgroundColor: const Color.fromARGB(255, 2, 40, 70),
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text(
          "Presença",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 26.1,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text("Nome",
                    style: TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w300, fontFamily: "Poppins")
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Digite...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(
                    "De onde você veio?",
                    style: TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w300, fontFamily: "Poppins"),)]),
              const SizedBox(height: 35),
              const Text("Estado"),
              const SizedBox(height: 8),
              DropdownButton<String>(
                hint: const Text("Selecione"),
                value: estadoSelecionado,
                items: estados.map((String estado) {
                  return DropdownMenuItem(
                    child: Text(estado),
                    value: estado,
                  );
                }).toList(),
                onChanged: (String? novoEstado) {
                  setState(() {
                    estadoSelecionado = novoEstado;
                    if(cidadesPorEstado[estadoSelecionado]!.contains(cidadeSelecionada)){

                    } else {
                      cidadeSelecionada = null;
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text("Cidade"),
              const SizedBox(height: 8),
              DropdownButton<String>(
                hint: const Text("Selecione"),
                value: cidadeSelecionada,
                items: cidades.map((String cidade) {
                  return DropdownMenuItem(
                    child: Text(cidade),
                    value: cidade,
                  );
                }).toList(),
                onChanged: (String? novaCidade) {
                  setState(() {
                    cidadeSelecionada = novaCidade;
                  });
                },
              ),
              const SizedBox(height: 150,),
              Container(
            width: 339,
            height: 63,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage(userId: widget.userId)));
              },
              child: const Text(
                "confirmar",
                style: TextStyle(
                    fontSize: 26.1,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                backgroundColor: const Color.fromARGB(255, 2, 40, 70),
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
