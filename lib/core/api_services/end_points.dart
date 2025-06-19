class EndPoints{
  static const String signUp="/api/mobile/register";
  static const String sendOtp= "/api/mobile/send_otp";
  static const String verifyOtp= "/api/mobile/verify_otp";
  static const String getServices= "/api/services";
  static const String getUser="/api/user/info";
  static const String getCategories= "/api/main_categories";
  static String subCategories(int categoryId) =>
      '/api/main_categories/$categoryId/sub_categories';
  static String serviceType(int subCategoryId) =>
      '/api/sub_categories/$subCategoryId/service_types';
  static String getFields(int serviceId) =>
      '/api/service_types/$serviceId/fields_config';
  static const String getGovern= "/api/governments";
  static String getVillage(int stateId) =>
      '/api/states/$stateId/villages';
  static String getStates(int governId) =>
  '/api/governments/$governId/states';
  static String getDocuments(int serviceId) =>
      "/api/service_types/$serviceId/document_types";
  static String serviceDetails(int serviceId) =>"/api/service_request/$serviceId";
  static const String createServices= "/api/create/service";
  static const String getNews="/api/blogs";
  static String newsDetails(int newsId) =>"/api/blogs/$newsId";
}