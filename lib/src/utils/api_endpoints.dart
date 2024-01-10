class ApiEndPoints {
  static final String baseUrl = "https://admin.yesmachinery.ae/api";
  //"http://10.0.2.2:8000/api";
  static final String imageRootPath = "https://admin.yesmachinery.ae/storage/";
  static final String ycImageRootPath = 'https://admin.yesclean.ae/storage/';
  //"http://10.0.2.2:8000/storage/";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
  static _DivisionEndPoints divisionEndPoints = _DivisionEndPoints();
  static _BrandEndPoints brandEndPoints = _BrandEndPoints();
  static _ProductEndPoints productEndPoints = _ProductEndPoints();
  static _EnquiryEndPoints enquiryEndPoints = _EnquiryEndPoints();
  static _ProfileEndPoints profileEndPoints = _ProfileEndPoints();
}

class _AuthEndPoints {
  final String loginUrl = "/login";
}

class _DivisionEndPoints {
  final String divisionUrl = "/divisions";
}

class _BrandEndPoints {
  final String brandUrl = "/brands";
}

class _ProductEndPoints {
  final String productUrl = "/products";
  final String productViewUrl = "/product/:id";
}

class _EnquiryEndPoints {
  final String enquiryUrl = "/sendenquiry";
}

class _ProfileEndPoints {
  final String profileUrl = "/userprofile/:id";
  final String profileUpdateUrl = "/saveprofile";
}
