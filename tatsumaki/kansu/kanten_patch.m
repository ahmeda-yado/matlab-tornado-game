function obj = kanten_patch(stl_file)
    TR = stlread(stl_file);
    model.Vertices = TR.Points*7;  % 小さいので大きくする
    model.Faces    = TR.ConnectivityList;
    obj = patch(model, 'FaceColor', [.3 .6 1]);  % 水色
    obj = patch(model, 'FaceColor', [.2 .4 .8]);  % 水色
    % obj.LineWidth = .5; 
    obj.EdgeColor = "none";
    obj.FaceAlpha = .6;
end