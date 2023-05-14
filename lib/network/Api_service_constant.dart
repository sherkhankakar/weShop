class Apiserviceconstant {
  static const String baseUrl = "https://weshop.quitbug.com/public/api/";

  //authentication urls
  static final register = Uri.parse(baseUrl + "register");
  static final signIn = Uri.parse(baseUrl + 'login');
  static final forgortPassword = Uri.parse(baseUrl + 'password/forget');
  static final resetPassword = Uri.parse(baseUrl + 'password/reset');
  static final verifyPassword = Uri.parse(baseUrl + 'password/verify_reset');
  static final updatePassword = Uri.parse(baseUrl + 'updatePassword');
  static final updateUser = Uri.parse(baseUrl + 'updateUser');

  //list urls
  static final list = Uri.parse(baseUrl + 'list');
  static final addList = Uri.parse(baseUrl + 'addlist');
  static final updateList = Uri.parse(baseUrl + 'listupdate');
  static final deleteList = Uri.parse(baseUrl + 'listdelete');
  static final getItem = Uri.parse(baseUrl + 'getitem');
  static final addListItem = Uri.parse(baseUrl + 'addlistitem');
  static final deleteListItem = Uri.parse(baseUrl + 'listitemdelete');

  //get items apis
  static final getAllItems = Uri.parse(baseUrl + 'getalltitems');
  static final getListedItems = Uri.parse(baseUrl + 'getlistitems');
}
