
$('#buttonInclude').click(function(){
	if (Utils.HasMock()) {
		alert('button Include pressed')
	}else{
		CordovaExec(function(catItens){
		
		}, "MainPlugin", "GoToForm");
	}
});

$('#buttonList').click(function(){
	if (Utils.HasMock()) {
		alert('button List pressed')
	}else{
		CordovaExec(function(catItens){
		
		}, "MainPlugin", "GoToHistory");
	}
		
});

