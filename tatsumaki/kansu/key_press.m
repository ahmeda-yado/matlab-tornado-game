% 後から押されたキーで上書きされるので同時に押してもバグらないよう注意
function key_press(data, flag01, ippo_magaru, ippo, t)% 現在位置を取得
    theta_step = pi/2^7;
    switch data.Key
        % 仰角を小さくする
        case 's'
            if flag01.value == 0
                flag01.value_update(1);
                rotate_camera_n(-pi/8);
                % camorbit(0, -20);  % こっち使うと方向転換したときにおかしくなる
            end
        % 取舵
        case 'a'  
            rotate_camera(theta_step);   
            ippo.value_update(ippo_magaru);  % 曲がっているときの速度
        % 面舵
        case 'd'  
            rotate_camera(-theta_step);   
            ippo.value_update(ippo_magaru);
        % プログラムの終了
        case 'escape'
            R = get(t, 'Running');
            if isequal(R ,'on')  % 一回だけ呼び出すようにするためのif文
                stop(timerfindall)  % 全部のタイマー止めるらしい
            end
    end
end
