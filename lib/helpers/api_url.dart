class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/';
  //sesuaikan dengan ip laptop / localhost teman teman / url server Codeigniter

  static const String registrasi = baseUrl + 'api/registrasi';
  static const String login = baseUrl + 'api/login';
  static const String listNutrisi = baseUrl + 'api/kesehatan/data_nutrisi';
  static const String createNutrisi = baseUrl + 'api/kesehatan/data_nutrisi';

  static String updateNutrisi(int id) {
    return baseUrl + 'api/kesehatan/data_nutrisi/' + id.toString()+'/update';//sesuaikan dengan url API yang sudah dibuat
  }

  static String showNutrisi(int id) {
    return baseUrl + 'api/kesehatan/data_nutrisi' + id.toString();//sesuaikan dengan url API yang sudah dibuat
  }

  static String deleteNutrisi(int id) {
    return baseUrl + 'api/kesehatan/data_nutrisi/' + id.toString()+'/delete';//sesuaikan dengan url API yang sudah dibuat
  }
}
