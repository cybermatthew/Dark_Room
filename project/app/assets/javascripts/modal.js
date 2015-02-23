function showModal(modalID, imageID){
	$("#"+modalID).css("opacity", "1");
	$("#"+modalID).css("pointer-events", "auto");
}

function closeModal(modalID){
	$("#"+modalID).css("opacity", "0");
	$("#"+modalID).css("pointer-events", "none");
}


function showPostSaveModal(){
	var postSaveModalText = document.getElementById("postSaveModalText");
	var addBrowserImageDescription = document.getElementById("browserImageDescription");
	postSaveModalText.innerHTML = addBrowserImageDescription.innerHTML;
	$("#postSaveModal").css("opacity", "1");
	$("#postSaveModal").css("pointer-events", "auto");
}

function closePostSaveModal(){
	$("#postSaveModal").css("opacity", "0");
	$("#postSaveModal").css("pointer-events", "none");	
}

function showSaveSuccessText(){
	var postSaveModalText = document.getElementById("postSaveModalText");
	var saveSuccessText = document.getElementById("saveSuccessText");
	postSaveModalText.innerHTML = saveSuccessText.innerHTML;
}

function showSaveErrorText(){
	var postSaveModalText = document.getElementById("postSaveModalText");
	var saveErrorText = document.getElementById("saveErrorText");
	postSaveModalText.innerHTML = saveErrorText.innerHTML;
}

