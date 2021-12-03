class CatalogModel {
  String name;
  String subDesc;
  String price;
  String weight;
  String cpuSpeed;
  String cpuType;
  String ram;
  String rom;
  String os;
  String battery;

  CatalogModel(
      this.name,
      this.subDesc,
      this.price,
      this.weight,
      this.cpuSpeed,
      this.cpuType,
      this.ram,
      this.rom,
      this.os,
      this.battery,
      );
}

List<CatalogModel> catalog = catalogData.map(
        (item) => CatalogModel(
      item['name'].toString(),
      item['subDesc'].toString(),
      item['price'].toString(),
      item['weight'].toString(),
      item['cpuSpeed'].toString(),
      item['cpuType'].toString(),
      item['ram'].toString(),
      item['rom'].toString(),
      item['os'].toString(),
      item['battery'].toString(),
    )
).toList();

var catalogData = [
  {
    "name": "Galaxy A52",
    "subDesc": "Released in Des 2021",
    "price": 'Rp 5.399.000',
    "weight": '189g',
    "cpuSpeed": 'CPU Speed 2.3GHz, 1.8GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 8GB',
    "rom": 'ROM Size 256GB',
    "os": 'Android',
    "battery": '4500 mAh',
  },
  {
    "name": 'Galaxy A72',
    "subDesc": "Released in Jan 2021",
    "price": 'Rp 5.699.000',
    "weight": '203g',
    "cpuSpeed": 'CPU Speed 2.3GHz, 1.8GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 8GB',
    "rom": 'ROM Size 128GB',
    "os": 'Android',
    "battery": '5000 mAh',
  },
  {
    "name": 'Galaxy M32',
    "subDesc": "Released in March 2021",
    "price": 'Rp 3.299.000',
    "weight": '180g',
    "cpuSpeed": 'CPU Speed 2GHz, 1.8GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 8GB',
    "rom": 'ROM Size 128GB',
    "os": 'Android',
    "battery": '5000 mAh',
  },
  {
    "name": 'Galaxy M62',
    "subDesc": "Released in Feb 2021",
    "price": 'Rp 5.999.000',
    "weight": '218g',
    "cpuSpeed": 'CPU Speed 2.73GHz, 2.4GHz, 1.95GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 8GB',
    "rom": 'ROM Size 256GB',
    "os": 'Android',
    "battery": '7000 mAh',
  },
  {
    "name": 'Galaxy S21 Ultra 5G',
    "subDesc": "Released in May 2020",
    "price": 'Rp 13.999.000',
    "weight": '169g',
    "cpuSpeed": 'CPU Speed 2.9GHz, 2.8GHz, 2.2GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 8GB',
    "rom": 'ROM Size 128GB',
    "os": 'Android',
    "battery": '4000 mAh',
  },
  {
    "name": 'Galaxy Z Fold2',
    "subDesc": "Released in April 2021",
    "price": 'Rp 24.999.000',
    "weight": '208g',
    "cpuSpeed": 'CPU Speed 3.09GHz, 2.4GHz, 1.8GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 12GB',
    "rom": 'ROM Size 256GB',
    "os": 'Android',
    "battery": '4500 mAh',
  },
  {
    "name": 'Galaxy Z Fold3 5G',
    "subDesc": "Released in July 2021",
    "price": 'Rp 24.999.000',
    "weight": '271g',
    "cpuSpeed": 'CPU Speed 2.84GHz, 2.4GHz, 1.8GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 12GB',
    "rom": 'ROM Size 256GB',
    "os": 'Android',
    "battery": '4500mAh',
  },
  {
    "name": 'Galaxy A03s',
    "subDesc": "Released in Aug 2021",
    "price": 'Rp 1.799.000',
    "weight": '196g',
    "cpuSpeed": 'CPU Speed 2.3GHz, 1.8GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 4GB',
    "rom": 'ROM Size 64GB',
    "os": 'Android',
    "battery": '5000 mAh',
  },
  {
    "name": 'Galaxy M52 5G',
    "subDesc": "Released in Aug 2021",
    "price": 'Rp 5.399.000',
    "weight": '173g',
    "cpuSpeed": 'CPU Speed 2.4GHz, 1.8GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 8GB',
    "rom": 'ROM Size 128GB',
    "os": 'Android',
    "battery": '5000 mAh',
  },
  {
    "name": 'Galaxy A22 5G',
    "subDesc": "Released in July 2021",
    "price": 'Rp 3.299.000',
    "weight": '203',
    "cpuSpeed": 'CPU Speed 2.2GHz, 2GHz',
    "cpuType": 'CPU Type Octa-Core',
    "ram": 'RAM Size 6GB',
    "rom": 'ROM Size 128GB',
    "os": 'Android',
    "battery": '5000 mAh',
  }
];
