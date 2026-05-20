function gomi_mawasu(point, gomi)
    tposx = get(point, 'XData');  % pointのx座標
    tposy = get(point, 'YData');  % pointのy座標 
    gv = get(gomi, 'Vertices');
    theta = pi/4;
    zkaiten = [cos(theta) -sin(theta) 0;
               sin(theta) cos(theta)  0;
               0          0           1];
    % (200, 200)分だけ原点に近づける
    gv(:, 1) = gv(:, 1) - tposx(1);
    gv(:, 2) = gv(:, 2) - tposy(1);
    % 原点を中心に回転
    gv = (zkaiten*(gv'))';
    % 移動した分元に戻す
    gv(:, 1) = gv(:, 1) + tposx(1);
    gv(:, 2) = gv(:, 2) + tposy(1);

    % ごみを段々持ち上げる
    if gv(1, 3) < 190
        gv(:, 3) = gv(:, 3) + 10; 
    end

    set(gomi, 'Vertices', gv);
end
