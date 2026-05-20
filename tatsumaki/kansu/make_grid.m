function make_grid(xrange, yrange, xkan, ykan)
    x = -xrange:xkan:xrange;
    y = -yrange:ykan:yrange;
    z = 0;
    for i = x  % i がベクトルxを動く
        % RGBで色を指定
        plot3([i i], [y(1) y(end)], [z, z], "-", "Color", "#00841a");
    end
    for i = y
        plot3([x(1) x(end)], [i i], [z, z], "-", "Color", "#00841a");
    end
end
    