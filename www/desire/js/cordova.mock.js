var cat = {
	identifier : "3"
}

var sampleRendimentoItem = {
	label : "Teste rendimento",
	value : "5,99",
	category : cat,
	parcel : "7",
	dateSpent : "2014-02-05",
	notes : "Anotações",
	spent : 0,
	money : 0,
	debit : 0,
	creditCard : 0
};

var sampleDespesaItem = {
	label : "Teste rendimento",
	value : "5,99",
	category : cat,
	parcel : "7",
	dateSpent : "2014-02-05",
	notes : "Anotações",
	spent : 1,
	money : 0,
	debit : 1,
	creditCard : 0
};

var staticImageUrl = "img/mock/sampleImage";

setTimeout(function () {
	onDeviceReady();
}, 500);

if(window.navigator == undefined) {
	window.navigator = { };
}

window.cordova = {
	exec: function (success, fail, className, methodName, params) {
		if (className == "FormPlugin") {
			if (methodName == "Populate"){
				success(sampleDespesaItem);
			}else if (methodName == "SendItem"){
				var json = JSON.parse(params[0]);
				success("item salvo: " + json.description);
			}
		}

		if (className == "HistoryPlugin") {
			if (methodName == 'GetAllItens') {
				success(getSampleAllItens());
			}else if(methodName == 'ShowForm') {
				success(params[0]);
			}else if (methodName == 'Filter'){
				success(getSampleFilterList());
			}else if (methodName == "GetAllCategories"){
				var jsonStr = getSampleCategories();
				success (jsonStr);
			}
		}
	}
};

var sampleCategoriesCount = 4;

function getSampleCategories(){
	var object = [];
	for (var i = 0; i < sampleCategoriesCount; i++) {
		var namestr = "sampleName" + i;
		var imagestr = staticImageUrl + i + ".jpg";
		var cat = {identifier : i, name : namestr, imagePath: imagestr}
		object.push(cat);
	};

	return object;
}

var sampleAllItensCount = 20;

function getSampleAllItens(){
	var object = [];
	for (var i = 0; i < sampleAllItensCount; i++) {
		var namestr = "sampleName" + i;
		var imagestr = staticImageUrl + i + ".jpg";
		var isSpentBool = Math.random() > 0.5;
		var item = {identifier : i, label : namestr, spent : isSpentBool, value : ((i+1)*10), dateCreated : '12/12/2012', dateSpent : '13/13/2013', }
		object.push(item);
	}
	return object;
}

function getSampleFilterList(){
	var object = [];
	for (var i = 0; i < 10; i++) {
		var namestr = "Valquiria Sample" + i;
		var imagestr = staticImageUrl + i + ".jpg";
		var isSpentBool = Math.random() > 0.5;
		var item = {identifier : i, label : namestr, spent : isSpentBool, value : ((i+1)*10), dateCreated : '12/12/2012', dateSpent : '13/13/2013', }
		object.push(item);
	}
	return object;
}
