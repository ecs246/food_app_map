var myadmin = {}; 


myadmin.nav = function() {
 
  var defaultElementBehaviour = function () {
   loc =  window.location.pathname
   $("nav li a[href='"+loc+"']").parent().attr('class','active')
  }
  return { 
    init : function () {
      
      defaultElementBehaviour();
    }  
  }
}();


$(document).ready(function() {
  myadmin.nav.init();
 // myadmin.cat.init();
});