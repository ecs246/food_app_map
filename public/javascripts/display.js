
var drawMap = function () {
  var map = "";
  var handleGalleryClick = function() {
    $('#map_canvas').on('click','.side-gallery',function(event) {
        event.preventDefault();
      $('#img-display').load($(this).attr('href'),function() {
      
        $("a[rel='cbox']").colorbox();
    
      })
    })
   } 
  var mapIt = function() {
    var url = 'vendors/index.json';
    var marker = new Array();
    $.getJSON(url, function(data) {
      $(data).each(function(i,item) {

              var latlng = new google.maps.LatLng(item.vendor.latitude,item.vendor.longitude);
              marker[i] = new google.maps.Marker({
                      map: map, 
                      position: latlng, 
                      title:item.vendor.name
              });
              var content = "<a class='side-gallery' href='/vendors/gallery/" +
                item.vendor.id+"'>" +item.vendor.name + "</a> <br/>" + 
                item.vendor.address
              
              var infowindow = new google.maps.InfoWindow({
                content: content
              });

              google.maps.event.addListener(marker[i],'click',(function() {
                  infowindow.open(map,marker[i])
                })
               ) ;
      })
    })

  }
  
 return {
   init: function() {
    var latlng =  new google.maps.LatLng(40.755547,-73.9839);
    var myOptions = { 
      zoom: 13, 
      center: latlng, 
      mapTypeId: google.maps.MapTypeId.ROADMAP 
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions); 

     mapIt();
     handleGalleryClick();
   }
  }
}()




$(document).ready(function() {
      drawMap.init();
      
})	
