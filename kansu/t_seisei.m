% 竜巻を生成する関数
% aは高さ、sは描画する円の間隔、bairitsuは竜巻の形状の倍率、後は根元の座標
% 出力をplotのみにしたい
function [point, cir_num, cir_point_num] = t_seisei(a, s, bairitsu, x0, y0, z0)
    h = 0:s:a;
    r = zeros(1, length(h));
    for i = 1:length(h)
        r(i) = (a^(2/3) - h(i)^(2/3))^(3/2);  % アステロイドの分枝
    end
    r = flip(r).*bairitsu;  % 竜巻の幅になる円の半径、r(i)がh(i)に対応する
    
    % 三次元プロットの為のベクトル
    x = [];
    z = [];
    y = [];

    cir_num = 0;  % 円の数 現状hと等しくなる
    cir_point_num = [];  % 円が持つ点の数、長さはcir_numと等しくなる
    for i = 1:length(h)  % 高さh(i)のとき半径r(i)の円を描く
        x1 = -r(i):0.1:r(i);  % xを-rからrまで動かす
        z1 = zeros(1, length(x1));
        for j = 1:length(x1)
            z1(j) = sqrt(r(i)^2 - x1(j)^2);  % 半円のz座標を求める
        end
        % もう一つの半円の座標を追加
        x1 = [x1 flip(x1)];
        z1 = [z1 -z1];
        % y座標（高さ）を追加
        y1 = ones(1, length(x1))*h(i);
        % 描画する為のベクトルに座標を追加
        x = [x x1];
        z = [z z1];
        y = [y y1];

        cir_num = cir_num + 1;
        cir_point_num(cir_num) = length(x1);  % 円ごとの点の数を記録
    end
    
    % 竜巻を根元の座標に移動させる
    x = x + x0;
    z = z + z0;
    y = y + y0;

    % cir_num
    % cir_point_num(1)
    
    point = plot3(x, z, y);
end
