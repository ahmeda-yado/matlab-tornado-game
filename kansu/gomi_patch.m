function obj = gomi_patch(stl_file)
    TR = stlread(stl_file);
    model.Vertices = TR.Points;
    model.Faces    = TR.ConnectivityList;
    obj = patch(model, 'FaceColor', [1 0 1]);
end