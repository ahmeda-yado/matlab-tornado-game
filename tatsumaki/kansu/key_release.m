function key_release(data, flag01, ippo_chokushin, ippo)
    switch data.Key
        case 's'
            if flag01.value == 1
                flag01.value_update(0)
                rotate_camera_n(pi/8);
            end
        case 'a'
            ippo.value_update(ippo_chokushin);  % 速度を戻す
        case 'd'
            ippo.value_update(ippo_chokushin);
    end
end