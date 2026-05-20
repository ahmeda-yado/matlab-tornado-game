function chiri_chikazuku(point, chiri, cbasho, score, score_box)
    posx = get(point, 'XData');  % pointのx座標
    posy = get(point, 'YData');  % pointのy座標
    
    % 竜巻の近くにある塵についてif文に入る
    for i = 1:length(cbasho.lis)
        if (abs(cbasho.lis(1, i) - posx(1)) < 100) ... 
                && (abs(cbasho.lis(2, i) - posy(1)) < 100)
            % gv = get(chiri.lis(i), 'Vertices');
            % set(chiri.lis(i), 'vertices', gv)
            c02 = chiri.lis(i);
            cbasho.ele_update(i, ones(3, 1)*100000)  % もう検知されないように位置情報を書き換える

            % 得点の更新
            score.value_add(100);
            score_box.String = sprintf('Score: %d', score.value);

            % 回す処理と消す処理
            t3 = timer('TasksToExecute', 100, ... 
                'ExecutionMode', 'fixedSpacing', 'period', 0.1);
            t3.TimerFcn = @(~, ~) ... 
                chiri_mawasu(point, c02);       
            t3.StopFcn = @(~, ~) chiri_kesu(t3, c02);     
            start(t3)
            break;
        end
    end
end
