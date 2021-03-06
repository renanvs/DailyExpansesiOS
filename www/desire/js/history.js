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

/////////Filter Form////////////////////////////
var filterJson = {};
$('#filterButton').click(function(){
	filterJson = {};

	var key;
	var value;

	key = "dateType";
	value = $('input[name = "date"]:checked')[0].getAttribute('value');
	addToFilterJson(key, value);

	key = $('input[name = "initDate"]')[0].getAttribute('name');
	value = $('input[name = "initDate"]')[0].value
	addToFilterJson(key, value);

	key = $('input[name = "endDate"]')[0].getAttribute('name');
	value = $('input[name = "endDate"]')[0].value
	addToFilterJson(key, value);

	key = $('input[name = "description"]')[0].getAttribute('name');
	value = $('input[name = "description"]')[0].value
	addToFilterJson(key, value);

	key = $('input[name = "includeNotes"]')[0].getAttribute('name');
	value = $('input[name = "includeNotes"]')[0].checked;
	addToFilterJson(key, value);

	key = $('input[value = "moneyIn"]')[0].getAttribute('value');
	value = $('input[value = "moneyIn"]')[0].checked;
	addToFilterJson(key, value);

	key = $('input[value = "money"]')[0].getAttribute('value');
	value = $('input[value = "money"]')[0].checked;
	addToFilterJson(key, value);

	key = $('input[value = "debit"]')[0].getAttribute('value');
	value = $('input[value = "debit"]')[0].checked;
	addToFilterJson(key, value);

	key = $('input[value = "credit"]')[0].getAttribute('value');
	value = $('input[value = "credit"]')[0].checked;
	addToFilterJson(key, value);

	if(spentCheckboxCheckedCount > 0){
		//key = $('input[name = "categories"]:checked')[0].getAttribute('name')
		key = "CategoryType";
		value = $('input[name = "categories"]:checked')[0].getAttribute('value')
		addToFilterJson(key, value);
	}

	key = $('input[name = "initValue"]')[0].getAttribute('name');
	value = $('input[name = "initValue"]')[0].value;
	addToFilterJson(key, value);

	key = $('input[name = "endValue"]')[0].getAttribute('name');
	value = $('input[name = "endValue"]')[0].value;
	addToFilterJson(key, value);

	key = 'categoriesSelected';
	value = [];
	var catSelectedList = Utils.GetController().selectedCategories;
	for (var i = 0; i < catSelectedList.length; i++) {
		var cat = catSelectedList[i];
		value.push(cat.identifier)
	};
	addToFilterJson(key, value);
	
	CordovaExec(function(filterList){
		Utils.GetController().itensList = filterList;
		Utils.Apply();
	}, "HistoryPlugin", "Filter",[JSON.stringify(filterJson)]);

	$('#backButton').click();
	showActiveFilterButton();
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
	Utils.GetController().orderItens();
	Utils.Apply();
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

function startLoad(){
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

	$('#filterActiveDiv').click(function(){
		CordovaExec(function(itensListStr){
			//alert(itensListStr[0].label);
			Utils.GetController().itensList = itensListStr;
			Utils.Apply();
			hideActiveFilterButton();
		}, "HistoryPlugin", "GetAllItens");
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
}

function finishedLoad(){
	$('#topBarLeftButton').popover({
		html : true,
		content : $('.popover').html(),
		placement : 'bottom'
	});

	$('#topBarMiddleButton').click(function(){
		CordovaExec(function(){
		
	}, "FormPlugin", "Back");
	});

	hideActiveFilterButton()
	Utils.Apply();

	
	$('input[name = "initDate"]')[0].value = Utils.GetCurrentDate();
	$('input[name = "endDate"]')[0].value = Utils.GetCurrentDate();
}

function setupTester(){
	//$("#topBarRightButton").click(function(){alert('click')})

	//mockFilter1();
}

function mockFilter1(){
	$('input[value = "allDate"]')[0].setAttribute("checked")

	$('input[name = "description"]')[0].value = "Fake"
	
	$('input[name = "includeNotes"]')[0].removeAttribute("checked")
	
	$('input[value = "moneyIn"]')[0].setAttribute("checked")

	$('input[value = "money"]')[0].setAttribute("checked")
	$('input[value = "debit"]')[0].setAttribute("checked")
	$('input[value = "credit"]')[0].setAttribute("checked")
	
	$('input[value = "allCategories"]')[0].setAttribute("checked")

	$('input[name = "initValue"]')[0].value = "11.11"
	$('input[name = "endValue"]')[0].value = "22.22"
}

function mockFilter0(){
	$('input[value = "allDate"]')[0].setAttribute("checked")

	$('input[name = "initDate"]')[0].value = "2013-11-12"
	$('input[name = "endDate"]')[0].value = "2013-11-12"

	$('input[name = "description"]')[0].value = "desfgsdgdf"
	
	$('input[name = "includeNotes"]')[0].removeAttribute("checked")
	
	$('input[value = "moneyIn"]')[0].removeAttribute("checked")

	$('input[value = "money"]')[0].setAttribute("checked")
	$('input[value = "debit"]')[0].setAttribute("checked")
	$('input[value = "credit"]')[0].setAttribute("checked")
	
	$('input[value = "selectedCategories"]')[0].setAttribute("checked")

	$('input[name = "initValue"]')[0].value = "11.11"
	$('input[name = "endValue"]')[0].value = "22.22"

	var tempCat = Utils.GetController().selectedCategories;
	var itemTemp = Utils.GetController().categoryItens[1];
	tempCat.push(itemTemp);
	var itemTemp = Utils.GetController().categoryItens[2];
	tempCat.push(itemTemp);
}

var isTester = false;

function HistoryController($scope){
	CordovaExec(function(value){
		isTester = value;

		if (isTester) {
			setupTester()
		};

	}, "UtilsPlugin", "IsTester");

	CordovaExec(function(itensListStr){
		$scope.itensList = itensListStr;
		if (!Utils.HasMock()) {
			Utils.Apply();
		};
		
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
		
		if (selected) {
			desireTr.setAttribute('style', bg)
		}else{
			desireTr.setAttribute('style', '')
		}
	}

	$scope.orderItens = function(){
		$scope.itensList = sortResults($scope.itensList, orderType.name, orderAscDescType.value);
	}

	$scope.selectedItem = function(item){
		CordovaExec(function(_itemId){
		}, "HistoryPlugin", "ShowForm", [item.identifier]);
	}

	$scope.orderList = createOrderListToController();

	function createOrderListToController(){
		var list = [];
		for (property in ORDERTYPE){
			list.push(ORDERTYPE[property]);
		}

		return list;
	}

	CordovaExec(function(catItensStr){
		$scope.categoryItens = catItensStr;
		if (!Utils.HasMock()) {
			Utils.Apply();
		};
		
	}, "HistoryPlugin", "GetAllCategories");
}

//////////// Others ///////////////////////////
function sortResults(list, prop, asc) {
    return list.sort(function(a, b) {
        if (asc) return (a[prop] > b[prop]) ? 1 : ((a[prop] < b[prop]) ? -1 : 0);
        else return (b[prop] > a[prop]) ? 1 : ((b[prop] < a[prop]) ? -1 : 0);
    });
}
////////////////////////////////////////////

function hideActiveFilterButton(){
	$('#filterActiveDiv').hide();
}

function showActiveFilterButton(){
	$('#filterActiveDiv').show();
}

