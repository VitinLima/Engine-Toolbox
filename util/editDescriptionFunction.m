function [description,toSave] = editDescriptionFunction(description)
	descriptionEdited = description;
	opt = {"Add","Remove","Edit","Save"};
	toSave = false;
	do
		choice = menu("Edit engine description",opt);
		switch (choice)
			case 0
				if toSave
					if menu("Save modifications?",{"yes","no"}) == 1
						description = descriptionEdited;
					else
						toSave = false;
					end
				end
			case 1
				newInput = cell2mat(inputdlg("Add new description"));
				if !isempty(newInput)
					descriptionEdited(end+1) = newInput;
					toSave = true;
				end
			case 2
				[idxToEdit,ok] = listdlg("ListString",descriptionEdited,"SelectionMode","Single");
				if ok == 1
					descriptionEdited(idxToEdit) = [];
					toSave = true;
				end
			case 3
				[idxToEdit,ok] = listdlg("ListString",descriptionEdited,"SelectionMode","Single");
				if ok == 1
					newInput = cell2mat(inputdlg("Edit description","",1,descriptionEdited(idxToEdit)));
					if !isempty(newInput)
						descriptionEdited(idxToEdit) = newInput;
						toSave = true;
					end
				end
			case 4
				description = descriptionEdited;
		end
	until choice == 0 || choice == length(opt)
end