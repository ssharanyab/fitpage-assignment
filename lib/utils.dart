class Utils {
  String getVariable(data, String s) {
    if (data['variable']['\$$s']['type'] == 'value') {
      return data['variable']['\$$s']['values'][0].toString();
    }
    if (data['variable']['\$$s']['type'] == 'plain_text') {
      return data['variable']['\$$s']['text'];
    }
    if (data['variable']['\$$s']['type'] == 'indicator') {
      return data['variable']['\$$s']['default_value'].toString();
    }
    return 'variable';
  }
}
