//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function reset_search_elements(){
	$('.search_field').val('');
}

(function( Common ) {
    //Public Method
    Common.disablePage = function(mainElementSelector) {
        var maimElm;
        if (!mainElementSelector){
            maimElm =  $("body");
        }
        else{
           maimElm =  $(mainElementSelector); 
        }
        
       maimElm.find('input, textarea, button, select')
        .attr('disabled','disabled').addClass("readonly");
    };    
}( window.Common = window.Common || {}));