function showModal(modalID, imageID){
	$("#"+modalID).css("opacity", "1");
	$("#"+modalID).css("pointer-events", "auto");
}

function closeModal(modalID){
	$("#"+modalID).css("opacity", "0");
	$("#"+modalID).css("pointer-events", "none");
}