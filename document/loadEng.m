function eng = loadEng(fileName)
##  _description = [];
  
  FID = fopen(fileName);
  
  _description = {};
  
  s = fgetl(FID);
  while s(1)==';'
    s = s(2:end);
    _description(end+1) = s(find(s!=' ')(1):end);
    s = fgetl(FID);
  end
  
  s = strsplit(s,' ');
  _name = cell2mat(s(1));
  _diameter = str2double(s(2));
  _length = str2double(s(3));
  _delays = cell2mat(s(4));
  _propellentWeight = str2double(s(5));
  _totalWeight = str2double(s(6));
  _manufacturer = cell2mat(s(7));
  
  disp("Loading engine:");
  disp("Description: ");
  disp(char(_description));
  puts("Name: ");disp(_name);
  puts("Diameter: ");disp(num2str(_diameter));
  puts("Length: ");disp(num2str(_length));
  puts("Delays: ");disp(_delays);
  puts("Propellent weight: ");disp(num2str(_propellentWeight));
  puts("Total weight: ");disp(num2str(_totalWeight));
  puts("Name: ");disp(_manufacturer);
  
  _time = [];
  _thrust = [];
  
  do
    s = fgetl(FID);
    if isempty(s)
      continue;
    end
    s = s(find(s!=' ')(1):end);
    s = str2double(strsplit(s));
    _time(end+1) = s(1);
    _thrust(end+1) = s(2);
  until feof(FID);
  
  fclose(FID);
  
  eng.description = _description;
  eng.name = _name;
  eng.diameter = _diameter;
  eng.length = _length;
  eng.delays = _delays;
  eng.propellentWeight = _propellentWeight;
  eng.totalWeight = _totalWeight;
  eng.manufacturer = _manufacturer;
  eng.time = _time;
  eng.thrust = _thrust;
end