function showModal(modalID, imageID){
	$("#"+modalID).css("opacity", "1");
	$("#"+modalID).css("pointer-events", "auto");
}

function closeModal(modalID){
	$("#"+modalID).css("opacity", "0");
	$("#"+modalID).css("pointer-events", "none");
}


//Options for Spinner
var opts = {
  lines: 13, // The number of lines to draw
  length: 10, // The length of each line
  width: 5, // The line thickness
  radius: 15, // The radius of the inner circle
  corners: 1, // Corner roundness (0..1)
  rotate: 0, // The rotation offset
  direction: 1, // 1: clockwise, -1: counterclockwise
  color: '#000', // #rgb or #rrggbb or array of colors
  speed: 1, // Rounds per second
  trail: 60, // Afterglow percentage
  shadow: false, // Whether to render a shadow
  hwaccel: false, // Whether to use hardware acceleration
  className: 'spinner', // The CSS class to assign to the spinner
  zIndex: 2e9, // The z-index (defaults to 2000000000)
  top: '80%', // Top position relative to parent
  left: '50%' // Left position relative to parent
};

var target; 
var spinner; 

function showPostSaveModal(){
	var postSaveModalText = document.getElementById("postSaveModalText");
	var saveSpinnerText = document.getElementById("saveSpinnerText");
	postSaveModalText.innerHTML = saveSpinnerText.innerHTML;
	target = document.getElementById('postSaveModalText');
	spinner = new Spinner(opts).spin(target);
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

