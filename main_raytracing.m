%�������ڷ��滷���У��õ�����ָ�ƿ⣬�Լ����߽׶εĲ������ݣ������Ժ�Ķ�λ���ԡ�

%% �������߸��ټ������ɷ��滷��
if ~exist('radio_map_20_15.mat', 'file') %�����û�����ɷ��滷��
    disp('����ģ�����߸���...');
    generate_radio_map(0.01);  % �������������С
end

clc
clear;
load radio_map_30_30.mat; 
%����Ϊfingerprint %Ĭ�ϳߴ�Ϊ20m*15m * 10ap�������СΪ0.01m
%ע�⣺����ķ��滷����fingerprint����һ�����Ⱥܸߵ�ָ�ƿ⣬�����������滷���н���ȡ�����ɼ����ݣ����������ڶ�λ��ָ�ƿ⡣

%% ��ȡ����ָ�ƿ�
%���Ҫ�о�ָ�ƿ⹹���ϵ��Ż������ⲿ�ָĽ�
[offline_rss, offline_location] = get_offline_data_uniform(fingerprint,100); %���Ȳ���
offline_location=offline_location/100; 
idx=[1:1:length(offline_location)]';
offline_location=[offline_location,idx];
save('offline_data_uniform', 'offline_rss', 'offline_location');
[offline_rss, offline_location] = get_offline_data_random(fingerprint); %�������
offline_location=offline_location/100;
save('offline_data_random', 'offline_rss', 'offline_location');

%% ��ȡ���߶�λ�׶ε�����
%ǰ��Ĭ�ϵ����ݼ����ܶ���0.01m�������Ļ���������ϵͳ��λ����С�ֱ���Ϊ0.01m��trace����0.01��������
roomLength = 30;
roomWidth = 30;
t = 1000;
[ loc, rss ] = get_online_data( fingerprint, 1, roomLength, roomWidth, t ); %�õ��켣���Ӧ��RSS
save('online_data', 'loc', 'rss');
%%
clear fingerprint;