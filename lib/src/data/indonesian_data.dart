part of '../../darturbation.dart';

/// A comprehensive collection of Indonesian-specific data sources.
///
/// This class provides static lists and methods for generating authentic
/// Indonesian names, addresses, phone numbers, product brands, and other
/// localized data. It is crucial for the 'Indonesian-First' approach of Darturbation.
class IndonesianData {
  /// A list of common Indonesian male first names.
  static const List<String> maleNames = [
    'Agus',
    'Ahmad',
    'Andi',
    'Budi',
    'Dani',
    'Dedi',
    'Eka',
    'Fadil',
    'Gilang',
    'Hendra',
    'Irwan',
    'Joko',
    'Kiki',
    'Lukman',
    'Made',
    'Nanda',
    'Oki',
    'Pandu',
    'Reza',
    'Sandi',
    'Tono',
    'Ujang',
    'Vino',
    'Wawan',
    'Yudi',
    'Zaki',
    'Adit',
    'Bayu',
    'Candra',
    'Dimas',
    'Eko',
    'Fajar',
    'Galih',
    'Hadi',
    'Indra',
    'Jaya',
    'Krisna',
    'Luthfi',
    'Maulana',
    'Nabil',
    'Omar',
    'Panji',
    'Rama',
    'Satrio',
    'Teguh',
    'Usman',
    'Vega',
    'Wahyu',
    'Yusuf',
    'Zulfikar',
    'Arif',
    'Bima',
    'Chandra',
    'Doni',
    'Erwin',
    'Feri',
    'Gunawan',
    'Hakim',
    'Ivan',
    'Jefri',
    'Rian',
    'Soleh',
    'Tito',
    'Vian',
    'Wira',
    'Yoga',
    'Zainal',
    'Adam',
    'Benny',
    'Daffa'
  ];

  /// A list of common Indonesian female first names.
  static const List<String> femaleNames = [
    'Ayu',
    'Bella',
    'Citra',
    'Desi',
    'Elsa',
    'Fitri',
    'Gita',
    'Hani',
    'Indah',
    'Jihan',
    'Kartika',
    'Layla',
    'Maya',
    'Nisa',
    'Olivia',
    'Putri',
    'Rara',
    'Sari',
    'Tari',
    'Ulfa',
    'Vina',
    'Wulan',
    'Yuni',
    'Zahra',
    'Anisa',
    'Bunga',
    'Cahya',
    'Dewi',
    'Erna',
    'Fani',
    'Galuh',
    'Hesti',
    'Ika',
    'Jasmine',
    'Kirana',
    'Lina',
    'Mita',
    'Nova',
    'Okta',
    'Prita',
    'Ratna',
    'Sinta',
    'Tika',
    'Umi',
    'Vera',
    'Wati',
    'Yanti',
    'Zara',
    'Aisyah',
    'Berlian',
    'Cantika',
    'Diana',
    'Evi',
    'Farah',
    'Ghea',
    'Hilda',
    'Intan',
    'Julia',
    'Kania',
    'Lestari',
    'Rina',
    'Siska',
    'Tina',
    'Vika',
    'Winda',
    'Yulia',
    'Zaskia',
    'Amelia',
    'Bianca',
    'Clara'
  ];

  /// A list of common Indonesian last names (surnames).
  static const List<String> lastNames = [
    'Santoso',
    'Wijaya',
    'Kurniawan',
    'Sari',
    'Lestari',
    'Pratama',
    'Wibowo',
    'Susanto',
    'Permana',
    'Rahayu',
    'Sutrisno',
    'Hidayat',
    'Setiawan',
    'Purnomo',
    'Utomo',
    'Winarto',
    'Cahyono',
    'Nugroho',
    'Priyanto',
    'Suryadi',
    'Marpaung',
    'Simanjuntak',
    'Sitorus',
    'Panjaitan',
    'Siahaan',
    'Hutapea',
    'Pardede',
    'Manurung',
    'Simbolon',
    'Nababan',
    'Situmorang',
    'Tampubolon',
    'Silalahi',
    'Hasibuan',
    'Simatupang',
    'Napitupulu',
    'Pasaribu',
    'Hutasoit',
    'Siregar',
    'Lumbantobing',
    'Nainggolan',
    'Situmeang',
    'Samosir',
    'Sinaga',
    'Turnip',
    'Butarbutar',
    'Ginting',
    'Tarigan',
    'Sembiring',
    'Karo',
    'Sitepu',
    'Nasution',
    'Lubis',
    'Harahap',
    'Daulay',
    'Tanjung',
    'Rangkuti',
    'Pulungan',
    'Batubara',
    'Pohan'
  ];

