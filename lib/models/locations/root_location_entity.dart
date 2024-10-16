class LocationBody {
  String? type;
  String? licence;
  List<Features>? features;

  LocationBody({this.type, this.licence, this.features});

  LocationBody.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    licence = json['licence'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['licence'] = this.licence;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? type;
  Properties? properties;
  List<double>? bbox;
  Geometry? geometry;

  Features({this.type, this.properties, this.bbox, this.geometry});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    bbox = json['bbox'].cast<double>();
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['bbox'] = this.bbox;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    return data;
  }
}

class Properties {
  int? placeId;
  String? osmType;
  int? osmId;
  int? placeRank;
  String? category;
  String? type;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  Address? address;

  Properties(
      {this.placeId,
      this.osmType,
      this.osmId,
      this.placeRank,
      this.category,
      this.type,
      this.importance,
      this.addresstype,
      this.name,
      this.displayName,
      this.address});

  Properties.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    placeRank = json['place_rank'];
    category = json['category'];
    type = json['type'];
    importance = json['importance'];
    addresstype = json['addresstype'];
    name = json['name'];
    displayName = json['display_name'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place_id'] = this.placeId;
    data['osm_type'] = this.osmType;
    data['osm_id'] = this.osmId;
    data['place_rank'] = this.placeRank;
    data['category'] = this.category;
    data['type'] = this.type;
    data['importance'] = this.importance;
    data['addresstype'] = this.addresstype;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? neighbourhood;
  String? suburb;
  String? city;
  String? county;
  String? stateDistrict;
  String? state;
  String? iSO31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Address(
      {this.neighbourhood,
      this.suburb,
      this.city,
      this.county,
      this.stateDistrict,
      this.state,
      this.iSO31662Lvl4,
      this.postcode,
      this.country,
      this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    neighbourhood = json['neighbourhood'];
    suburb = json['suburb'];
    city = json['city'];
    county = json['county'];
    stateDistrict = json['state_district'];
    state = json['state'];
    iSO31662Lvl4 = json['ISO3166-2-lvl4'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['neighbourhood'] = this.neighbourhood;
    data['suburb'] = this.suburb;
    data['city'] = this.city;
    data['county'] = this.county;
    data['state_district'] = this.stateDistrict;
    data['state'] = this.state;
    data['ISO3166-2-lvl4'] = this.iSO31662Lvl4;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
