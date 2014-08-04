$(document).ready(function(){
	startLoad();
	
	$('#buttonInclude').click(function(){
		CordovaExec(function(catItens){
			
		}, "MainPlugin", "GoToForm");
	});

	$('#buttonList').click(function(){
		CordovaExec(function(catItens){
			
		}, "MainPlugin", "GoToHistory");
	});

});



function startLoad(){
	$('body').hide();
}

function finishedLoad(){
	$('body').show();
}


