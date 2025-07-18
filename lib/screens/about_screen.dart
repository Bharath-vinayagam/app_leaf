import 'package:flutter/material.dart';

class DiseaseInfo {
  final String name;
  final String? symptoms;
  final String? cure;
  final String? tips;
  final String? status;

  DiseaseInfo({
    required this.name,
    this.symptoms,
    this.cure,
    this.tips,
    this.status,
  });
}

final List<DiseaseInfo> diseaseInfos = [
  DiseaseInfo(
    name: "Apple Apple Scab",
    symptoms: "Dark, velvety lesions on leaves and fruit; fruit may become deformed.",
    cure: "Prune infected twigs, remove fallen leaves, and apply fungicides in early spring.",
  ),
  DiseaseInfo(
    name: "Apple Black Rot",
    symptoms: "Concentric black rings on fruit, leaf spots, and cankers on branches.",
    cure: "Destroy affected fruit and limbs; apply sulfur-based sprays during early growth stages.",
  ),
  DiseaseInfo(
    name: "Apple Cedar Apple Rust",
    symptoms: "Bright orange or rust-colored spots on leaves and fruit.",
    cure: "Remove nearby cedar hosts and apply fungicide starting at bud break every 7–10 days.",
  ),
  DiseaseInfo(
    name: "Apple Healthy",
    status: "No visible signs of disease.",
    tips: "Practice regular pruning, seasonal fertilization, and apply preventive sprays annually.",
  ),
  DiseaseInfo(
    name: "Blueberry Healthy",
    status: "Plant is healthy and growing well.",
    tips: "Maintain pH at 4.5–5.5, use acidic fertilizer, and ensure proper drainage.",
  ),
  DiseaseInfo(
    name: "Cherry (incl. Sour) Powdery Mildew",
    symptoms: "White, powdery growth on leaves, stems, or fruit.",
    cure: "Improve airflow by pruning and apply sulfur or neem oil-based fungicides.",
  ),
  DiseaseInfo(
    name: "Cherry (incl. Sour) Healthy",
    status: "No signs of infection or stress.",
    tips: "Provide full sun, adequate watering, and annual pruning to maintain vigor.",
  ),
  DiseaseInfo(
    name: "Corn (Maize) Cercospora / Gray Leaf Spot",
    symptoms: "Narrow, tan-colored elongated lesions on lower leaves.",
    cure: "Rotate crops, remove debris, and plant resistant corn hybrids.",
  ),
  DiseaseInfo(
    name: "Corn (Maize) Common Rust",
    symptoms: "Small reddish-brown pustules on both leaf surfaces.",
    cure: "Apply fungicide early and use rust-resistant varieties.",
  ),
  DiseaseInfo(
    name: "Corn (Maize) Northern Leaf Blight",
    symptoms: "Long, gray-green lesions shaped like cigars.",
    cure: "Use resistant hybrids and apply fungicides at early symptom onset.",
  ),
  DiseaseInfo(
    name: "Corn (Maize) Healthy",
    status: "Plants are healthy and vigorous.",
    tips: "Monitor for pests, maintain soil fertility, and provide sufficient nitrogen.",
  ),
  DiseaseInfo(
    name: "Grape Black Rot",
    symptoms: "Circular brown leaf spots; fruit shrivels and turns black.",
    cure: "Remove and destroy affected vines and apply protective fungicide regularly.",
  ),
  DiseaseInfo(
    name: "Grape Esca (Black Measles)",
    symptoms: "Leaf streaking between veins, black fruit spots, vine decline.",
    cure: "Remove infected plants, prevent over-irrigation, and reduce vine stress.",
  ),
  DiseaseInfo(
    name: "Grape Leaf Blight (Isariopsis Leaf Spot)",
    symptoms: "Irregular brown leaf spots with yellowing.",
    cure: "Remove affected leaves and apply copper-based fungicides.",
  ),
  DiseaseInfo(
    name: "Grape Healthy",
    status: "Vines are productive and disease-free.",
    tips: "Provide proper trellising, humidity control, and seasonal pruning.",
  ),
  DiseaseInfo(
    name: "Orange Huanglongbing (Citrus Greening)",
    symptoms: "Yellow shoots, uneven fruit, premature drop.",
    cure: "Remove infected trees and control psyllids using systemic insecticides.",
  ),
  DiseaseInfo(
    name: "Peach Bacterial Spot",
    symptoms: "Small dark spots on leaves and sunken lesions on fruit.",
    cure: "Apply copper sprays and grow resistant cultivars.",
  ),
  DiseaseInfo(
    name: "Peach Healthy",
    status: "Tree is in healthy condition.",
    tips: "Maintain pruning, fertilization, and proper irrigation.",
  ),
  DiseaseInfo(
    name: "Pepper (Bell) Bacterial Spot",
    symptoms: "Greasy-looking spots on leaves and scab-like lesions on fruits.",
    cure: "Remove infected leaves and apply copper-based spray. Avoid overhead watering.",
  ),
  DiseaseInfo(
    name: "Pepper (Bell) Healthy",
    status: "No signs of pest or disease.",
    tips: "Stake plants for support and mulch to retain moisture.",
  ),
  DiseaseInfo(
    name: "Potato Early Blight",
    symptoms: "Dark spots with concentric rings on older leaves.",
    cure: "Rotate crops, remove debris, and apply fungicide early.",
  ),
  DiseaseInfo(
    name: "Potato Late Blight",
    symptoms: "Water-soaked lesions with white fungal growth on underside.",
    cure: "Remove infected plants quickly and apply copper fungicides.",
  ),
  DiseaseInfo(
    name: "Potato Healthy",
    status: "Healthy leaves and tuber development.",
    tips: "Ensure proper soil drainage and avoid overwatering.",
  ),
  DiseaseInfo(
    name: "Raspberry Healthy",
    status: "The plant shows no signs of disease or pest infestation.",
    tips: "Regularly inspect canes for pests like raspberry beetles and aphids. Support the plants with proper trellising to improve airflow and sunlight penetration. Mulch around the base to retain moisture and suppress weeds.",
  ),
  DiseaseInfo(
    name: "Soybean Healthy",
    status: "The plant is thriving and developing well.",
    tips: "Monitor for soil-borne pests such as nematodes and rootworms. Practice crop rotation annually to prevent disease buildup. Ensure adequate irrigation and apply nitrogen-fixing inoculants to enhance soil health.",
  ),
  DiseaseInfo(
    name: "Squash Powdery Mildew",
    symptoms: "White, powdery fungal spots appear on both sides of leaves, often starting on the older leaves.",
    cure: "Apply neem oil or sulfur-based fungicide. Space plants adequately to promote airflow and reduce humidity. Water plants at the base to avoid leaf wetness, which promotes mildew growth.",
  ),
  DiseaseInfo(
    name: "Strawberry Leaf Scorch",
    symptoms: "Brown edges on older leaves, sometimes spreading inward and causing leaf curling or drying.",
    cure: "Prune and remove infected leaves promptly. Avoid overhead irrigation to reduce moisture on foliage. Ensure good spacing between plants for air circulation.",
  ),
  DiseaseInfo(
    name: "Strawberry Healthy",
    status: "No signs of disease or pest attack.",
    tips: "Fertilize regularly with balanced nutrients. Weed around the plants to prevent competition. Maintain slightly acidic soil and mulch around the base to retain moisture.",
  ),
  DiseaseInfo(
    name: "Tomato Bacterial Spot",
    symptoms: "Small, dark spots on leaves, stems, and sometimes fruit. Leaves may turn yellow and fall off.",
    cure: "Apply copper-based fungicides. Remove and destroy affected leaves. Avoid working with wet plants and rotate crops annually.",
  ),
  DiseaseInfo(
    name: "Tomato Early Blight",
    symptoms: "Dark brown spots with concentric rings on lower leaves. May cause leaf yellowing and defoliation.",
    cure: "Mulch the base of plants to reduce soil splash. Remove infected leaves and apply fungicide if needed. Practice crop rotation.",
  ),
  DiseaseInfo(
    name: "Tomato Late Blight",
    symptoms: "Water-soaked lesions on leaves, stems, and fruits. Rapid spreading in wet conditions.",
    cure: "Remove and destroy infected plants immediately. Use blight-resistant tomato varieties. Avoid overhead watering and apply preventive fungicides during outbreaks.",
  ),
  DiseaseInfo(
    name: "Tomato Leaf Mold",
    symptoms: "Yellow patches on upper leaf surfaces with fuzzy gray or olive mold underneath.",
    cure: "Improve greenhouse or garden ventilation. Water at the base of the plants. Use fungicides like chlorothalonil if infection persists.",
  ),
  DiseaseInfo(
    name: "Tomato Septoria Leaf Spot",
    symptoms: "Small, circular brown spots with gray centers on leaves. Premature leaf drop.",
    cure: "Remove infected leaves and dispose of them away from the garden. Avoid overhead watering. Use a fungicide and rotate crops yearly.",
  ),
  DiseaseInfo(
    name: "Tomato Spider Mites (Two-Spotted)",
    symptoms: "Fine webbing under leaves, tiny yellow or white speckles, leaf curling.",
    cure: "Spray with insecticidal soap or neem oil. Maintain humidity around plants and rinse leaves with water to dislodge mites.",
  ),
  DiseaseInfo(
    name: "Tomato Target Spot",
    symptoms: "Dark brown circular lesions with concentric rings on leaves and fruits.",
    cure: "Apply copper-based fungicide. Practice crop rotation and remove crop debris after harvesting to reduce spore sources.",
  ),
  DiseaseInfo(
    name: "Tomato Yellow Leaf Curl Virus",
    symptoms: "Yellowing and upward curling of young leaves, stunted growth.",
    cure: "Control whiteflies using sticky traps or insecticides. Use resistant tomato varieties and remove infected plants immediately.",
  ),
  DiseaseInfo(
    name: "Tomato Mosaic Virus",
    symptoms: "Mottled or mosaic yellow-green leaf patterns, stunted growth, malformed fruit.",
    cure: "Uproot and destroy infected plants. Disinfect tools regularly. Do not smoke near tomato plants, as the virus can spread from tobacco products.",
  ),
  DiseaseInfo(
    name: "Tomato Healthy",
    status: "No signs of disease or stress.",
    tips: "Support plants with stakes or cages. Fertilize every 2–3 weeks with balanced tomato fertilizer. Water deeply and consistently at the soil level to prevent leaf diseases.",
  ),
];

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String searchQuery = '';
  String? selectedClass;

  List<String> get classOptions {
    final Set<String> classes = {};
    for (final d in diseaseInfos) {
      final match = RegExp(r'^[A-Za-z]+').firstMatch(d.name);
      if (match != null) classes.add(match.group(0)!);
    }
    return classes.toList()..sort();
  }

  List<DiseaseInfo> get filteredDiseases {
    return diseaseInfos.where((d) {
      final matchesSearch = searchQuery.isEmpty ||
          d.name.toLowerCase().startsWith(searchQuery.toLowerCase());
      final matchesClass = selectedClass == null ||
          d.name.toLowerCase().startsWith(selectedClass!.toLowerCase());
      return matchesSearch && matchesClass;
    }).toList();
  }

  void showFilterDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              title: const Text('All'),
              onTap: () => Navigator.pop(context, null),
            ),
            ...classOptions.map((c) => ListTile(
              title: Text(c),
              onTap: () => Navigator.pop(context, c),
            )),
          ],
        );
      },
    );
    if (result != null || result == null) {
      setState(() {
        selectedClass = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.eco, color: Colors.white),
            const SizedBox(width: 10),
            const Text("📚 About Leaf Diseases"),
          ],
        ),
        elevation: 4,
        backgroundColor: const Color(0xFF047857),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe0f2f1), Color(0xfff1f8f4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search leaf disease...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      ),
                      onChanged: (value) => setState(() => searchQuery = value),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton.icon(
                      onPressed: showFilterDialog,
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filter'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 2 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: filteredDiseases.length,
                  itemBuilder: (context, idx) {
                    final disease = filteredDiseases[idx];
                    final isHealthy = (disease.status?.toLowerCase().contains('healthy') ?? false) || (disease.tips != null && disease.symptoms == null && disease.cure == null);
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 8,
                      shadowColor: isHealthy ? Colors.green.shade100 : Colors.orange.shade100,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isHealthy ? Icons.eco : Icons.warning_amber_rounded,
                                    color: isHealthy ? Colors.green : Colors.orange,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      disease.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isHealthy ? Colors.green.shade800 : Colors.orange.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if (disease.symptoms != null)
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(text: 'Symptoms: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      TextSpan(text: disease.symptoms!, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                                    ],
                                  ),
                                ),
                              if (disease.cure != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(text: 'Cure: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        TextSpan(text: disease.cure!, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              if (disease.status != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text("Status: ${disease.status!}", style: TextStyle(fontSize: 16, color: isHealthy ? Colors.green.shade700 : Colors.orange.shade700)),
                                ),
                              if (disease.tips != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text("Tips: ${disease.tips!}", style: const TextStyle(fontSize: 16, color: Colors.black87)),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 