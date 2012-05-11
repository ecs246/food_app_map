var drawMap = function () {
  var ajaxDialog = "";
  var map = "";
  var markersHash = {};
  
  var addMarker = function(location,title,id) {
    marker = new google.maps.Marker({
      position: location,
      map: map
    });
    markersHash[id] = marker;
    return marker
  }
  
  var clearOverlays = function () {
    if (markersHash) {
      for (var key in markersHash) {

        markersHash[key].setMap(null);
      }
    }
  }
  var showOverlay = function(id) {
    marker = markersHash[id]
    if (marker != undefined) {
        marker.setMap(map)
    }    
  }
  var getOverlay = function(id) {
      return markersHash[id]
    }
  var showOverlays = function () {
    if (markersHash) {
      for (var key in markersHash) {
        marker = markersHash[key]
        if (marker != undefined) {
          markersHash[key].setMap(map);
        }  
      }
    }
  }
  
  var handleGalleryClick = function() {
    $('#map_canvas').on('click','.side-gallery',function(event) {
        event.preventDefault();

      //$('#img-display').load($(this).attr('href'),function() {
      $('#ajax-dialog').load($(this).attr('href'),function() {
        $("a[rel='cbox']").colorbox();
    
      })
       ajaxDialog.dialog("open");

    })
   } 
   
  var handleVendorClick = function () {
    $('.vendor-click').click(function(event) {
      event.preventDefault();
      var id = $(this).attr('id')
      var marker = getOverlay(id)
      if (marker != undefined) {
        clearOverlays();
        showOverlay(id);
        map.setCenter(marker.position);
        
      }  
    })  
    }
  var handleCategoryClick = function () {
     
     $('.category-click').click(function(event) {
       clearOverlays();
       event.preventDefault();
       var id = $(this).attr('id')
       if (id != "all") {
         var url = 'categories/' + id + '/vendors'
         $.getJSON(url, function(data) {
           $(data).each(function(i,el) {
             showOverlay(el.vendor.id);

         })
         })
       } else {
         showOverlays()
         }
     })  
    }
  var mapIt = function() {
    var url = 'vendors/index.json';
   
    $.getJSON(url, function(data) {
      $(data).each(function(i,item) {

        var latlng = new google.maps.LatLng(item.vendor.latitude,item.vendor.longitude);
        var marker = addMarker(latlng,item.vendor.name,item.vendor.id)

        var content = "<a class='side-gallery' href='/vendors/gallery/" +
          item.vendor.id+"'>" +item.vendor.name + "</a> <br/>" + 
          item.vendor.address

        var infowindow = new google.maps.InfoWindow({
          content: content
        });

        google.maps.event.addListener(marker,'click',(function() {
            infowindow.open(map,marker)
          })
         ) ;
      })
    })

  }
  
 return {
   init: function() {
   ajaxDialog = $('<div id="ajax-dialog" style="display:hidden"></div>').appendTo('body');
    ajaxDialog.dialog({autoOpen: false}); 
    var latlng =  new google.maps.LatLng(40.755547,-73.9839);
    var myOptions = { 
      zoom: 12, 
      center: latlng, 
      mapTypeId: google.maps.MapTypeId.ROADMAP 
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions); 

     mapIt();
     handleVendorClick();
     handleGalleryClick();
     handleCategoryClick();
   }
  }
}()




$(document).ready(function() {

  drawMap.init();


})	