  /// A list of major Indonesian cities.
  static const List<String> cities = [
    'Jakarta',
    'Surabaya',
    'Bandung',
    'Bekasi',
    'Medan',
    'Tangerang',
    'Depok',
    'Semarang',
    'Palembang',
    'Makassar',
    'Batam',
    'Bogor',
    'Pekanbaru',
    'Bandar Lampung',
    'Malang',
    'Padang',
    'Yogyakarta',
    'Samarinda',
    'Denpasar',
    'Balikpapan',
    'Pontianak',
    'Jambi',
    'Cimahi',
    'Surakarta',
    'Manado',
    'Serang',
    'Cilegon',
    'Mataram',
    'Banjarmasin',
    'Tegal',
    'Palu',
    'Kendari',
    'Ambon',
    'Jayapura',
    'Kupang',
    'Cirebon',
    'Sukabumi',
    'Tasikmalaya',
    'Pekalongan',
    'Magelang'
  ];

  /// A map linking major Indonesian provinces to their respective cities.
  static const Map<String, List<String>> provinces = {
    'Jakarta': [
      'Jakarta Selatan',
      'Jakarta Barat',
      'Jakarta Timur',
      'Jakarta Utara',
      'Jakarta Pusat'
    ],
    'Jawa Barat': [
      'Bandung',
      'Bekasi',
      'Bogor',
      'Depok',
      'Cimahi',
      'Sukabumi',
      'Cirebon'
    ],
    'Jawa Timur': [
      'Surabaya',
      'Malang',
      'Mojokerto',
      'Pasuruan',
      'Probolinggo'
    ],
    'Jawa Tengah': ['Semarang', 'Surakarta', 'Tegal', 'Pekalongan', 'Magelang'],
    'Sumatera Utara': ['Medan', 'Binjai', 'Tebing Tinggi', 'Pematangsiantar'],
    'Sumatera Barat': ['Padang', 'Bukittinggi', 'Payakumbuh', 'Sawahlunto'],
    'Banten': ['Tangerang', 'Serang', 'Cilegon', 'Tangerang Selatan'],
    'Bali': ['Denpasar', 'Tabanan', 'Gianyar', 'Klungkung'],
    'Kalimantan Timur': ['Balikpapan', 'Samarinda', 'Bontang', 'Tarakan'],
    'Sulawesi Selatan': ['Makassar', 'Palopo', 'Parepare', 'Sungguminasa']
  };

  /// A list of common Indonesian street names.
  static const List<String> streetNames = [
    'Jl. Sudirman',
    'Jl. Thamrin',
    'Jl. Gatot Subroto',
    'Jl. Rasuna Said',
    'Jl. Kuningan',
    'Jl. Merdeka',
    'Jl. Diponegoro',
    'Jl. Ahmad Yani',
    'Jl. Gajah Mada',
    'Jl. Hayam Wuruk',
    'Jl. Veteran',
    'Jl. Proklamasi',
    'Jl. Cikditiro',
    'Jl. Kebon Sirih',
    'Jl. Menteng',
    'Jl. Pegangsaan',
    'Jl. Cempaka Putih',
    'Jl. Pramuka',
    'Jl. Matraman',
    'Jl. Salemba',
    'Jl. Cikini',
    'Jl. Gondangdia',
    'Jl. Kramat',
    'Jl. Senen',
    'Jl. Kemayoran',
    'Jl. Mangga Besar',
    'Jl. Pintu Kecil',
    'Jl. Pluit',
    'Jl. Ancol',
    'Jl. Kelapa Gading',
    'Jl. Sunter',
    'Jl. Pantai Indah Kapuk',
    'Jl. Kamal',
    'Jl. Raya Ciledug',
    'Jl. Bintaro',
    'Jl. Pondok Indah',
    'Jl. Kemang',
    'Jl. Ampera',
    'Jl. Warung Buncit',
    'Jl. Pasar Minggu',
    'Jl. Ragunan'
  ];

