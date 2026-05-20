function rotate_camera_n(theta_step)
    campos_current = campos;
    camtarget_current = camtarget;

    % カメラ位置と注視点の差分ベクトル
    vec = campos_current - camtarget_current;

    % 回転
    vec_rotated = rotate_n(vec, [0 0 1], vec, theta_step);
    campos_new = camtarget_current + vec_rotated;

    % 更新
    campos(campos_new);
end
