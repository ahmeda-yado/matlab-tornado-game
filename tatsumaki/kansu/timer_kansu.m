function timer_kansu(tatsu, ippo_chokushin, ippo, cn, cpn, xdata_natural, ydata_natural, xshift, yshift, t, kankaku, time01, time_box)
zenshin(tatsu, ippo_chokushin, ippo, cn, cpn, xdata_natural, ydata_natural, xshift, yshift, t);

% 時間の更新
time_passed = kankaku*t.tasksExecuted;
if mod(time_passed, 1) == 0
    time01.value_update(time_passed);
    time_box.String = sprintf('時間: %d', time01.value);
    if time_passed == 30
        R = get(t, 'Running');
        if isequal(R ,'on')  % 一回だけ呼び出すようにするためのif文
            stop(timerfindall)  % 全部のタイマー止めるらしい
        end
    end
end
end