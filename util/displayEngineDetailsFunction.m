function h = displayEngineDetailsFunction(eng)
	nameMessage = strjoin({"Name: ",eng.name},'');
	descriptionMessage = strjoin({"Description:",(strjoin(eng.description,'\n\t'))},'\n\t');
	diameterMessage = strjoin({"Diameter: ",num2str(eng.diameter)},'');
	lengthMessage = strjoin({"Length: ",num2str(eng.length)},'');
	delaysMessage = strjoin({"Delays: ",eng.delays},'');
	propellentWeightMessage = strjoin({"Propellent weight: ",num2str(eng.propellentWeight)},'');
	totalWeightMessage = strjoin({"Total weight: ",num2str(eng.totalWeight)},'');
	manufacturerMessage = strjoin({"Manufacturer: ",eng.manufacturer},'');
	detailsMessage = strjoin({nameMessage,descriptionMessage,diameterMessage,lengthMessage,delaysMessage,propellentWeightMessage,totalWeightMessage,manufacturerMessage},'\n');
	h = msgbox(detailsMessage,strjoin({"Engine ",eng.name},''));
end