  /// A list of common product brands, including local Indonesian brands.
  static const List<String> productBrands = [
    // Electronics
    'Samsung', 'Apple', 'Xiaomi', 'Oppo', 'Vivo', 'Realme', 'Asus', 'Acer',
    'Lenovo', 'Dell', 'HP', 'Sony', 'LG', 'Panasonic', 'Sharp', 'Polytron',

    // Fashion
    'Uniqlo', 'H&M', 'Zara', 'Adidas', 'Nike', 'Puma', 'Cardinal', 'Hammer',
    'Eiger', 'Consina', 'Bodypack', 'Exsport', 'Jansport', 'Kipling',

    // Local Indonesian brands
    'Tzu', 'Erigo', 'Greenlight', 'Cottonink', 'Minimal', 'Berrybenka',
    'Love Bonito', 'Pomelo', 'Zalora', 'Shopee', 'Tokopedia', 'Blibli',

    // Food & Beverage
    'Indomie', 'Sedaap', 'ABC', 'Bango', 'Royco', 'Masako', 'Sajiku',
    'Teh Botol Sosro', 'Aqua', 'Le Minerale', 'Pocari Sweat', 'Mizone'
  ];

  /// Brand mappings by category for more realistic product generation
  static const Map<String, List<String>> brandsByCategory = {
    'electronics': [
      'Samsung',
      'Apple',
      'Xiaomi',
      'Oppo',
      'Vivo',
      'Realme',
      'Asus',
      'Acer',
      'Lenovo',
      'Dell',
      'HP',
      'Sony',
      'LG',
      'Panasonic',
      'Sharp',
      'Polytron'
    ],
    'fashion': [
      'Uniqlo',
      'H&M',
      'Zara',
      'Adidas',
      'Nike',
      'Puma',
      'Cardinal',
      'Hammer',
      'Eiger',
      'Consina',
      'Tzu',
      'Erigo',
      'Greenlight',
      'Cottonink',
      'Minimal'
    ],
    'home': [
      'Panasonic',
      'Sharp',
      'Polytron',
      'LG',
      'Samsung',
      'Philips',
      'Electrolux',
      'Oxone',
      'Miyako',
      'Cosmos',
      'Maspion',
      'Lock&Lock'
    ],
    'books': [
      'Gramedia',
      'Erlangga',
      'Mizan',
      'Bentang Pustaka',
      'Republika',
      'Kompas',
      'Elex Media',
      'Grasindo',
      'Andi Publisher'
    ],
    'food': [
      'Indomie',
      'Sedaap',
      'ABC',
      'Bango',
      'Royco',
      'Masako',
      'Sajiku',
      'Teh Botol Sosro',
      'Aqua',
      'Le Minerale',
      'Pocari Sweat',
      'Mizone',
      'Indofood',
      'Wings Food',
      'Mayora',
      'Khong Guan'
    ],
    'health': [
      'Wardah',
      'Emina',
      'Pigeon',
      'Cussons',
      'Lifebuoy',
      'Dove',
      'LOreal',
      'Garnier',
      'Olay',
      'Ponds',
      'Vaseline',
      'Nivea',
      'Biore'
    ],
    'sports': [
      'Adidas',
      'Nike',
      'Puma',
      'Specs',
      'Ortuseight',
      'Mizuno',
      'Yonex',
      'Li-Ning',
      'Diadora',
      'Umbro',
      'Kappa',
      'Eagle'
    ],
  };

