function [thrustVector,timeVector,toSave] = editThrustCurveFunction(thrustVector,timeVector)
	newThrustVector = thrustVector;
	newTimeVector = timeVector;
	opt = {"Add data point","Remove data point","Edit data point","Scale data points","Load .mat vectors","Save"};
	toSave = false;
	do
		figureHandle = figure('visible','off');
		clf;
		hold on;
		plot(newTimeVector,newThrustVector,'color','b','linestyle','-');
		plot(newTimeVector,newThrustVector,'color','r','marker','s','linestyle','none');
		xlabel("Time [s]");
		ylabel("Thrust [N]");
		title("Thrust curve");
		grid on;
		hold off;
		set(figureHandle,'visible','on');
		choice = menu("Edit thrust curve data",opt);
		close(figureHandle);
		switch (choice)
			case 0
				if toSave
					if menu("Save modifications?",{"yes","no"}) == 1
						thrustVector = newThrustVector;
						timeVector = newTimeVector;
					else
						toSave = false;
					end
				end
			case 1
				newInput = cell2mat(inputdlg("Time [s] point:"));
				if !isempty(newInput)
					newInput = str2double(newInput);
					if isnan(newInput)
						h = errordlg("Invalid entry");
						waitfor(h);
					else
						newTimePoint = newInput;
						if find(abs(newTimeVector-newTimePoint)<1e-2)
							h = errordlg("Time point too close to existing point");
							waitfor(h);
						else
							newInput = cell2mat(inputdlg("Thrust [N] point:"));
							if !isempty(newInput)
								newInput = str2double(newInput);
								if isnan(newInput)
									h = errordlg("Invalid entry");
									waitfor(h);
								else
									newThrustPoint = newInput;
									newThrustVector(end+1) = newThrustPoint;
									newTimeVector(end+1) = newTimePoint;
									[~,idx] = sort(newTimeVector);
									newTimeVector = newTimeVector(idx);
									newThrustVector = newThrustVector(idx);
									toSave = true;
								end
							end
						end
					end
				end
			case 2
				removeOpt = {};
				for i = 1:length(newTimeVector)
					removeOpt(end+1) = strjoin({num2str(newTimeVector(i))," [s] ",num2str(newThrustVector(i))," [N]"},'');
				end
				[idx,ok] = listdlg("PromptString","Points to remove","ListString",removeOpt,"SelectionMode","Multiple");
				if ok
					newThrustVector(idx) = [];
					newTimeVector(idx) = [];
					toSave = true;
				end
			case 3
				editOpt = {};
				for i = 1:length(newTimeVector)
					editOpt(end+1) = strjoin({num2str(newTimeVector(i))," [s] ",num2str(newThrustVector(i))," [N]"},'');
				end
				[idx,ok] = listdlg("PromptString","Point to edit","ListString",editOpt,"SelectionMode","Single");
				if ok
					newInput = cell2mat(inputdlg("Edit time point",'',1,{num2str(newTimeVector(idx))}));
					if !isempty(newInput)
						newInput = str2double(newInput);
						if isnan(newInput)
							h = errordlg("Invalid entry");
							waitfor(h);
						else
							editedTimePoint = newInput;
							newInput = cell2mat(inputdlg("Edit thrust point",'',1,{num2str(newThrustVector(idx))}));
							if !isempty(newInput)
								newInput = str2double(newInput);
								if isnan(newInput)
									h = errordlg("Invalid entry");
									waitfor(h);
								else
									editedThrustPoint = newInput;
									newThrustVector(idx) = editedThrustPoint;
									newTimeVector(idx) = editedTimePoint;
									toSave = true;
								end
							end
						end
					end
				end
			case 4
				newInput = cell2mat(inputdlg("Scale data points"));
				if !isempty(newInput)
					newInput = str2double(newInput);
					if isnan(newInput)
						h = errordlg("Invalid Entry");
						waitfor(h);
					else
						newThrustVector *= newInput;
						toSave = true;
					end
				end
			case 5
				toSave = false;
				[thrustFNAME,thrustFilePath,thrustFileltidx] = uigetfile(".mat","Load thrust.mat file");
				if ischar(thrustFNAME)
					[timeFNAME,timeFilePath,timeFileltidx] = uigetfile(".mat","Load time.mat file");
					if ischar(timeFNAME)
						load(thrustFNAME);
						load(timeFNAME);
						newThrustVector = Thrust;
						newTimeVector = t;
						if length(newThrustVector) ~= length(newTimeVector)
							h = warndlg("Loaded vectors differ in length, cutting to fit.");
							editedVectorsLength = min(length(newThrustVector),length(newTimeVector));
							newThrustVector = newThrustVector(1:editedVectorsLength);
							newTimeVector = newTimeVector(1:editedVectorsLength);
							waitfor(h);
						end
						toSave = true;
					end
				end
			case 6
				thrustVector = newThrustVector;
				timeVector = newTimeVector;
        toSave = true;
		end
	until choice == 0 || choice == length(opt)
end