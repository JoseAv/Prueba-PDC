import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerEditar extends StatefulWidget {
  const PerEditar({super.key});

  @override
  _PerEditarState createState() => _PerEditarState();
}

class _PerEditarState extends State<PerEditar> {
  final TextEditingController _idpersona = TextEditingController();
  final TextEditingController _nombrecompleto = TextEditingController();
  final TextEditingController _pais = TextEditingController();
  final TextEditingController _departamento = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  bool _loading = false;
  bool _isSearchFieldReadOnly = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _isSearchFieldReadOnly = false; // Inicialmente el campo es editable

    _idpersona.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _idpersona.dispose(); // Dispose of the TextEditingController
    _nombrecompleto.dispose();
    _pais.dispose();
    _departamento.dispose();
    _direccion.dispose();
    super.dispose();
  }

  void _search() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _isSearchFieldReadOnly = true;
    });

    final id = _idpersona.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/per/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            _idpersona.text = data[0]['idpersona'].toString();
            _nombrecompleto.text = data[0]['nombrecompleto'];
            _pais.text = data[0]['pais'];
            _departamento.text = data[0]['departamento'];
            _direccion.text = data[0]['direccion'];
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void update() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _isSearchFieldReadOnly = true;
    });

    final id = _idpersona.text;
    final nombrecompleto = _nombrecompleto.text;
    final pais = _pais.text;
    final departamento = _departamento.text;
    final direccion = _direccion.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/per/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombrecompleto': nombrecompleto,
          'pais': pais,
          'departamento': departamento,
          'direccion': direccion,
        }),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            _errorMessage = 'Actualización exitosa';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idpersona,
              decoration: const InputDecoration(
                labelText: 'Buscar un Usuario',
              ),
              readOnly:
                  _isSearchFieldReadOnly, // Desactivar edición después de la búsqueda
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _search,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _nombrecompleto,
              decoration: const InputDecoration(
                labelText: 'Nombre de la persona',
              ),
            ),
            TextField(
              controller: _pais,
              decoration: const InputDecoration(
                labelText: 'Nombre del Pais',
              ),
              readOnly: true,
            ),
            TextField(
              controller: _departamento,
              decoration: const InputDecoration(
                labelText: 'Codigo Departamento',
              ),
              readOnly: true,
            ),
            TextField(
              controller: _direccion,
              decoration: const InputDecoration(
                labelText: 'Codigo Departamento',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : update,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Editar'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class PerCrear extends StatefulWidget {
  const PerCrear({super.key});

  @override
  PerCrearScreen createState() => PerCrearScreen();
}

class PerCrearScreen extends State<PerCrear> {
  final TextEditingController _nombrecompleto = TextEditingController();
  final TextEditingController _pais = TextEditingController();
  final TextEditingController _departamento = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nombrecompleto.dispose();
    _pais.dispose();
    _departamento.dispose();
    _direccion.dispose();
    super.dispose();
  }

  void create() async {
    final nombrecompleto = _nombrecompleto.text;
    final pais = _pais.text;
    final departamento = _departamento.text;
    final direccion = _direccion.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/per');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombrecompleto': nombrecompleto,
          'pais': pais,
          'departamento': departamento,
          'direccion': direccion
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _errorMessage = 'Creacion Exitosa';
          Navigator.pop(context);
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persona'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nombrecompleto,
              decoration: const InputDecoration(
                labelText: 'Nombre Persona',
              ),
            ),
            TextField(
              controller: _pais,
              decoration: const InputDecoration(
                labelText: 'Codigo Pais',
              ),
            ),
            TextField(
              controller: _departamento,
              decoration: const InputDecoration(
                labelText: 'Codigo Departamento',
              ),
            ),
            TextField(
              controller: _direccion,
              decoration: const InputDecoration(
                labelText: 'Direccion',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : create,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Crear'),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class PerDelete extends StatefulWidget {
  const PerDelete({super.key});

  @override
  _PerDeleteState createState() => _PerDeleteState();
}

class _PerDeleteState extends State<PerDelete> {
  final TextEditingController _idpersona = TextEditingController();
  bool _loading = false;
  bool _isSearchFieldReadOnly = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _isSearchFieldReadOnly = false; // Inicialmente el campo es editable

    _idpersona.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _idpersona.dispose(); // Dispose of the TextEditingController
    super.dispose();
  }

  void deletePerson() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    final id = _idpersona.text;
    final url = Uri.parse('http://10.0.2.2:4000/app/per/$id');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            _errorMessage = 'Eliminación exitosa';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Error: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idpersona,
              decoration: const InputDecoration(
                labelText: 'Buscar un Usuario',
              ),
              readOnly: _isSearchFieldReadOnly,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : deletePerson,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Eliminar'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