  /// A map defining various product categories and their associated subcategories.
  static const Map<String, List<String>> productCategories = {
    'electronics': [
      'smartphone',
      'laptop',
      'tablet',
      'headphone',
      'speaker',
      'camera',
      'smartwatch',
      'keyboard',
      'mouse',
      'monitor',
      'tv',
      'gaming console'
    ],
    'fashion': [
      'kaos',
      'kemeja',
      'celana',
      'dress',
      'rok',
      'jaket',
      'sepatu',
      'sandal',
      'tas',
      'dompet',
      'jam tangan',
      'perhiasan',
      'kacamata',
      'topi'
    ],
    'home': [
      'furniture',
      'dekorasi',
      'peralatan dapur',
      'peralatan mandi',
      'bedding',
      'lampu',
      'karpet',
      'gorden',
      'tanaman',
      'alat kebersihan'
    ],
    'books': [
      'novel',
      'komik',
      'buku pelajaran',
      'buku motivasi',
      'buku agama',
      'buku masak',
      'buku teknik',
      'majalah',
      'kamus',
      'ensiklopedia'
    ],
    'food': [
      'makanan ringan',
      'minuman',
      'bumbu masak',
      'makanan instan',
      'kue kering',
      'coklat',
      'permen',
      'es krim',
      'roti',
      'buah'
    ],
    'health': [
      'vitamin',
      'suplemen',
      'obat',
      'alat kesehatan',
      'produk kecantikan',
      'skincare',
      'makeup',
      'parfum',
      'sabun',
      'shampo'
    ],
    'sports': [
      'sepatu olahraga',
      'baju olahraga',
      'alat fitness',
      'bola',
      'raket',
      'helm',
      'sepeda',
      'skateboard',
      'matras yoga',
      'dumbbell'
    ]
  };

  /// A list of common Indonesian payment methods.
  static const List<String> paymentMethods = [
    'GoPay',
    'OVO',
    'DANA',
    'ShopeePay',
    'LinkAja',
    'Jenius Pay',
    'Transfer Bank',
    'BCA Virtual Account',
    'Mandiri Virtual Account',
    'BNI Virtual Account',
    'BRI Virtual Account',
    'Alfamart',
    'Indomaret',
    'Credit Card',
    'Debit Card',
    'COD (Cash on Delivery)',
    'QRIS',
    'PayLater',
    'Kredivo',
    'Akulaku'
  ];

  /// A list of standard e-commerce order statuses.
  static const List<String> orderStatuses = [
    'pending',
    'confirmed',
    'processing',
    'shipped',
    'delivered',
    'completed',
    'cancelled',
    'refunded',
    'returned',
    'failed'
  ];

  /// A list of common Indonesian review titles.
  static const List<String> reviewTitles = [
    'Barang bagus banget!',
    'Sesuai ekspektasi',
    'Kualitas oke',
    'Recommended!',
    'Puas dengan pembelian',
    'Barang original',
    'Pengiriman cepat',
    'Mantap jiwa',
    'Worth it banget',
    'Gak nyesel beli',
    'Barang sesuai foto',
    'Kualitas mantap',
    'Pelayanan memuaskan',
    'Barang sampai dengan selamat',
    'Packingnya rapi',
    'Harga sebanding kualitas',
    'Barang mulus',
    'Seller responsif',
    'Thanks gan!',
    'Barang cepat sampai',
    'Kualitas premium',
    'Sangat puas',
    'Barang berkualitas',
    'Sesuai deskripsi',
    'Pengalaman berbelanja yang menyenangkan'
  ];

