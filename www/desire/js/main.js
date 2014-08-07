
$('#buttonInclude').click(function(){
	if (Utils.HasMock()) {
		alert('button Include pressed')
	}else{
		CordovaExec(function(catItens){
			gaPlugin.trackEvent( nativePluginResultHandler, nativePluginErrorHandler, "Button", "Click", "event only", 1);
		}, "MainPlugin", "GoToForm");
	}
});

$('#buttonList').click(function(){
	if (Utils.HasMock()) {
		alert('button List pressed')
	}else{
		CordovaExec(function(catItens){
			gaPlugin.trackEvent( nativePluginResultHandler, nativePluginErrorHandler, "Button1", "Click1", "event only1", 5577);
		}, "MainPlugin", "GoToHistory");
	}
		
});

function nativePluginResultHandler (result) {
	//alert('nativePluginResultHandler - '+result);
	console.log('nativePluginResultHandler: '+result);

}

function nativePluginErrorHandler (error) {
	//alert('nativePluginErrorHandler - '+error);
	console.log('nativePluginErrorHandler: '+error);
}

