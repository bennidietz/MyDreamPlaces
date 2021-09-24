enum MyCategory {
  beach, city, sights, unknown
}

class MyCategoryValues {
  final String icon;
  final String name;

  MyCategoryValues(this.icon, this.name);
}

final String OTHERS = 'others';

Map<String, MyCategoryValues> CATEGORIES() => {
  'beach': MyCategoryValues("🏝", "Strand"),
  'city': MyCategoryValues("🌇", "Stadt"),
  'adventure': MyCategoryValues("⛵", "Abenteuer"),
  'nature': MyCategoryValues("🌺", "Natur"),
  'sight': MyCategoryValues("🗽️", "Sehenswürdigkeit"),
  OTHERS : MyCategoryValues("🗺", "Andere"),
};