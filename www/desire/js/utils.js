

var Utils = {

	Teste : function t (){
		alert('testeeee')
	},

	GetCurrentDate : function getCurrentDate(){
		var date = new Date();
		day = date.getUTCDate();
		month = date.getUTCMonth()+1;
		year = date.getUTCFullYear();

		if(day < 10){
			day = '0'+day;
		}

		if(month < 10){
			month = '0'+month;
		}

		var dateStr = year + '-' + month + '-' + day;

		return dateStr
	},

	HasMock : function hasMock(){
		var list = $('script');
		var hasMockBool = false;
		for (var i = 0; i < list.length; i++) {
			var src = list[i].getAttribute('src');
			if (src == null) {
				continue;
			};
			if (src.indexOf('mock') >= 0) {
				hasMockBool = true;
				break;
			}
		};
		return hasMockBool;
		
		// var hMock = false;
		// hMock = window.location.toString().indexOf("t=1") == -1 ? false : true;
		// return hMock;
	},

	GetController : function getController(){
	    var controller = angular.element($("body")).scope();
	    if (controller) {
	        return controller;
	    };

	    return;
	},

	Apply : function apply(){
		Utils.GetController().$apply();
	}

}