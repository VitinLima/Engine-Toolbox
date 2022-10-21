function saveEng(filename,eng)
  FID = fopen(filename,'w');
  
  disp("Saving engine:");
  disp("Description: ");
  disp(char(eng.description));
  puts("Name: ");disp(eng.name);
  puts("Diameter: ");disp(num2str(eng.diameter));
  puts("Length: ");disp(num2str(eng.length));
  puts("Delays: ");disp(eng.delays);
  puts("Propellent weight: ");disp(num2str(eng.propellentWeight));
  puts("Total weight: ");disp(num2str(eng.totalWeight));
  puts("Name: ");disp(eng.manufacturer);
  
  for i = 1:length(eng.description)
    fdisp(FID,strjoin({"; ",cell2mat(eng.description(i))},''));
  end
  fdisp(FID,strjoin({eng.name,...
    num2str(eng.diameter),...
    num2str(eng.length),...
    eng.delays,...
    num2str(eng.propellentWeight),...
    num2str(eng.totalWeight),...
    eng.manufacturer},' '));
  
  for i = 1:length(eng.time)
    s = strjoin({"   ",num2str(eng.time(i))," ",num2str(eng.thrust(i))},'');
    fdisp(FID,s);
  end
  
  fclose(FID);
end