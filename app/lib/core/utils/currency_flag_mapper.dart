const Map<String, String> currencyToCountryMap = {
  'AUD': 'au', // Australia
  'BGN': 'bg', // Bulgaria
  'BRL': 'br', // Brazil
  'CAD': 'ca', // Canada
  'CHF': 'ch', // Switzerland
  'CNY': 'cn', // China
  'CZK': 'cz', // Czech Republic
  'DKK': 'dk', // Denmark
  'EUR': 'eu', // European Union (special flag)
  'GBP': 'gb', // United Kingdom
  'HKD': 'hk', // Hong Kong
  'INR': 'in', // India
  'JPY': 'jp', // Japan
  'KRW': 'kr', // South Korea
  'MYR': 'my', // Malaysia
  'NZD': 'nz', // New Zealand
  'PLN': 'pl', // Poland
  'SGD': 'sg', // Singapore
  'THB': 'th', // Thailand
  'USD': 'us', // United States
  'ZAR': 'za', // South Africa
};

String getFlagUrl(String currencyCode) {
  final countryCode = currencyToCountryMap[currencyCode.toUpperCase()] ?? 'un';
  return 'https://flagcdn.com/w40/$countryCode.png';
}
