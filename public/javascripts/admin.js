var myadmin = {}; 
myadmin.imageFinder = function() {
    var counter = 0;
    var orderElements = function (arr) {
        $('#imageContainer li').each(function (index,el) {
            for (key in arr) {
                $(el).find('input[name$=\\]\\['+arr[key]+'\\]]')
                .attr('name','galleryImages['+index+']['+arr[key]+']');
            }    
        })

    }
    
    function addImage(event) {
        event.stopPropagation();
        event.preventDefault(); 

      var $par = $(this).parent();
      $('#imageContainer').append($('<li></li>').append($par.find('img').clone()).append($('<input type="text" name="galleryImages[][caption]"/>\
            <input type="hidden" name="galleryImages[][image_id]" value="'+ 
        $par.data('id') +'"/> \
        <a href="#" class="deleteImage">Delete</a>')
        )) 
        counter ++;
    }
     
    return {
        init: function () {
            $('input[type=submit]').parent('form').submit(function(event) {
                orderElements(['caption','status','id','image_id']);           
                return true;
            }); 

            $("#imageContainer").sortable();

            $(".deleteOldImage").click(function(event) {       
                event.stopPropagation();
                event.preventDefault();
                $(this).parent().find('input[name=galleryImages\\[\\]\\[status\\]]').val('remove');
                $(this).parent().hide();
            })      

            $('#search').click(function() {
                var data = "";
                var name = $("#searchValue").val();
                if (name != "") {
                    data = {"name":name};
                }   
    
               // $(".addImage").live('click',addImage);

                $(".deleteImage").live('click',function(event) {
                    event.stopPropagation();
                    event.preventDefault();
                    $(this).parent().remove();

                })   

                $.ajax({
                url: '#fill_in_path',
                data: data,
                dataType: 'json',
                success: function (data) {
                    $('.addImage').die('click');
                    $(".addImage").live('click',addImage);
                    $('#imageResults').empty();
                    $(data).each(function (index,item) {
                        var thumbnail = item.path.replace(/(\.[^.]*)$/,'_thumbnail$1');
                        $el=$('<li><a class="addImage" href="#">Add</a><img src="'+thumbnail+'"/></li>');
                        $el.data('id',item.id);
                        $('#imageResults').append($el);
                    });

                }
                });
            });

        }
    }
}();

myadmin.nav = function() {
  var changeElementBehaviour = function () {
    $('.headform select').change(function() {
        $(".headform select option:selected").each(function () {
          //alert($(this).val());
            $(this).val() != "" ? location.href = $(this).val() : "";
            
        });
    })
  }
  var defaultElementBehaviour = function () {

    $(".headform select option[value='"+window.location.pathname+"']").attr("selected", true);

  }
  return { 
    init : function () {
      
      defaultElementBehaviour();
      changeElementBehaviour();
    }  
  }
}();


$(document).ready(function() {
  myadmin.nav.init();
 // myadmin.cat.init();
});