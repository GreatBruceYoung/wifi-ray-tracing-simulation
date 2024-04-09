% Data acquisiton
clear all;clc

%% 基于射线跟踪技术生成仿真环境
if ~exist('radio_map_20_15.mat', 'file') %如果还没有生成仿真环境
    disp('正在模拟射线跟踪...');
    generate_radio_map(0.01);  % 仿真射线网格大小
end

clc
clear;
load radio_map_20_15.mat; 
%变量为fingerprint %默认尺寸为20m*15m*10ap，网格大小为0.01m
%注意：这里的仿真环境（fingerprint）是一个精度很高的指纹库，后面从这个仿真环境中进行取样（采集数据）并生成用于定位的指纹库。

%% 获取离线指纹库
% 生成离线指纹数据
[~, pos] = get_offline_data_uniform(fingerprint,100); %均匀采样
pos=pos/100; 
for i=1:length(pos)
    DB(i).pos=pos(i,:);
    DB(i).rss=[];
end
time=120; % collection time (unit: s)
for i=1:time
    [offline_rss, ~] = get_offline_data_uniform(fingerprint,100); %均匀采样
    for j=1:length(pos)
        temp=DB(j).rss;
        temp=[temp;offline_rss(j,:)];
        DB(j).rss=temp;
    end
end
save("data\simulated_train_data.mat","DB");
%% 获取在线定位阶段的数据
%前面默认的数据集的密度是0.01m，这样的话整个仿真系统的位置最小分辨率为0.01m，trace总是0.01的整数倍
roomLength = 20;
roomWidth = 15;
t = 10000;
[ loc, rss ] = get_online_data( fingerprint, 0.1, roomLength, roomWidth, t ); %得到轨迹与对应的RSS
loc=loc/10;
save("data\simulated_test_data.mat","loc",'rss');