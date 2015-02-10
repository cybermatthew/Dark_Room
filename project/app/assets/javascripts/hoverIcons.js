function initHoverIcons(){
	$(".editableImage").hover(
		function(){
			$(this).find(".hoverIcons").show();
			$(this).find(".hoverIcons").css("display", "inline");
		},
		function(){
			$(this).find(".hoverIcons").hide();
	});
}

function uploadEditedImage(imageID){
	$("#uploadPhoto"+imageID).submit(function(e){
		var form = $("#uploadPhoto"+imageID);
		e.preventDefault();

		// $.post( form.attr("action"), new FormData($(this)[0]), function(msg){
		// 	$("#childrenPhotos").html(msg);
		// 	closeModal("uploadModal"+imageID);
		// });
		var formData = new FormData($(this)[0]);

		$.ajax({
			url: '/scrimages/uploadEditedImage',
			type: 'POST',
			data: formData,
			cache: false,
		    contentType: false,
		    processData: false,
			success: function (msg) {
			  	$("#childrenPhotos").html(msg);
				closeModal("uploadModal"+imageID);
			}
		});
	});
}