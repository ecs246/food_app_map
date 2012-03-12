myadmin.cat=function() {
  handleItemOver = function() {
    
    $('#map').on('hover','.cell-name',function(event) {
      var $actionDiv = $(this).find('.item-action:first')
      if (event.type == 'mouseenter') {
        $actionDiv.css('visibility','visible')
      } else {
        $actionDiv.css('visibility','hidden')  
      }
    })
  }
  
  handleQuickEditClick = function() {
    $('.item-action').on('click','.quick-edit',function(event) {
      event.preventDefault()
      console.log($(this).closest('.cat-item'));
      $(this).closest('.cat-item').hide()
      
    })
  }  
  
  handleSubmit = function() {
    $('#create_category_form')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      var $submitButton = $(this).find('input[name="commit"]');

      // Update the text of the submit button to let the user know stuff is happening.
      // But first, store the original text of the submit button, so it can be restored when the request is finished.
      $submitButton.data( 'origText',$submitButton.attr('value') );

      
      $submitButton.attr('value',"Submitting..." );
      $submitButton.attr('disabled',true );

    })
    .bind("ajax:success",function(evt,data,status,xhr) {
      id = data.category.id; 
      name = data.category.name;
      html = data.html;
      level = data.level;
      if (isNaN(id)) {
        alert("Problem with id");
      } else {
        popt = $('#category_parent_id option:selected')
        console.log($('#map').find('tr #id-' + popt.attr('value')))
        $(html).insertAfter($('#map').find('tr#tag-' + popt.attr('value')))
        $('<option></option>').html(Array(level+1).join('-')+name).attr('value',id).insertAfter(popt)
      }
//      for (i=0; i < 1000; i++) {
 //       console.log(i);
  //      }
    })
    .bind('ajax:complete', function(evt, xhr, status){
     
      var $submitButton = $(this).find('input[name="commit"]');
      
      
      // Restore the original submit button text
      $submitButton.attr('value',$submitButton.data('origText') );
      $submitButton.attr('disabled',false );
    })
    .bind("ajax:error", function(evt, xhr, status, error){
        
            var $form = $(this),
          errors,
          errorText;
          console.log(xhr.responseText)
      try {
        // Populate errorText with the comment errors
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
        errors = {message: "Please reload the page and try again"};
      }

      // Build an unordered list from the list of errors
      errorText = "There were errors with the submission: \n<ul>";

      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      }

      errorText += "</ul>";

      // Insert error list into form
      $form.find('div.validation-error').html(errorText);
    });
    
  }
  
  return {
    init: function() {
      handleSubmit();
      handleItemOver();
      handleQuickEditClick();
    }
  }
}();

$(document).ready(function() {
  
  myadmin.cat.init();
});