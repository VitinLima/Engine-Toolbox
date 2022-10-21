close all;
clear all;
clc;

addpath([pwd,filesep,"document"]);
addpath([pwd,filesep,"model"]);
addpath([pwd,filesep,"util"]);

eng = newEngineFunction();
opt = {"Load","New","Save","Plot","Edit model","Exit"};
do
	h = displayEngineDetailsFunction(eng);
  choice = menu("OpenRocket Engine Editor",opt);
	close(h);
  switch (choice)
    case 0
			if eng.toSave
        if isValidEngineFunction(eng)
          if menu("Save current model?",{"yes","no"}) == 1
            saveEngineFunction(eng);
          end
        end
      end
    case 1
			[FNAME,FPATH,fileltidx] = uigetfile(".eng","Load existing engine");
			if ischar(FNAME)
				eng = loadEng([FPATH, filesep, FNAME]);
				eng.toSave = false;
			end
    case 2
      eng = newEngineFunction();
			eng.toSave = false;
    case 3
			if isValidEngineFunction(eng)
				saveEngineFunction(eng);
			else
				h = errordlg("Invalid engine model.");
				waitfor(h);
			end
			eng.toSave = false;
		case 4
			if isValidEngineFunction(eng)
				figureHandle = plotEng(eng);
				waitfor(figureHandle);
			end
		case 5
      eng = editEngineFunction(eng);
		case 6
			if eng.toSave
        if isValidEngineFunction(eng)
          if menu("Save current model?",{"yes","no"}) == 1
            saveEngineFunction(eng);
          end
        end
      end
  end
until choice == 0 || choice == length(opt)
close all;