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
    var initHTML = "<p><strong>1910</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">1910年的大鱼数量</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">1910年的小鱼数量</div>";    
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
            displayText = "<p><strong>1910</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">1910年的大鱼数量</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">1910年的小鱼数量</div>"; 
            var year = parseInt(1910);
            pjs.updateFish(year); 
        }
        else if (ui.value === 2){
            displayText = "<p><strong>1920</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了2%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了8%</div>";
            var year = parseInt(1920);
            pjs.updateFish(year); 
        }
        else if (ui.value === 3){
            displayText = "<p><strong>1930</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了4%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了18%</div>";
            var year = parseInt(1930);
            pjs.updateFish(year); 
        }
        else if (ui.value === 4){
            displayText = "<p><strong>1940</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了6%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了29%</div>";
            var year = parseInt(1940);
            pjs.updateFish(year); 
        }
        else if (ui.value === 5){
            displayText = "<p><strong>1950</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了8%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了40%</div>";
            var year = parseInt(1950);
            pjs.updateFish(year);        
        }
        else if (ui.value === 6){
            displayText = "<p><strong>1960</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了10%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了53%</div>";
            var year = parseInt(1960);
            pjs.updateFish(year);         
        }
        else if (ui.value === 7){
            displayText = "<p><strong>1970</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了12%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了66%</div>";
            var year = parseInt(1970);
            pjs.updateFish(year);         
        }
        else if (ui.value === 8){
            displayText = "<p><strong>1980</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了41%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了81%</div>";
            var year = parseInt(1980);
            pjs.updateFish(year);         
        }
        else if (ui.value === 9){
            displayText = "<p><strong>1990</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了61%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了97%</div>";
            var year = parseInt(1990);
            pjs.updateFish(year);         
        }
        else if (ui.value === 10){
            displayText = "<p><strong>2000</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了71%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了114%</div>";
            var year = parseInt(2000);
            pjs.updateFish(year);         
        }
        else if (ui.value === 11){
            displayText = "<p><strong>2010</strong></p><div class=\"bubbletext-cn\"><img src=\"bg-small.png\">大鱼数量较1910年下降了78%</div><div class=\"bubbletext-cn\" style=\"padding-top: 15px; padding-bottom:5px;\"><img src=\"sf-small.png\">小鱼数量较1910年上升了133%</div>";
            var year = parseInt(2010);
            pjs.updateFish(year);        
        }

        $(div).find(".tooltip-inner").html( displayText );        
}

    var blurHTML = "<h5><strong>过度捕捞的影响</strong></h5><p>是一个网络虚拟水族馆，呈现了在过去100年间世界鱼类种群的数量变化。从动画互动数据中可以看到，“捕食性”大鱼和“猎物性”小鱼的数量曾处于良好的生态比例，然而过度捕捞导致海洋里的大鱼（即被人类捕捞食用的鱼群）数量锐减，小鱼数量则呈过量增长的趋势。大鱼数量虽然一直下降但速率和缓，然而1970年后大鱼数量急转直下急速减少。本网络虚拟水族馆基于科学数据，将信息视觉化呈现。此数据来自于维利•克里斯滕森博士的回归分析法和著名的不列颠哥伦比亚大学渔业中心。";
    $("#blurb").tooltip( {title: blurHTML, trigger: "hover focus", placement: "top", html: "true"}).tooltip("hide");
});


