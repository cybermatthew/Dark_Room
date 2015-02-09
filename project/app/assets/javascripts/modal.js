function showModal(modalID, imageID){
	$("#"+modalID).css("opacity", "1");
	$("#"+modalID).css("pointer-events", "auto");
}

function closeModal(modalID){
	$("#"+modalID).css("opacity", "0");
	$("#"+modalID).css("pointer-events", "none");
}

function showPostSaveSuccessModal(){
	$("#postSaveSuccessModal").css("opacity", "1");
	$("#postSaveSuccessModal").css("pointer-events", "auto");
}

function closePostSaveSuccessModal(){
	$("#postSaveSuccessModal").css("opacity", "0");
	$("#postSaveSuccessModal").css("pointer-events", "none");	
}

function showPostSaveErrorModal(){
	$("#postSaveErrorModal").css("opacity", "1");
	$("#postSaveErrorModal").css("pointer-events", "auto");
}

function closePostSaveErrorModal(){
	$("#postSaveErrorModal").css("opacity", "0");
	$("#postSaveErrorModal").css("pointer-events", "none");	
}