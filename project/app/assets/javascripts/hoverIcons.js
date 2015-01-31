$(function(){
	$(".editableImage").prepend("<span class='hoverIcons' style='display:none'><span class='hoverIcon hoverIconLeft' style='display:inline-flex'><img src='/images/edit_symbol.png'></span>&nbsp;&nbsp;<span class='hoverIcon hoverIconRight'style='display:inline-flex'><img src='/images/upload_symbol.png'></span></span>");

	$(".editableImage").hover(
		function(){
			$(this).find(".hoverIcons").show();
			$(this).find(".hoverIcons").css("display", "inline");
		},
		function(){
			$(this).find(".hoverIcons").hide();
	});
});