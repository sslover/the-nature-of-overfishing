// Some general UI pack related JS

$(function () {
    // Custom selects
    $("select").dropkick();
});

$(document).ready(function() {

    var w = window.innerWidth;
    var h = window.innerHeight;

    function isCanvasSupported(){
      var elem = document.createElement('canvas');
      return !!(elem.getContext && elem.getContext('2d'));
    }

    if (!isCanvasSupported() || w <500 || h<500){
        $(function() {
                $('#overlay').fadeIn('fast',function(){
                    $('#box').animate({'top':'60px'},w/2);
                });
            $('#boxclose').click(function(){
                $('#box').animate({'top':'-300px'},w/2,function(){
                    $('#overlay').fadeOut('fast');
                });
            });
         
        });
    }

    // Todo list
    $(".todo li").click(function() {
        $(this).toggleClass("todo-done");
    });

    // Init tooltips
    $("[data-toggle=tooltip]").tooltip("show");

    // Init tags input
    $("#tagsinput").tagsInput();

    // JS input/textarea placeholder
    $("input, textarea").placeholder();

    // Make pagination demo work
    $(".pagination a").click(function() {
        if (!$(this).parent().hasClass("previous") && !$(this).parent().hasClass("next")) {
            $(this).parent().siblings("li").removeClass("active");
            $(this).parent().addClass("active");
        }
    });

    $(".btn-group a").click(function() {
        $(this).siblings().removeClass("active");
        $(this).addClass("active");
    });

    // Disable link click not scroll top
    $("a[href='#']").click(function() {
        return false
    });

     // Init jQuery UI slider
    $("#slider").slider({
        min: 1,
        max: 11,
        value: 1,
        orientation: "horizontal",
        range: "min",
        slide: repositionTooltip, 
        stop: repositionTooltip,
        hover: repositionTooltip,
    });
    
    $("#slider .ui-slider-handle:first").tooltip( {title: $("#slider").slider("value"), trigger: "manual", placement: "bottom", html: "true"}).tooltip("show");
    //change the initial value
    var startDiv = $("#slider .ui-slider-handle:first").data("tooltip").$tip[0];
    var initHTML = "<p><strong>1910</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">Big Fish in 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">Small Fish in 1910</div>";    
    $(startDiv).find(".tooltip-inner").html( initHTML );  


function repositionTooltip( e, ui ){

        var div = $(ui.handle).data("tooltip").$tip[0];
        var pos = $.extend({}, $(ui.handle).offset(), { width: $(ui.handle).get(0).offsetWidth,
                                                        height: $(ui.handle).get(0).offsetHeight
                  });
        
        var actualWidth = div.offsetWidth;
        
        tp = {left: pos.left + pos.width / 2 - actualWidth / 2}            
        $(div).offset(tp);
        
        var displayText;
        var pjs = Processing.getInstanceById('sketch');

        if (ui.value === 1){
            displayText = "<p><strong>1910</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">Big Fish in 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">Small Fish in 1910</div>"; 
            var year = parseInt(1910);
            pjs.updateFish(year); 
        }
        else if (ui.value === 2){
            displayText = "<p><strong>1920</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">2% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">8% more than 1910</div>";
            var year = parseInt(1920);
            pjs.updateFish(year); 
        }
        else if (ui.value === 3){
            displayText = "<p><strong>1930</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">4% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">18% more than 1910</div>";
            var year = parseInt(1930);
            pjs.updateFish(year); 
        }
        else if (ui.value === 4){
            displayText = "<p><strong>1940</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">6% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">29% more than 1910</div>";
            var year = parseInt(1940);
            pjs.updateFish(year); 
        }
        else if (ui.value === 5){
            displayText = "<p><strong>1950</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">8% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">40% more than 1910</div>";
            var year = parseInt(1950);
            pjs.updateFish(year);        
        }
        else if (ui.value === 6){
            displayText = "<p><strong>1960</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">10% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">53% more than 1910</div>";
            var year = parseInt(1960);
            pjs.updateFish(year);         
        }
        else if (ui.value === 7){
            displayText = "<p><strong>1970</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">12% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">66% more than 1910</div>";
            var year = parseInt(1970);
            pjs.updateFish(year);         
        }
        else if (ui.value === 8){
            displayText = "<p><strong>1980</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">41% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">81% more than 1910</div>";
            var year = parseInt(1980);
            pjs.updateFish(year);         
        }
        else if (ui.value === 9){
            displayText = "<p><strong>1990</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">61% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">97% more than 1910</div>";
            var year = parseInt(1990);
            pjs.updateFish(year);         
        }
        else if (ui.value === 10){
            displayText = "<p><strong>2000</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">71% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">114% more than 1910</div>";
            var year = parseInt(2000);
            pjs.updateFish(year);         
        }
        else if (ui.value === 11){
            displayText = "<p><strong>2010</strong></p><div class=\"bubbletext\"><img src=\"bg-small.png\">78% less than 1910</div><div class=\"bubbletext\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">133% more than 1910</div>";
            var year = parseInt(2010);
            pjs.updateFish(year);        
        }

        $(div).find(".tooltip-inner").html( displayText );        
}

    var blurHTML = "<h5><strong>The Nature of Overfishing</strong></h5><p>is a Web aquarium that tells the tale of the world's fish populations over the last 100 years. While there was once big \"predatory\" fish and small \"prey\" fish in healthy proportions, overfishing has decimated our ocean's big fish (i.e. the ones humans catch and eat) and left small fish populations overly abundant. The decline was modest until 1970, and then took a sharp and drastic turn for the worst. This Web aquarium is a data story, presenting the information visually. The data comes directly from a regression analysis by Dr. Villy Christensen and the renowned UBC Fisheries Centre.";
    $("#blurb").tooltip( {title: blurHTML, trigger: "hover focus", placement: "top", html: "true"}).tooltip("hide");
});


