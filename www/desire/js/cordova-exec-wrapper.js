function CordovaExec() {
	// 0: success callback
	// 1: error callback
	// 2: className
	// 4: methodName
	// 5: method arguments

	// Precisa no minimo do nome da classe e do método
	if (arguments.length < 2) {
		throw "É necessário informar ao menos o nome da classe e o nome do método, respectivamente";
	}

	var successCallback = function() {};
	var errorCallback = function(response) { console.log("Erro ao invocar o cordova: " + (response || "erro nao especificado")); };
	var className = null;
	var methodName = null;
	var methodArguments = [];
	var typeFirstIndex;

	if (typeof(arguments[0]) == "string") {
		// Se o primeiro argumento já é string, assume que não há callback
		// nem de sucesso nem de erro, pois eles deveriam ser os primeiros
		typeFirstIndex = 0;
	}
	else {
		successCallback = arguments[0];
	
		if (typeof(arguments[1]) == "function") {
			errorCallback = arguments[1];
			typeFirstIndex = 2;
		}
		else {
			typeFirstIndex = 1;
		}
	}

	className = arguments[typeFirstIndex];
	methodName = arguments[typeFirstIndex + 1];

	var lastArgument = arguments[arguments.length - 1];
	if (typeof(lastArgument) == "object") {
		methodArguments = lastArgument;
	}

	if (className == null || methodName == null || typeof(methodName) != "string") {
		throw "Nome da classe ou do método não informado";
	}

	cordova.exec(successCallback, errorCallback, className, methodName, methodArguments);
}
