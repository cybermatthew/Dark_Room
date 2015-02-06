$(function(){
	console.log("I'm Here!!!");
	$(".editableImage").hover(
		function(){
			$(this).find(".hoverIcons").show();
			$(this).find(".hoverIcons").css("display", "inline");
		},
		function(){
			$(this).find(".hoverIcons").hide();
	});
});

function uploadEditedImage(imageID){
	$("#uploadPhoto"+imageID).submit(function(e){
		var form = $("#uploadPhoto"+imageID);
		e.preventDefault();

		$.post( form.attr("action"), form.serialize(), function(msg){
			console.log(msg);
		});
	});
}