class ConstantData {
  //Shared Preferences Key
  static final String KEY_ID = "ID";
  static final String KEY_NAME_SP = "NAME";
  static final String KEY_EMAIL_SP = "EMAIL";
  static final String KEY_CONTACT_SP = "CONTACT";
  static final String IS_LOGIN_SP = "IS_LOGIN";

  //server address
  static final String SERVER_ADDRESS = SERVER_ADDRESS_IMAGE + "api/";
  static final String SERVER_ADDRESS_IMAGE = "http://192.168.1.7/MAIN_PROJECT/";

  //API Address
  static final String REGISTER_USER_API = "register_user.php";
  static final String LOGIN_USER_API = "login_api.php";
  static final String BANNER_API = "banner_api.php";
  static final String CATEGORY_API = "cat_api.php";
  static final String COUPON_API = "coupon_api.php";
  static final String PRODUCT_API = "sub_cat_api.php";
  static final String PRODUCT_FROM_CAT_API =
      SERVER_ADDRESS + "ProductFromCategory.php";
  static final String LABTEST_API = "labtest_api.php";
  static final String LABTESTPACKAGE_API =
      SERVER_ADDRESS + "lebtestfrompackages.php";
  static final String REALTED_PRODUCT_API = SERVER_ADDRESS + "related_api.php";
  static final String ADDTOCART_API = SERVER_ADDRESS + "addorder_api.php";
  static final String GETOERDER_API = SERVER_ADDRESS + "getorder_api.php";
  static final String UPDATEOERDER_API = SERVER_ADDRESS + "updateqtyapi.php";
  static final String REMOVEOERDER_API = SERVER_ADDRESS + "removeorder_api.php";
  static final String EDITPROFILE_API = SERVER_ADDRESS + "editprofile_api.php";
  static final String TOP_SELLING = SERVER_ADDRESS + "topselling_api.php";
  static final String SEARCH_API = SERVER_ADDRESS + "searchapi.php";
  static final String APPLY_COUPON_API = SERVER_ADDRESS + "getDiscountApi.php";
}
