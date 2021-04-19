class BaseUrl {
  BaseUrl();

  String getBaseUrl() {
    //return "192.168.0.33:80"; //192.168.0.11:8080 - casa
    // return "192.168.1.81"; //OmarU
    // return "192.168.0.17";
    //return "mover-t.com";
    //return "192.168.1.78"; //MAUu
    //return "192.168.100.5:3000"; //maucasa

    return "192.168.100.5:3000";

    // return "localhost:3000";
  }

  String getNextUrl() {
    // return "/movert/mobvertweb/api";
    return workInServer() ? "/api/v1/user" : "/";
  }

  String getUrlImage() {
    // return "/movert/mobvertweb/mod/";
    return workInServer() ? "/mod/" : "/server/ticketsmore/apis/";
  }

  String protocol() {
    return workInServer() ? "https://" : "http://";
  }

  bool workInServer() {
    /**
     * True - Trabajo con servidor'
     * False - Trabajo con servidor local'
     */
    return true;
  }
}
