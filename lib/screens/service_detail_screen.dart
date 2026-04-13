import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/pet_service.dart';
import '../utils/app_theme.dart';
import 'booking_screen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final PetService service;

  const ServiceDetailScreen({super.key, required this.service});

  static const List<List<Color>> _gradients = [
    [Color(0xFFFFE0D6), Color(0xFFFFCCBB)],
    [Color(0xFFD6F0FF), Color(0xFFBBE3FF)],
    [Color(0xFFD6FFE8), Color(0xFFBBF0D0)],
    [Color(0xFFF5D6FF), Color(0xFFE8BBFF)],
  ];

  static const List<Map<String, String>> _reviews = [
    {'name': 'Priya S.', 'review': 'Amazing service! My dog loved it.', 'rating': '5'},
    {'name': 'Rahul M.', 'review': 'Very professional and caring staff.', 'rating': '4'},
    {'name': 'Anita K.', 'review': 'Great experience, will book again!', 'rating': '5'},
  ];

  @override
  Widget build(BuildContext context) {
    final idx = int.parse(service.id) - 1;
    final gradient = _gradients[idx % _gradients.length];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back, color: AppTheme.textDark),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(service.iconEmoji, style: const TextStyle(fontSize: 80)),
                ),
              ),
              title: Text(
                service.name,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price, Duration, Rating row
                  Row(
                    children: [
                      _infoChip('₹${service.price.toInt()}', Icons.currency_rupee, AppTheme.primary),
                      const SizedBox(width: 10),
                      _infoChip(service.duration, Icons.access_time, Colors.blue),
                      const SizedBox(width: 10),
                      _infoChip('${service.rating}★', Icons.star, Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Rating bar
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              service.rating.toString(),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textDark,
                              ),
                            ),
                            RatingBarIndicator(
                              rating: service.rating,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 18,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${service.reviewCount} reviews',
                              style: const TextStyle(
                                  fontSize: 12, color: AppTheme.textGrey),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [5, 4, 3].map((stars) {
                              final pct = stars == 5
                                  ? 0.7
                                  : stars == 4
                                      ? 0.2
                                      : 0.1;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  children: [
                                    Text('$stars',
                                        style: const TextStyle(
                                            fontSize: 12, color: AppTheme.textGrey)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: pct,
                                          backgroundColor: Colors.grey.shade100,
                                          color: Colors.amber,
                                          minHeight: 6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'About this Service',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.fullDescription,
                    style: const TextStyle(
                        fontSize: 14, color: AppTheme.textGrey, height: 1.6),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'What\'s Included',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 10),
                  ...service.includes.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE8F5E9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check,
                                  size: 14, color: AppTheme.success),
                            ),
                            const SizedBox(width: 10),
                            Text(item,
                                style: const TextStyle(
                                    fontSize: 14, color: AppTheme.textDark)),
                          ],
                        ),
                      )),

                  const SizedBox(height: 20),
                  const Text(
                    'Customer Reviews',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 10),
                  ..._reviews.map((r) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                                  child: Text(
                                    r['name']![0],
                                    style: const TextStyle(
                                        color: AppTheme.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r['name']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: AppTheme.textDark)),
                                    Row(
                                      children: List.generate(
                                        int.parse(r['rating']!),
                                        (_) => const Icon(Icons.star,
                                            size: 12, color: Colors.amber),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(r['review']!,
                                style: const TextStyle(
                                    fontSize: 13, color: AppTheme.textGrey)),
                          ],
                        ),
                      )),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookingScreen(service: service)),
          ),
          child: const Text('Book Appointment'),
        ),
      ),
    );
  }

  Widget _infoChip(String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
