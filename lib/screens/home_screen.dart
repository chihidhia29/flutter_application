import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../widgets/country_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les pays au démarrage
    Future.microtask(() =>
        context.read<CountryProvider>().loadCountries());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CountryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Explorer'), // MS-01
      ),
      body: RefreshIndicator(        // MS-05 Pull-to-refresh
        onRefresh: () => provider.loadCountries(),
        child: _buildBody(provider),
      ),
    );
  }

  Widget _buildBody(CountryProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    if (provider.countries.isEmpty) {
      return const Center(child: Text('No countries found.'));
    }

    return GridView.builder(        // MS-02
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,         // 2 colonnes
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: provider.countries.length,
      itemBuilder: (context, index) {
        final country = provider.countries[index];
        return CountryCard(         // MS-04 (StatelessWidget)
          country: country,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(country: country),
              ),
            );
          },
        );
      },
    );
  }
}
