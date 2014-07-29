////// Order declaration ////////////////////
var ORDERTYPE = {
	DESCRIPTION : 	{value:0, name:'description' , label:'Descrição'},
	VALUE : 		{value:1, name:'value' , label:'Valor'},
	DATECREATED : 	{value:2, name:'dateCreated' , label:'Data Criada'},
	DATEMADE : 		{value:3, name:'date' , label:'Data Realizada'},
	TYPE : 			{value:4, name:'isSpent' , label:'Rendimento/Despesa'}
};

var ORDERASCDESCTYPE = {
	ASC: 	{name:'asc', value : true},
	DESC: 	{name:'desc', value : false}
};	

var orderType;
var orderAscDescType = ORDERASCDESCTYPE.ASC;

var spentCheckboxCheckedCount = 0;
/////////////////////////////////////////////

$(document).ready(function(){
	startLoad();

	//Popover button pressed
	$('body').on('click', 'button.invisibleOrderButton', function(){
		invisibleOrderButtonPressed(this);
	})

	//selected row in table
	$('.trItem').click(function(e){
		var tr = this;
		var allTrs = $('.trItem');
		$.each(allTrs, function(i, currentTd){
			currentTd.setAttribute('class' ,'info trItem')
		});

		tr.setAttribute('class' ,'success trItem')
	});

	///////////////// Filter UI///////////////////////////////////
	
	$('input[name="moneyInOut"]').on('change', function(e){
		var value = e.target.value;
		var isChecked = e.target.checked;
		
		if (value == 'money' || value == 'debit' || value == 'credit'){
			if (isChecked){
				spentCheckboxCheckedCount++;
			}else{
				spentCheckboxCheckedCount--;
			}
		}

		if (spentCheckboxCheckedCount == 0) {
			$('#categoriesCheckContainer').hide("blind",600);
		}else{
			$('#categoriesCheckContainer').show("blind",600);
		}

	})

	$('input[name="valueType"]').on('change', function(e){
		var value = e.target.value;
		
		if (value == "AnyValue") {
			$('#valueContainer').hide("blind",600);
		}else if (value == "SpecificValue") {
			$('#startValueContainer').show();
			$('#endValueContainer').hide();
			$('#valueContainer').show("blind",600);
		}else if (value == "ValueInterval") {
			$('#startValueContainer').show();
			$('#endValueContainer').show();
			$('#valueContainer').show("blind",600);
		}

	})

	$('input[name = "date"]').on('change', function(e){
		var input = e.target;
		var showHide;
		if (input.value == 'specificDate') {
			showHide = 'show';
		}else{
			showHide = 'hide';
		}
		$('#dateContainer')[showHide]("blind",600);
	})

	$('input[name = "includeNotes"]').click(
		function(e){
			var isChecked = e.target.checked;
		}
	);

	$('input[name = "categories"]').on('change', function(e){
		var input = e.target;
		var showHide;
		if (input.value == 'allCategories') {
			showHide = 'hide';
		}else{
			showHide = 'show';
		}
		$('#categoriesContainer')[showHide]("blind",600);
	})
	//////////////////////////////////////////////////////////////////////

});

/////////Filter Form////////////////////////////
var filterJson = {};
$('#filterButton').click(function(){
	filterJson = {};

	var key;
	var value;

	//date checkbox
	key = 	$('input[name = "date"]:checked')[0].getAttribute('name');
	value = $('input[name = "date"]:checked')[0].getAttribute('value');
	addToFilterJson(key, value);

	//date text - init
	key = $('input[name = "initDate"]')[0].getAttribute('name');
	value = $('input[name = "initDate"]')[0].value
	addToFilterJson(key, value);

	//date text - end
	key = $('input[name = "endDate"]')[0].getAttribute('name');
	value = $('input[name = "endDate"]')[0].value
	addToFilterJson(key, value);

	//description text
	key = $('input[name = "description"]')[0].getAttribute('name');
	value = $('input[name = "description"]')[0].value
	addToFilterJson(key, value);

	//include notes search
	key = $('input[name = "includeNotes"]')[0].getAttribute('name');
	value = $('input[name = "includeNotes"]')[0].checked;
	addToFilterJson(key, value);

	//include Rendimento
	key = $('input[value = "moneyIn"]')[0].getAttribute('value');
	value = $('input[value = "moneyIn"]')[0].checked;
	addToFilterJson(key, value);

	//include Dinheiro
	key = $('input[value = "money"]')[0].getAttribute('value');
	value = $('input[value = "money"]')[0].checked;
	addToFilterJson(key, value);

	//include Débito
	key = $('input[value = "debit"]')[0].getAttribute('value');
	value = $('input[value = "debit"]')[0].checked;
	addToFilterJson(key, value);

	//include Crédito
	key = $('input[value = "credit"]')[0].getAttribute('value');
	value = $('input[value = "credit"]')[0].checked;
	addToFilterJson(key, value);

	//Categories
	if(spentCheckboxCheckedCount > 0){
		key = $('input[name = "categories"]:checked')[0].getAttribute('name')
		value = $('input[name = "categories"]:checked')[0].getAttribute('value')
		addToFilterJson(key, value);
	}

	//initValue
	key = $('input[name = "initValue"]')[0].getAttribute('name');
	value = $('input[name = "initValue"]')[0].value;
	addToFilterJson(key, value);

	//endValue
	key = $('input[name = "endValue"]')[0].getAttribute('name');
	value = $('input[name = "endValue"]')[0].value;
	addToFilterJson(key, value);

	//categoriesSelecteds
	key = 'categoriesSelected';
	value = [];
	var catSelectedList = getHistoryController().selectedCategories;
	for (var i = 0; i < catSelectedList.length; i++) {
		var cat = catSelectedList[i];
		value.push(cat.id)
	};
	addToFilterJson(key, value);
	
	CordovaExec(function(filterList){
		getHistoryController().itensList = JSON.parse(filterList);
		apply();
	}, "HistoryPlugin", "Filter",[JSON.stringify(filterJson)]);

	$('#backButton').click();
})

