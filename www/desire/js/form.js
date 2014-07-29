var TYPE = {
	RENDIMENTOS : {value:0, name:'rendimentos'},
	DESPESAS : {value:1, name:'despesas'}
};

var SPENTTYPE = {
	UNDEFINED : {value:0, name:'undefined'},
	DINHEIRO : {value:1, name:'dinheiro'},
	DEBITO : {value:2, name:'debito'},
	CREDITO : {value:3, name:'credito'}
};

var currentType = TYPE.RENDIMENTOS;
var currentSpentType = SPENTTYPE.UNDEFINED;



////
var rendimentoRadio = $('form').find('input[value="Rendimento"]')[0]
var despesaRadio = $('form').find('input[value="Despesa"]')[0]
var dinheiroRadio = $('form').find('input[value="Dinheiro"]')[0]
var creditoRadio = $('form').find('input[value="Credito"]')[0]
var debitoRadio = $('form').find('input[value="Debito"]')[0]
////

$(document).ready(function(){
	startLoad();
});

function startLoad(){
	$('body').hide();
}

function finishedLoad(){
	CordovaExec(function(item){
                setTimeout(function(){populateFormWithItem(item);
},15000)
    }, "FormPlugin", "Populate");
    
    $('#topBarLeftButton').click(function(e){
                CordovaExec(function(){},"FormPlugin", "Back");
    });
    
	$('body').show();
}


$('input[name=type]').on('change', function(){
	updateRadios();
})

$('input[name=typeSpent]').on('change', function(){
	updateRadios();
})

$(".radioBorder").click(function(e){
	if (e.target.tagName == "INPUT"){
		target,checked = true;
		return;
	}
	var target = $(e.target).find('input')[0];
	target.checked = true

	updateRadios();
})

function updateRadios(){

	if (rendimentoRadio.checked) {
		currentType = TYPE.RENDIMENTOS;
		currentSpentType = SPENTTYPE.UNDEFINED;
		$('#typeSpent').hide("blind",600);
		$('#categoryContainer').hide("blind",600);
		$('#parcelContainer').hide("blind",600);
	}else{
		currentType = TYPE.DESPESAS;
		currentSpentType = dinheiroRadio.checked ? SPENTTYPE.DINHEIRO : currentSpentType;
		currentSpentType = debitoRadio.checked ? SPENTTYPE.DEBITO : currentSpentType;
		currentSpentType = creditoRadio.checked ? SPENTTYPE.CREDITO : currentSpentType;
		$('#typeSpent').show("blind",600);
		$('#categoryContainer').show("blind",600);
		$('#parcelContainer').show("blind",600);
	}
}

$('#topBarRightButton').click(function(){
	sendToCore();
});

function getFormDatasToJson(){
	var itemModel = new Object();
	itemModel.description = $("#description")[0].value;
	itemModel.price = $("#price")[0].value;
	itemModel.categoryId = getFormController().selectedCategory.identifier;
	itemModel.parcel = $("#parcelComboBox")[0].value.replace('x', '');
	itemModel.dateSpent = $("input[type= 'date']")[0].value;
	itemModel.notes = $("#notes")[0].value;
	itemModel.type = currentType.name;
	itemModel.spentType = currentSpentType.name;
	return itemModel;
}

function sendToCore(){
	var model = getFormDatasToJson();
	var jsonStr = JSON.stringify(model);
	CordovaExec(function(msg){
            	alert(msg);
            }, "FormPlugin", "SendItem",[jsonStr]);
}

function populateFormWithItem(item){
	$("#description")[0].value = item.label;
	$("#price")[0].value = item.value.replace(',','.');
	//$("#categoryId")[0].textContent = item.categoryId;
	getFormController().setCurrentCategoryById(item.category.identifier);
	$("#parcelComboBox")[0].selectedIndex = item.parcel -1;
	$("input[type= 'date']")[0].value = item.dateSpent;
	$("#notes")[0].value = item.notes;
    
	if (item.spent == 0) {
		rendimentoRadio.click();
	}else{
		if (item.money == 1) {
			dinheiroRadio.click();
		}else if (item.debit == 1) {
			debitoRadio.click();
		}else if (item.creditoCard == 1) {
			creditoRadio.click();
		}
		despesaRadio.click();
	}
	apply();
}



function getFormController(){
	var formController = angular.element($("body")).scope();
	if (formController) {
		return formController;
	};

	return;
}

function apply(){
	getFormController().$apply();
}

function CategoryListController($scope){
	CordovaExec(function(catItens){
		$scope.categoryItens = catItens;
	}, "HistoryPlugin", "GetAllCategories");

	$scope.selectedCategory = {name : "tttt", imagePath : "img/indice.svg"};

	$scope.categorySelected = function(e){
		$scope.selectedCategory  = e;
		$('#closeModalButton').click();
	}

	$scope.setCurrentCategoryById = function(catId){
		$.each($scope.categoryItens, function(i, cat){
			if (cat.identifier == catId) {
				$scope.selectedCategory = cat;
			};
		});
	}
}