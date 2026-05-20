function rotate_camera(theta_step)
    campos_current = campos;
    camtarget_current = camtarget;

    % カメラ位置と注視点の差分ベクトル
    vec = campos_current - camtarget_current;

    % z軸周りの回転行列
    R = [cos(theta_step) -sin(theta_step) 0;
         sin(theta_step) cos(theta_step) 0;
         0 0 1];

    % 回転
    vec_rotated = (R*vec')';
    campos_new = camtarget_current + vec_rotated;

    % 更新
    campos(campos_new);
end
