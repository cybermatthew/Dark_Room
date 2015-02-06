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
	$("#uploadPhoto"+imageID).submit(function(){
		var url = "/scrimages/uploadPhoto";

		$.ajax({
			type: "POST",
			data: $("#uploadPhoto"+imageID).serialize(),
			success: function(msg){
				// alert(msg);
			}
		});
	});
}