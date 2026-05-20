function zenshin(point, ippo_chokushin, ippo, cn, cpn, xdn, ydn, xs, ys, t)
% cnは円の数、cpnは各円に含まれる点の数を持つ長さcnのベクトル
% xdn,ydn:自然体の座標、xs,ys:自然体からのずれ
    [caz, ~] = view;  % 現在の視点の方位角を取得
    theta_d = -caz*pi/180;  % 度数法から弧度法

    % 自然体(円の中心がずれない場合)の座標の行ベクトル
    xdn.lis_add(ippo.value*sin(theta_d));
    ydn.lis_add(ippo.value*cos(theta_d));

    % 実際に描画する座標の行ベクトル
    posx = xdn.lis;
    posy = ydn.lis;

    % 自然体+ずれをxdataとして更新
    m = 3;  % 形状変化の激しさ(円の中心をずらす最大値)
    point_count = cpn(1);
    for i = 2:cn
        cir_end = point_count + cpn(i);
        zure = -m + 2*m*rand;
        if mod(t.TasksExecuted, 5) == 0
            xs.ele_update(i, xs.lis(i-1) + zure);
            ys.ele_update(i, ys.lis(i-1) + zure);
        end

        posx(point_count + 1: cir_end) = xdn.lis(point_count + 1: cir_end) + xs.lis(i);
        posy(point_count + 1: cir_end) = ydn.lis(point_count + 1: cir_end) + ys.lis(i);

        point_count = point_count + cpn(i);
    end

    % pointの座標を新たに定める
    set(point, 'XData', posx, 'YData', posy);
    % 描画を更新
    drawnow;

    % camtargetで注視点を変えたい
    camtarget([posx(1) posy(1) 100]);

    % 直線に進んでいるなら速度を直進用の速度にするif文
    % key_pressでかえたそくどを戻すのが意図。key_releaseは処理が飛ばされることがあるのでそのときにこっちで戻す
    if mod(t.TasksExecuted, 10) == 0
        ippo.ele_update(1, ippo.lis(:, 2));
        ippo.ele_update(2, ippo.lis(:, 3));
        ippo.ele_update(3, [posx(1); posy(1)]);

        v1 = ippo.lis(:, 2) - ippo.lis(:, 1);
        v2 = ippo.lis(:, 3) - ippo.lis(:, 1);
        gaiseki = v1(1)*v2(2) - v1(1)*v2(2);
        if abs(gaiseki) < 1e-10  % 三点が同一直線上にある(一次従属)なら外積は0
            ippo.value_update(ippo_chokushin);
        end
    end
    
    % このif文がある理由：if文がない場合軸の更新の前にescで割り込まれると
    % escの処理が終わった後にxlimとylimが読まれ図が作られてしまうため
    [~, cel] = view; 
    if(cel == 90)   % 処理が終了しているか確認(escが押されてれば初期値の90が入る)
        close all
    end
end
