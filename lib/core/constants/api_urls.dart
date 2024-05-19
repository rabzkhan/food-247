class ApiUrls {
  static const baseUrl = 'https://foodfor24-7.tech365.cloud';
  //auth
  static const signUp = "$baseUrl/api/user-registration-with-phone";
  static const signIn = "$baseUrl/api/login";
  static const banner = "$baseUrl/api/banners";
  static const categories = "$baseUrl/api/productTypes";
  static const categoryWiseProducts = "$baseUrl/api/product-type-wise/product/";

  static const popularProducts = "$baseUrl/api/all-popular/product";
  static const featuredProducts = "$baseUrl/api/all-featured/product";
  static const productDetails = "$baseUrl/api/product/details";

  static const profileInfo = "$baseUrl/api/customer/my-profile";
  static const addAddress = "$baseUrl/api/user-address/store";
  static const getAddress = "$baseUrl/api/user-address";
}
