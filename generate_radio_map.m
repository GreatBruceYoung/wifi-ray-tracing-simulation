function fingerprint = generate_radio_map(grid_size)
% ���ɡ�RSS���滷�����ݼ���
% ���ص�fingerprint��һ����ά���飬��¼�������RSSֵ����һά�͵ڶ�ά�Ƿ���ĳߴ磬����ά����ͬ��AP��
    %% ��������
    if nargin == 0
        grid_size = 0.01;  % ������
    end
    room_x = 20;
    room_y = 15;
    room_z = 4;
    f = 2400; %�ź�Ƶ��
    % ����AP��λ��
    APs= 1 + 14 * rand(10, 2); % ����10�����AP
    % APs = [
    %     5, 3
    %     15, 1
    %     29, 1
    %     1, 29
    %     15, 29
    %     29, 29
    %     1,15
    %     15,15
    %     29,15
    %     12,24
    % ]; % ����10��AP
    %% ����fingerprint
    fingerprint = zeros(room_x / grid_size -1, room_y / grid_size -1, size(APs, 1));
    for i = 1 : size(APs, 1)
        source_x = APs(i, 1);
        source_y = APs(i, 2);
        source_z = 2; %Ĭ���ź�Դ�ĸ߶�Ϊ1m
        rss = get_rss_by_ray_tracing(room_x, room_y, room_z, source_x, source_y, source_z, grid_size, f); %�������߸��ټ���RSS
        fingerprint(:, :, i) = rss;
        figure;
        mesh(fingerprint(:, :, i));
    end
    save('radio_map_20_15', 'fingerprint');
end

