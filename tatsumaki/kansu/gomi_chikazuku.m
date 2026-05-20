function gomi_chikazuku(point, gomi, gbasho, score, score_box)
    posx = get(point, 'XData');  % pointのx座標
    posy = get(point, 'YData');  % pointのy座標

    % 竜巻の近くにあるごみについてif文に入る
    for i = 1:length(gbasho.lis)
        if (abs(gbasho.lis(1, i) - posx(1)) < 100) ... 
                && (abs(gbasho.lis(2, i) - posy(1)) < 100)
            % gv = get(gomi.lis(i), 'Vertices');                    
            % set(gomi.lis(i), 'vertices', gv)
            g02 = gomi.lis(i);
            gbasho.ele_update(i, ones(3, 1)*100000)  % もう検知されないように位置情報を書き換える

            % 得点の更新
            score.value_add(1000);
            score_box.String = sprintf('Score: %d', score.value);

            % 回す処理と消す処理
            t_g = timer('TasksToExecute', 50, ... 
                'ExecutionMode', 'fixedrate', 'period', 0.1);
            t_g.TimerFcn = @(~, ~) ... 
                gomi_mawasu(point, g02);      
            t_g.StopFcn = @(~, ~) gomi_kesu(t_g, g02);
            start(t_g)
            break;
        end
    end
end
