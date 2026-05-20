function obj = don_patch(stl_file)
    TR = stlread(stl_file);
    model.Vertices = TR.Points*30;  % 小さいので大きくする
    model.Faces    = TR.ConnectivityList;
    obj = patch(model, 'FaceColor', [1 0.5 0]);  % 橙色
    % obj.LineWidth = .5; 
    obj.EdgeColor = "none";
end