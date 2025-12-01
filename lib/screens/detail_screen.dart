import 'package:flutter/material.dart';
import '../models/country.dart';

class DetailScreen extends StatefulWidget { // NV-04
  final Country country;

  const DetailScreen({super.key, required this.country});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false; // BONUS: tu pourras le relier à SharedPreferences

  @override
  Widget build(BuildContext context) {
    final country = widget.country;

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: country.flagUrl.isNotEmpty
                  ? Image.network(
                      country.flagUrl,
                      height: 150,
                    )
                  : const Icon(Icons.flag, size: 80),
            ),
            const SizedBox(height: 16),
            Text('Capital: ${country.capital}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Region: ${country.region}'),
            const SizedBox(height: 8),
            Text('Population: ${country.population}'),
            const SizedBox(height: 16),

            // BONUS : bouton favoris
            Row(
              children: [
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    // TODO BONUS : sauvegarder dans SharedPreferences
                  },
                ),
                const Text('Add to favorites'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
