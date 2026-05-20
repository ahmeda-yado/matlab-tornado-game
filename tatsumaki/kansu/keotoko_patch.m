function p = keotoko_patch(stl_file01, stl_file02, stl_file03)
    TR01 = stlread(stl_file01);
    model01.Vertices = TR01.Points*20;  % 小さいので大きくする
    model01.Faces    = TR01.ConnectivityList;
    TR02 = stlread(stl_file02);
    model02.Vertices = TR02.Points*20; 
    model02.Faces    = TR02.ConnectivityList;
    TR03 = stlread(stl_file03);
    model03.Vertices = TR03.Points*20; 
    model03.Faces    = TR03.ConnectivityList;
    
        % --- 色設定（RGB） ---
    color1 = [.8 .8 0];   
    color2 = [.9 .29 0];   
    color3 = [.81 1 .95];   
    color4 = [0 0 .1];
    
    % --- 頂点と面の結合 ---
    V1 = model01.Vertices;
    F1 = model01.Faces;
    
    V2 = model02.Vertices;
    F2 = model02.Faces + size(V1,1);   % offset
    
    V3 = model03.Vertices;
    F3 = model03.Faces + size(V1,1) + size(V2,1);   % offset
    
    % 結合
    V = [V1; V2; V3];
    F = [F1; F2; F3];

    % サングラスの色
    glass_color = repmat(color3, size(F3,1), 1);
    glass_color(1, :) = color4;
    glass_color(2, :) = color4;
    glass_color(3, :) = color4;
    glass_color(40, :) = color4;
    glass_color(41, :) = color4;
    glass_color(42, :) = color4;
    % colorcheck = [0 0 0];
    % for i=1:size(F3, 1)
    %     glass_color(i, :) = colorcheck;
    %     colorunchi = colorunchi + .02;
    % end
    
    % --- 面ごとの色データを作る ---
    C = [
        repmat(color1, size(F1,1), 1);
        repmat(color2, size(F2,1), 1);
        glass_color;
    ];
    
    % --- patch として描画 ---
    p = patch('Vertices', V, 'Faces', F, ...
              'FaceVertexCData', C, ...
              'FaceColor', 'flat', ...
              'EdgeColor', 'none');
end