function addToFilterJson (key, value){
	filterJson[key] = value;
}
////////////////////////////////////////////////

/////////// Order Methods ////////////////////////////////////////////////
function invisibleOrderButtonPressed(e){
	var orderName = e.getAttribute('data');
	orderType = getOrderTypeByName(orderName);
	orderAscDescType = getAscDescTypeByName($('input:radio[name = "order"]:checked')[0].value);
	getHistoryController().orderItens();
	apply();

}

function getOrderTypeByName (name){
	for (property in ORDERTYPE){
		var currentName = (ORDERTYPE[property].label);
		if (currentName == name) {
			return ORDERTYPE[property];
		};
	}
}

function getAscDescTypeByName (name){
	for (property in ORDERASCDESCTYPE){
		var currentName = (ORDERASCDESCTYPE[property].name);
		if (currentName == name) {
			return ORDERASCDESCTYPE[property];
		};
	}
}
/////////////////////////////////////////////

/////////// Angular /////////////////////////////
function getHistoryController(){
	var historyController = angular.element($("body")).scope();
	if (historyController) {
		return historyController;
	};

	return;
}

function startLoad(){
	$('body').hide();
}

function finishedLoad(){
	//alert('fi');
	$('#topBarLeftButton').popover({
		html : true,
		content : $('.popover').html(),
		placement : 'bottom'
	});
	apply();
	$('body').show();
}


function apply(){

	if (!hasMock()) {
		getHistoryController().$apply();
	};
}

function hasMock(){
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
}

function HistoryController($scope){
	CordovaExec(function(itensListStr){
		//alert(itensListStr[0].label);
		$scope.itensList = itensListStr;
		apply();
	}, "HistoryPlugin", "GetAllItens");

	$scope.selectedCategories = [];
	$scope.categorySelected = function(e){
		if (e.selected == null || e.selected == false) {
			e.selected = true;
			$scope.selectedCategories.push(e);
		}else{
			e.selected = false;
			$scope.selectedCategories.pop(e);
		}

		refreshSelectedRow(e.identifier, e.selected);

	}

	$scope.selectedOrderItem = function(){
		alert('poert');
	}

	function refreshSelectedRow(id, selected){

		var bg = 'background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(184,225,252,1)), color-stop(10%,rgba(169,210,243,1)), color-stop(25%,rgba(144,186,228,1)), color-stop(37%,rgba(144,188,234,1)), color-stop(50%,rgba(144,191,240,1)), color-stop(51%,rgba(107,168,229,1)), color-stop(83%,rgba(162,218,245,1)), color-stop(100%,rgba(189,243,253,1)));'

		var desireTr;
		$.each($('.categoryTr'), function(i, tr){
			if (tr.getAttribute('data') == id) {
				desireTr = tr;
				return;
			};
		});
		
		//var color;

		if (selected) {
			desireTr.setAttribute('style', bg)
		}else{
			desireTr.setAttribute('style', '')
		}

		//desireTr.style.backgroundColor = color;
	}

	$scope.orderItens = function(){
		$scope.itensList = sortResults($scope.itensList, orderType.name, orderAscDescType.value);
	}

	$scope.selectedItem = function(item){
		CordovaExec(function(_itemId){
			 //alert(_itemId);
		}, "HistoryPlugin", "ShowForm", [item.identifier]);
	}

	$scope.orderList = createOrderListToController();
	//apply();

	function createOrderListToController(){
		var list = [];
		for (property in ORDERTYPE){
			list.push(ORDERTYPE[property]);
		}

		return list;
	}

	CordovaExec(function(catItensStr){
		$scope.categoryItens = catItensStr;
		apply();
	}, "HistoryPlugin", "GetAllCategories");
}

var full;
////////////////////////////////////////////////

//////////// Others ///////////////////////////
function sortResults(list, prop, asc) {
    return list.sort(function(a, b) {
        if (asc) return (a[prop] > b[prop]) ? 1 : ((a[prop] < b[prop]) ? -1 : 0);
        else return (b[prop] > a[prop]) ? 1 : ((b[prop] < a[prop]) ? -1 : 0);
    });
}
////////////////////////////////////////////



