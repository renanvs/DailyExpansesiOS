
var configJson = {
	checkboxes : [{'moneyIn' : false}, {'money' : false}, {'debit' : false}, {'credit' : false}],
	valueType : "AnyValue"
};


$(document).ready(function(){

	var spentCheckboxCheckedCount = 0;
	$('input[name="moneyInOut"]').on('change', function(e){
		var input = e.target;
		var value = input.value;
		var isChecked = input.checked;
		for (var i = 0; i < configJson.checkboxes.length; i++) {
			if (Object.keys(configJson.checkboxes[i])[0] == value) {
				configJson.checkboxes[i][value] = input.checked;
				break;
			};
		};

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
		var input = e.target;
		var value = input.value;
		
		configJson.valueType = value;

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

});


