classdef YourHandleClass < handle
% matlabはアドレスを直接弄ることができない？から代わりにこれでやる
% handleを使うためのクラスであって特定の何かを代表しているわけではないはず
    properties
        value
        lis  % リスト想定
    end
    methods
        function obj = YourHandleClass(num)
            if nargin == 0
                obj.value = 0;
            else
                obj.value = num;
            end
            obj.lis = [];
        end
        function value_add(obj, num)  % objはpythonでいうselfみたいな？
            obj.value = obj.value + num;
        end
        function value_update(obj, num)
            obj.value = num;
        end
        function lis_enque(obj, lis2)
            obj.lis = [obj.lis lis2];
        end
        function lis_update(obj, lis2)
            obj.lis = lis2;
        end
        function lis_add(obj, val)
            obj.lis = obj.lis + val;
        end
        function ele_delete(obj, num)
            obj.lis(:, num) = [];
        end
        function ele_update(obj, num, col)
            obj.lis(:, num) = col;
        end
    end
end