  /// A list of common Indonesian review comments.
  static const List<String> reviewComments = [
    'Barangnya bagus banget, sesuai dengan yang di foto. Pengiriman juga cepat. Penjual responsif dan ramah. Packing rapi dan aman. Terima kasih!',
    'Kualitas produk sangat baik, material premium dan finishing rapi. Harga sebanding dengan kualitas. Recommended seller!',
    'Produk ori dan berkualitas. Pengiriman cepat dan packing aman. Pelayanan penjual sangat memuaskan. Pasti order lagi.',
    'Barang sesuai ekspektasi, kualitas oke dan harga terjangkau. Pengiriman agak lama tapi masih dalam batas wajar.',
    'Sangat puas dengan pembelian ini. Barang berkualitas tinggi dan awet. Penjual profesional dan terpercaya.',
    'Produk original dan sesuai deskripsi. Packingnya rapi dan aman sampai tujuan. Terima kasih seller!',
    'Barang bagus, kualitas premium. Pengiriman cepat dan packing bubble wrap tebal. Penjual ramah dan responsif.',
    'Sesuai dengan gambar dan deskripsi. Kualitas baik dan harga bersaing. Pelayanan after sales juga baik.',
    'Produk berkualitas dengan harga yang wajar. Pengiriman tepat waktu dan kondisi barang perfect. Recommended!',
    'Barang ori dan kondisi mulus. Packing rapih dan aman. Penjual komunikatif dan fast respon. Sukses terus!',
    'Kualitas produk sangat memuaskan. Barang sesuai ekspektasi dan pengiriman cepat. Penjual terpercaya.',
    'Produk bagus dan berkualitas. Harga reasonable dan pelayanan excellent. Pasti beli lagi di sini.',
    'Barang sesuai foto dan deskripsi. Kualitas oke dan pengiriman cepat. Penjual ramah dan profesional.',
    'Sangat puas dengan kualitas produk. Barang original dan kondisi perfect. Pengiriman juga cepat banget.',
    'Produk berkualitas tinggi dengan harga yang kompetitif. Packing aman dan pengiriman tepat waktu. Recommended seller!'
  ];

  /// Generates a realistic Indonesian phone number.
  ///
  /// The phone number is generated using common Indonesian mobile prefixes
  /// and a random suffix.
  ///
  /// Returns a [String] representing an Indonesian phone number.
  static String generatePhoneNumber() {
    final prefixes = [
      '0811',
      '0812',
      '0813',
      '0814',
      '0815',
      '0816',
      '0817',
      '0818',
      '0819',
      '0821',
      '0822',
      '0823',
      '0851',
      '0852',
      '0853',
      '0855',
      '0856',
      '0857',
      '0858'
    ];
    final prefix = Darturbation.randomChoice(prefixes);
    final suffix = Darturbation.randomInt(1000000, 9999999);
    return '$prefix$suffix';
  }

  /// Generates a realistic email address based on first and last names.
  ///
  /// The email address uses common domain names and can include separators
  /// and numbers for variety.
  ///
  /// Parameters:
  /// - [firstName]: The first name of the user.
  /// - [lastName]: The last name of the user.
  ///
  /// Returns a [String] representing a generated email address.
  static String generateEmail(String firstName, String lastName) {
    final domains = [
      'gmail.com',
      'yahoo.com',
      'hotmail.com',
      'outlook.com',
      'ymail.com'
    ];
    final separators = ['', '.', '_', ''];
    final numbers = [
      '',
      '${Darturbation.randomInt(1, 999)}',
      '${Darturbation.randomInt(10, 99)}'
    ];

    final domain = Darturbation.randomChoice(domains);
    final separator = Darturbation.randomChoice(separators);
    final number = Darturbation.randomChoice(numbers);

    final username =
        '${firstName.toLowerCase()}$separator${lastName.toLowerCase()}$number';
    return '$username@$domain';
  }

  /// Generates a realistic Indonesian street address.
  ///
  /// The address includes a street name, house number, and RT/RW (neighborhood unit).
  ///
  /// Returns a [String] representing a generated Indonesian address.
  static String generateAddress() {
    final street = Darturbation.randomChoice(streetNames);
    final number = Darturbation.randomInt(1, 999);
    final rtRw =
        'RT ${Darturbation.randomInt(1, 20).toString().padLeft(2, '0')}/RW ${Darturbation.randomInt(1, 15).toString().padLeft(2, '0')}';
    return '$street No. $number, $rtRw';
  }

  /// Generates a random 5-digit postal code.
  ///
  /// Returns a [String] representing a generated postal code.
  static String generatePostalCode() {
    return Darturbation.randomInt(10000, 99999).toString();
  }

  /// Generates a product SKU (Stock Keeping Unit) based on the product category.
  ///
  /// The SKU is formed by the first three letters of the category (uppercase)
  /// followed by a random 6-digit number.
  ///
  /// Parameters:
  /// - [category]: The category of the product.
  ///
  /// Returns a [String] representing the generated SKU.
  static String generateSKU(String category) {
    final prefix = category.substring(0, 3).toUpperCase();
    final number = Darturbation.randomInt(100000, 999999);
    return '$prefix$number';
  }
}
