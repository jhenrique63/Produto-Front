import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProdutosScreen(),
    );
  }
}

class ProdutosScreen extends StatefulWidget {
  @override
  _ProdutosScreenState createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> produtos = [];

  @override
  void initState() {
    super.initState();
    _loadProdutos();
  }

  // Função para carregar os produtos
  void _loadProdutos() async {
    try {
      final List<dynamic> loadedProdutos = await apiService.fetchProdutos();
      setState(() {
        produtos = loadedProdutos;
      });
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  // Função para adicionar um produto
  void _addProduto() async {
    final Map<String, dynamic> novoProduto = {
      "nome": "Novo Produto",
      "descricao": "Descrição do novo produto",
      "preco": 50.0,
      "estoque": 10,
    };

    try {
      await apiService.addProduto(novoProduto);
      _loadProdutos(); // Recarregar os produtos após adicionar
    } catch (e) {
      print('Erro ao adicionar produto: $e');
    }
  }

  // Função para atualizar um produto
  void _updateProduto(int id) async {
    final Map<String, dynamic> produtoAtualizado = {
      "nome": "Produto Atualizado",
      "descricao": "Nova descrição",
      "preco": 100.0,
      "estoque": 20,
    };

    try {
      await apiService.updateProduto(id, produtoAtualizado);
      _loadProdutos(); // Recarregar os produtos após atualização
    } catch (e) {
      print('Erro ao atualizar produto: $e');
    }
  }

  // Função para excluir um produto
  void _deleteProduto(int id) async {
    try {
      await apiService.deleteProduto(id);
      _loadProdutos(); // Recarregar os produtos após exclusão
    } catch (e) {
      print('Erro ao excluir produto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return ListTile(
            title: Text(produto['nome']),
            subtitle: Text(produto['descricao']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateProduto(produto['id']),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProduto(produto['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduto,
        child: Icon(Icons.add),
      ),
    );
  }
}
