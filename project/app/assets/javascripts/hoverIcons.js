$(function(){

	$(".editableImage").hover(
		function(){
			$(this).find(".hoverIcons").show();
			$(this).find(".hoverIcons").css("display", "inline");
		},
		function(){
			$(this).find(".hoverIcons").hide();
	});
});