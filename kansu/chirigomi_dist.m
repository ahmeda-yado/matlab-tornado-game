function basho = chirigomi_dist(obj, zpoint)
    basho = randi([-5000, 5000], 3, 1);
    basho(3) = zpoint;
    obj_v = get(obj, 'Vertices');  % 頂点の座標
    obj_v(:, 1) = obj_v(:, 1) + basho(1);
    obj_v(:, 2) = obj_v(:, 2) + basho(2);
    obj_v(:, 3) = obj_v(:, 3) + zpoint;
    set(obj, 'Vertices', obj_v);
end