function v3_new = rotate_n(v1, v2, v3, dt2)
    % v3をv1,v2が張る平面上を動くように原点周りの回転をしたい場合、
    % v1,v2平面の法線ベクトルを回転軸をすれば良い
    % 回転軸n
    n = cross(v1, v2);  % v1,v2が張る平面の法線
    n = n./norm(n);  % 正規化

    c = cos(dt2);
    s = sin(dt2);
    % n軸回転行列
    nkaiten = [n(1)^2*(1-c)+c n(1)*n(2)*(1-c)-n(3)*s n(1)*n(3)*(1-c)+n(2)*s;
               n(1)*n(2)*(1-c)+n(3)*s n(2)^2*(1-c)+c n(2)*n(3)*(1-c)-n(1)*s;
               n(1)*n(3)*(1-c)-n(2)*s n(2)*n(3)*(1-c)+n(1)*s n(3)^2*(1-c)+c];
    v3_new = (nkaiten*(v3'))';
end