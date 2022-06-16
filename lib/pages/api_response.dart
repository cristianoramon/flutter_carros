class ApiResponse<T> {
  bool? ok;
  String? msg;
  T? result;

  ApiResponse.ok(this.result){
    ok = true;
  }
  ApiResponse.erro(this.msg){
    ok = false;
  }

}