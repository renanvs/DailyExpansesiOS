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
var currentItem;

////
var rendimentoRadio = $('form').find('input[value="Rendimento"]')[0]
var despesaRadio = $('form').find('input[value="Despesa"]')[0]
var dinheiroRadio = $('form').find('input[value="Dinheiro"]')[0]
var creditoRadio = $('form').find('input[value="Credito"]')[0]
var debitoRadio = $('form').find('input[value="Debito"]')[0]
////

function finishedLoad(){
	CordovaExec(function(item){
		populateFormWithItem(item)
    }, "FormPlugin", "Populate");
    
    $('#topBarLeftButton').click(function(e){
        CordovaExec(function(){},"FormPlugin", "Back");
    });

    $("input[type= 'date']")[0].value = Utils.GetCurrentDate();
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
	if (itemModel.description == "") {return false};

	itemModel.price = $("#price")[0].value;
	if (itemModel.price == "") {return false};

	itemModel.categoryId = Utils.GetController().selectedCategory.identifier;
	itemModel.parcel = $("#parcelComboBox")[0].value.replace('x', '');
	
	itemModel.dateSpent = $("input[type= 'date']")[0].value;
	if (itemModel.dateSpent == "") {return false};

	itemModel.notes = $("#notes")[0].value;
	
	if(currentType == TYPE.RENDIMENTOS){
		itemModel.spent = 0;
		itemModel.money = 0;
		itemModel.creditCard = 0;
		itemModel.debit = 0;
	}else{
		if (currentSpentType == SPENTTYPE.DINHEIRO) {
			itemModel.money = 1;
			itemModel.creditCard = 0;
			itemModel.debit = 0;
		}else if (currentSpentType == SPENTTYPE.CREDITO) {
			itemModel.creditCard = 1;
			itemModel.money = 0;
			itemModel.debit = 0;
		}else if (currentSpentType == SPENTTYPE.DEBITO) {
			itemModel.debit = 1;
			itemModel.creditCard = 0;
			itemModel.money = 0;
		}
		itemModel.spent = 1;
	}

	if(currentItem){
		itemModel.identifier = currentItem.identifier;
	}

	return itemModel;
}

function sendToCore(){
	var model = getFormDatasToJson();

	if (model == false) {
		composeFieldErro();
		return;
	};

	var jsonStr = JSON.stringify(model);
	CordovaExec(function(itemModel){
            	populateFormWithItem(itemModel)
            }, "FormPlugin", "SendItem",[jsonStr]);
}

function composeFieldErro(){
	alert('errro')
}

function populateFormWithItem(item){
	currentItem = item;
	$("#description")[0].value = item.label;
	$("#price")[0].value = item.value.replace(',','.');
	Utils.GetController().setCurrentCategoryById(item.category.identifier);
	$("#parcelComboBox")[0].selectedIndex = item.parcel -1;
	var aDate = currentItem.dateSpent.split('-');
	var bDate = aDate[0] + '-' + aDate[2] + '-' + aDate[1];
	$("input[type= 'date']")[0].value = bDate;
	$("#notes")[0].value = item.notes;
    
	if (item.spent == 0) {
		rendimentoRadio.click();
	}else{
		if (item.money == 1) {
			dinheiroRadio.click();
		}else if (item.debit == 1) {
			debitoRadio.click();
		}else if (item.creditCard == 1) {
			creditoRadio.click();
		}
		despesaRadio.click();
	}
	Utils.Apply();
}

function CategoryListController($scope){
	CordovaExec(function(catItens){
		$scope.categoryItens = catItens;
		if (!Utils.HasMock()) {Utils.Apply();};
		
	}, "HistoryPlugin", "GetAllCategories");

	$scope.selectedCategory = {name : "Default", imagePath : "img/category_icons/icon_default.png"};

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