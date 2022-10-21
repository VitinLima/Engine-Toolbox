function isValid = isValidEngineFunction(eng)
	if isempty(eng.description) || isempty(eng.name) || isempty(eng.delays) || ...
		isempty(eng.manufacturer) || isequal(eng.diameter,-1) || isequal(eng.length,-1) || ...
		isequal(eng.propellentWeight,-1) || isequal(eng.totalWeight,-1)
		isValid = false;
	else
		isValid = true;
	end
end