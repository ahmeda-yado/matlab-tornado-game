% 動作確認：matlab2025b
clear; close all; 

% 図を生成
screen_size = get(0, 'ScreenSize');
fig = figure('Name', 'たつまきゲーム');
figure(fig) % 上手くフィギュアウィンドウにフォーカスされない時用の処理

hold on;

% ごみを生成
stl_path = 'stl/';
p01 = gomi_patch(sprintf('%s%s', stl_path, 'kyuutai01.stl'));  % 球体
p02 = gomi_patch(sprintf('%s%s', stl_path, 'heli01.stl'));  % ヘリコプター
p03 = gomi_patch(sprintf('%s%s', stl_path, 'tank03.stl'));  % 戦車
p04 = don_patch(sprintf('%s%s', stl_path, 'don04.stl'));  % 首領
p05 = kanten_patch(sprintf('%s%s', stl_path, 'kanten02.stl'));  % 寒天
keotoko_stl01 = sprintf('%s%s', stl_path, 'ke04.stl');
keotoko_stl02 = sprintf('%s%s', stl_path, 'kao04.stl');
keotoko_stl03 = sprintf('%s%s', stl_path, 'glass04.stl');
p06 = keotoko_patch(keotoko_stl01, keotoko_stl02, keotoko_stl03);  % 毛男
gomi_kari = [p01 p02 p03 p04 p05 p06];
reducepatch(p01, 1000);
reducepatch(p02, 1000);
reducepatch(p03, 1000);

% ごみを配置
% 疑似乱数なので普通にやったらmatlab開いてからの回数で出る数が完全に同じになる
rng('shuffle');  % 上を防ぐため現在時刻に基づいてシードを初期化する
basho01 = chirigomi_dist(p01, 0);
basho02 = chirigomi_dist(p02, 200);
basho03 = chirigomi_dist(p03, 0);
basho04 = chirigomi_dist(p04, 150);
basho05 = chirigomi_dist(p05, 150);
basho06 = chirigomi_dist(p06, 150);
gbasho_kari = [basho01 basho02 basho03 basho04 basho05 basho06]
gomi = YourHandleClass();
gbasho = YourHandleClass();
for i=1:length(gomi_kari)
    gomi.lis_enque(gomi_kari(i));
    gbasho.lis_enque(gbasho_kari(:, i));
end

% 塵
chiri = YourHandleClass();
cbasho = YourHandleClass();
chiridata_path = 'chiridata/';
f = readmatrix(sprintf('%schiri_f.txt', chiridata_path));
v = readmatrix(sprintf('%schiri_v.txt', chiridata_path));
v = v.*10;
for i = 1:1000
    p = patch('Faces', f, 'Vertices', v, 'FaceColor', rand(1, 3), 'EdgeColor', 'none');
    chiribasho = chirigomi_dist(p, 0);
    chiri.lis_enque(p)
    cbasho.lis_enque(chiribasho)
end

% 竜巻を生成
a = 200;
bairitsu = 1/2;
[tatsu,cn,cpn] = t_seisei(a, 2, bairitsu, 0, 0, 0);

% 竜巻の微動を制御
% 以下の四つはリストとして使う想定
xdata_natural = YourHandleClass();  % 円の中心のずれがない場合(自然体)の座標を想定
ydata_natural = YourHandleClass();
xshift = YourHandleClass();  % 自然体からの円の中心のずれを想定
yshift = YourHandleClass();
% 初期化
posx = get(tatsu, 'XData'); 
posy = get(tatsu, 'YData'); 
xdata_natural.lis_update(posx);
ydata_natural.lis_update(posy);
xshift.lis_update(zeros(1, cn));
yshift.lis_update(zeros(1, cn));

% y = 0に目盛りを生成
grid_len = 10000/2;
make_grid(grid_len, grid_len, 400, 400);

grid on;

% 得点
score = YourHandleClass();                     
score_box = annotation('textbox', [0.83 0.9 0.15 0.05], ...
    'String', sprintf('Score: %d', score.value), ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 14, ...
    'FontWeight','bold', ...
    'Color', [1 0 1], ...        
    'BackgroundColor', [1 1 1 0.1], ...
    'EdgeColor', [0 0 0]);

% 時間
time01 = YourHandleClass();
time_box = annotation('textbox', [0.01 0.9 0.1 0.05], ...
    'String', sprintf('時間: %d', time01.value), ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 14, ...
    'FontWeight','bold', ...
    'Color', [1 0 1], ...        
    'BackgroundColor', [1 1 1 0.1], ...
    'EdgeColor', [0 0 0]);

hold off;

% 軸の初期設定
axis equal;  
hanni = grid_len*4;  % 描画する範囲
xlim([-hanni hanni])
ylim([-hanni hanni])
zlim([0, a*6/5])
xlabel('x');
ylabel('z');
zlabel('y');

% 3Dビューの設定
view([0 -a*bairitsu*8 a*2]);
[~, cel] = view();
% カメラをズーム
camzoom(60/a*hanni/100)
camproj('perspective');  % 透視投影らしいけどなんも変わらん
% camproj('orthographic');

% 物体に近づいたときのためのタイマー
% fixedspasingにする
t2 = timer('ExecutionMode', 'fixedSpacing', 'period', .5);
t2.StartDelay = 5;
t2.TimerFcn = @(~, ~) ...
    chirigomi_chikazuku(tatsu, chiri, cbasho, gomi, gbasho, score, score_box);
start(t2);

% 竜巻を常に前進させる
% periodを小さくしすぎると不具合出るので注意
% ippo:ハンドルオブジェクト。valueは歩幅、lisは座標の配列として扱う
ippo_chokushin = 20;
ippo = YourHandleClass(ippo_chokushin);
ippo.lis_update(zeros(2, 3));
kankaku = .05;  % kankaku変数。timer_kansuの呼び出し間隔を決めている。プログラムが重い場合は大きくする
% kankaku = .08;
t = timer('ExecutionMode', 'fixedrate', 'period', kankaku);
t.TimerFcn = @(~, ~) ...
    timer_kansu(tatsu, ippo_chokushin, ippo, cn, cpn, xdata_natural, ydata_natural, xshift, yshift, t, kankaku, time01, time_box);
t.StopFcn = @(~, ~) ...
    timer_stop_kansu(score);

% キーを押したときに呼び出す関数
magaru_bairitsu = 3/4;
ippo_magaru = ippo_chokushin*magaru_bairitsu;
w_flag = YourHandleClass();
fig.KeyPressFcn = @(~, data) ...
    key_press(data, w_flag, ippo_magaru, ippo, t);

% キーを離したときに呼び出す関数
fig.KeyReleaseFcn = @(~, data) key_release(data, w_flag, ippo_chokushin, ippo);

pause(5);  % 吸い込めるようになるまで少し時間が掛かるので止める
start(t);  % timerスタート