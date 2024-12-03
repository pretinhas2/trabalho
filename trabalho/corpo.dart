import 'package:flutter/material.dart';

void main() => runApp(SaudeEmDiaApp());

// Gerenciamento de Estado
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class SaudeEmDiaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saúde em Dia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
        scaffoldBackgroundColor: Color(0xFFDADAEC), // Cor de fundo padrão
      ),
      home: LoginPage(),
      routes: {
        '/activities': (context) => PhysicalActivitiesPage(),
        '/medications': (context) => MedicationRemindersPage(),
        '/history': (context) => HealthHistoryPage(),
        '/appointments': (context) => AppointmentsPage(),
        '/health_centers': (context) => HealthCentersPage(),
        '/cadastro': (context) => CadastroPage(),
      },
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _senha = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
                Text(
                  'Saúde em Dia',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(142, 31, 179, 1.0),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma senha';
                    } else if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _senha = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                _loading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            // Simulação de login com validação
                            Future.delayed(Duration(seconds: 2), () {
                              setState(() {
                                _loading = false;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPage()),
                              );
                            });
                          }
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                      ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  },
                  child: Text('Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Tela de Dashboard
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Saúde'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('Atividades Físicas'),
              onTap: () {
                Navigator.pushNamed(context, '/activities');
              },
            ),
            ListTile(
              title: Text('Lembretes de Medicamentos'),
              onTap: () {
                Navigator.pushNamed(context, '/medications');
              },
            ),
            ListTile(
              title: Text('Histórico de Saúde'),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              title: Text('Consultas Médicas'),
              onTap: () {
                Navigator.pushNamed(context, '/appointments');
              },
            ),
            ListTile(
              title: Text('Centros de Saúde'),
              onTap: () {
                Navigator.pushNamed(context, '/health_centers');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    color: Color(0xFFE6E6FA), // Cor lavanda corrigida
                    child: ListTile(
                      leading: Icon(Icons.directions_run, color: Colors.purple),
                      title: Text('Atividades Físicas'),
                      subtitle: Text('Clique para ver seu progresso'),
                      onTap: () {
                        Navigator.pushNamed(context, '/activities');
                      },
                    ),
                  ),
                  Card(
                    color: Color(0xFFE6E6FA), // Cor lavanda corrigida
                    child: ListTile(
                      leading: Icon(Icons.medication, color: Colors.purple),
                      title: Text('Lembretes de Medicamentos'),
                      subtitle: Text('Gerencie seus medicamentos'),
                      onTap: () {
                        Navigator.pushNamed(context, '/medications');
                      },
                    ),
                  ),
                  Card(
                    color: Color(0xFFE6E6FA), // Cor lavanda corrigida
                    child: ListTile(
                      leading: Icon(Icons.history, color: Colors.purple),
                      title: Text('Histórico de Saúde'),
                      subtitle: Text('Veja seu histórico de saúde'),
                      onTap: () {
                        Navigator.pushNamed(context, '/history');
                      },
                    ),
                  ),
                  Card(
                    color: Color(0xFFE6E6FA), // Cor lavanda corrigida
                    child: ListTile(
                      leading:
                          Icon(Icons.medical_services, color: Colors.purple),
                      title: Text('Consultas Médicas'),
                      subtitle: Text('Agende suas consultas'),
                      onTap: () {
                        Navigator.pushNamed(context, '/appointments');
                      },
                    ),
                  ),
                  Card(
                    color: Color(0xFFE6E6FA), // Cor lavanda corrigida
                    child: ListTile(
                      leading: Icon(Icons.local_hospital, color: Colors.purple),
                      title: Text('Centros de Saúde'),
                      subtitle: Text('Encontre os centros de saúde próximos'),
                      onTap: () {
                        Navigator.pushNamed(context, '/health_centers');
                      },
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

// Tela de Atividades Físicas
class PhysicalActivitiesPage extends StatefulWidget {
  @override
  _PhysicalActivitiesPageState createState() => _PhysicalActivitiesPageState();
}

class _PhysicalActivitiesPageState extends State<PhysicalActivitiesPage> {
  List<Activity> _activities = [
    Activity('Caminhada', '30 min'),
    Activity('Musculação', '45 min'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades Físicas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: _activities.map((activity) {
          return ListTile(
            leading: Icon(Icons.directions_walk, color: Colors.purple),
            title: Text(activity.name),
            subtitle: Text(activity.duration),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final _nameController = TextEditingController();
              final _durationController = TextEditingController();
              return AlertDialog(
                title: Text('Adicionar Atividade'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome da atividade',
                      ),
                    ),
                    TextField(
                      controller: _durationController,
                      decoration: InputDecoration(
                        labelText: 'Duração da atividade',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _activities.add(Activity(
                          _nameController.text,
                          _durationController.text,
                        ));
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

// Tela de Lembretes de Medicamentos
class MedicationRemindersPage extends StatefulWidget {
  @override
  _MedicationRemindersPageState createState() =>
      _MedicationRemindersPageState();
}

class _MedicationRemindersPageState extends State<MedicationRemindersPage> {
  List<Medication> _medications = [
    Medication('Aspirina', '8:00 AM', true),
    Medication('Vitamina C', '12:00 PM', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lembretes de Medicamentos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: _medications.map((medication) {
          return ListTile(
            leading: Icon(Icons.alarm, color: Colors.purple),
            title: Text(medication.name),
            subtitle: Text(medication.time),
            trailing: Switch(
              value: medication.enabled,
              onChanged: (bool newValue) {
                setState(() {
                  medication.enabled = newValue;
                });
              },
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final _nameController = TextEditingController();
              final _timeController = TextEditingController();
              return AlertDialog(
                title: Text('Adicionar Lembrete'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome do medicamento',
                      ),
                    ),
                    TextField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Hora do lembrete',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _medications.add(Medication(
                          _nameController.text,
                          _timeController.text,
                          true,
                        ));
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

// Tela de Histórico de Saúde
class HealthHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Saúde'),
      ),
      body: Center(
        child: Text('Histórico de Saúde será exibido aqui'),
      ),
    );
  }
}

// Tela de Consultas Médicas
class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultas Médicas'),
      ),
      body: Center(
        child: Text('Consultas Médicas serão exibidas aqui'),
      ),
    );
  }
}

// Tela de Centros de Saúde
class HealthCentersPage extends StatefulWidget {
  @override
  _HealthCentersPageState createState() => _HealthCentersPageState();
}

class _HealthCentersPageState extends State<HealthCentersPage> {
  List<HealthCenter> _healthCenters = [
    HealthCenter('Hospital São João', 'Rua São João, 123'),
    HealthCenter('Clínica Médica', 'Rua Médica, 456'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centros de Saúde'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: _healthCenters.map((healthCenter) {
          return ListTile(
            leading: Icon(Icons.local_hospital, color: Colors.purple),
            title: Text(healthCenter.name),
            subtitle: Text(healthCenter.address),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final _nameController = TextEditingController();
              final _addressController = TextEditingController();
              return AlertDialog(
                title: Text('Adicionar Centro de Saúde'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome do centro de saúde',
                      ),
                    ),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Endereço do centro de saúde',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _healthCenters.add(HealthCenter(
                          _nameController.text,
                          _addressController.text,
                        ));
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

// Modelo de Atividade
class Activity {
  String name;
  String duration;

  Activity(this.name, this.duration);
}

// Modelo de Medicamento
class Medication {
  String name;
  String time;
  bool enabled;

  Medication(this.name, this.time, this.enabled);
}

// Modelo de Centro de Saúde
class HealthCenter {
  String name;
  String address;

  HealthCenter(this.name, this.address);
}

// Tela de Cadastro
class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _regiao = '';
  String _email = '';
  String _senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cadastro',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(142, 31, 179, 1.0),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _nome = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Região',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma região';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _regiao = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma senha';
                    } else if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _senha = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Simulação de cadastro com validação
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      });
                    }
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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