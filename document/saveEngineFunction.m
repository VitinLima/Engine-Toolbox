function saveEngineFunction(eng)
	[FNAME, FPATH, FFLTIDX] = uiputfile(".eng", "Save as:");
	if ischar(FNAME)
		saveEng([FPATH, filesep, FNAME], eng);
	end
end