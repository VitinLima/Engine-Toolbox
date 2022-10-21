function eng = editEngineFunction(eng)
	newEng = eng;
	newEng.toSave = false;
	do
		nameMessage = strjoin({"Name: ",newEng.name},'');
		descriptionMessage = strjoin({"Description:",(strjoin(newEng.description,'\n\t'))},'\n\t');
		diameterMessage = strjoin({"Diameter: ",num2str(newEng.diameter)},'');
		lengthMessage = strjoin({"Length: ",num2str(newEng.length)},'');
		delaysMessage = strjoin({"Delays: ",newEng.delays},'');
		propellentWeightMessage = strjoin({"Propellent weight: ",num2str(newEng.propellentWeight)},'');
		totalWeightMessage = strjoin({"Total weight: ",num2str(newEng.totalWeight)},'');
		manufacturerMessage = strjoin({"Manufacturer: ",newEng.manufacturer},'');
		opt = {nameMessage,descriptionMessage,diameterMessage,lengthMessage,...
			delaysMessage,propellentWeightMessage,totalWeightMessage,...
			manufacturerMessage,"Edit thrust curve","Save"};
		choice = menu("Edit engine model",opt);
		switch (choice)
			case 0
				if newEng.toSave
					if menu("Save modifications?",{"yes","no"}) == 1
						eng = newEng;
					else
						newEng.toSave = false;
					end
				end
			case 1
				newInput = cell2mat(inputdlg("Edit name:","",1,{newEng.name}));
				if !isempty(newInput)
					newEng.name = newInput;
					newEng.toSave = true;
				end
			case 2
				[newEng.description,toSave] = editDescriptionFunction(newEng.description);
				newEng.toSave = newEng.toSave || toSave;
			case 3
				newInput = cell2mat(inputdlg("Edit diameter:","",1,{num2str(newEng.diameter)}));
				if !isempty(newInput)
					newInput = str2double(newInput);
					if isnan(newInput)
						h = errordlg("Invalid entry.");
						waitfor(h);
					else
						newEng.diameter = newInput;
						newEng.toSave = true;
					end
				end
			case 4
				newInput = cell2mat(inputdlg("Edit length:","",1,{num2str(newEng.length)}));
				if !isempty(newInput)
					newInput = str2double(newInput);
					if isnan(newInput)
						h = errordlg("Invalid entry.");
						waitfor(h);
					else
						newEng.length = newInput;
						newEng.toSave = true;
					end
				end
			case 5
				newInput = cell2mat(inputdlg("Edit delays:","",1,{newEng.delays}));
				if !isempty(newInput)
					newEng.delays = newInput;
					newEng.toSave = true;
				end
			case 6
				newInput = cell2mat(inputdlg("Edit propellent weight:","",1,{num2str(newEng.propellentWeight)}));
				if !isempty(newInput)
					newInput = str2double(newInput);
					if isnan(newInput)
						h = errordlg("Invalid entry.");
						waitfor(h);
					else
						newEng.propellentWeight = newInput;
						newEng.toSave = true;
					end
				end
			case 7
				newInput = cell2mat(inputdlg("Edit total weight:","",1,{num2str(newEng.totalWeight)}));
				if !isempty(newInput)
					newInput = str2double(newInput);
					if isnan(newInput)
						h = errordlg("Invalid entry.");
						waitfor(h);
					else
						newEng.totalWeight = newInput;
						newEng.toSave = true;
					end
				end
			case 8
				newInput = cell2mat(inputdlg("Edit manufacturer:","",1,{newEng.manufacturer}));
				if !isempty(newInput)
					newEng.manufacturer = newInput;
					newEng.toSave = true;
				end
			case 9
				[newEng.thrust,newEng.time,ok] = editThrustCurveFunction(newEng.thrust,newEng.time);
				newEng.toSave = newEng.toSave || ok;
			case 10
				eng = newEng;
        newEng.toSave = true;
		end
	until choice == 0 || choice == length(opt)
end