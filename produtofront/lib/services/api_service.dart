import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:3000"; // URL do seu backend

  Future<List<dynamic>> fetchProdutos() async {
    final response = await http.get(Uri.parse('$baseUrl/produtos'));

    if (response.statusCode == 200) {
      return json.decode(response.body); // Lista de produtos
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<void> addProduto(Map<String, dynamic> produto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/produtos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar produto');
    }
  }

  Future<void> updateProduto(int id, Map<String, dynamic> produto) async {
    final response = await http.put(
      Uri.parse('$baseUrl/produtos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar produto');
    }
  }

  Future<void> deleteProduto(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/produtos/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar produto');
    }
  }
}
