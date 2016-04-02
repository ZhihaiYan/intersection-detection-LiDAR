clear all;
load('Data\Node.mat');
load('Data\OSM.mat');
load('Data\Pose.mat');
%% Parameters
x_min=-40;x_max=40;y_min=-40;y_max=40;
inter_search_width_v = 20;
inter_search_width_h = 30;

for i=1:1:160
    figure(1);grid on;
    
    %% OSM transform
    dx = Origin_x(i) - Origin_x(1);
    dy = Origin_y(i) - Origin_y(1);
    dh = Heading(i) - Heading(1);
    [Node_x_t,Node_y_t] = Node_Transform(Node_x,Node_y,dx,dy,dh);
    Node_x_t = Node_x_t(2:end);
    Node_y_t = Node_y_t(2:end);
    if i< 120
        continue;
    end
    filename = ['Data/Velo_Sum/' num2str(i) '.mat'];
    load(filename);
    %% Find The Front Interection
    [ Inter_Node,Way_Node_1,Way_Node_2 ] = FindInterection (Node,Way,Node_x_t,Node_y_t,inter_search_width_v,inter_search_width_h);
    
    %% Extract ROI
    for k=2:1:size(Way_Node_1,1)
       [velo_sample,s_x,s_y,rot_m ] = GetROI( velo_sum,Way_Node_1(k,:),Way_Node_2(k,:),60,60);
       [Center_x,Center_y] = GetEntrance(velo_sample,rot_m,s_x,s_y);
       plot(Center_x,Center_y,'r','LineWidth',2);
       hold on;
    end         
    
    %% Plot pointcloud
    for j=1:length(velo_sum)
        plot(velo_sum{j}(:,2),velo_sum{j}(:,1),'.','color',[0 0.6 1.0],'MarkerSize',4);
        hold on;
    end
    
    axis([x_min x_max y_min y_max]);
    xlabel('x (m)','FontName','Times New Roman')
    ylabel('y (m)','FontName','Times New Roman')
    hold off;
    
    pause(0.05);
    
end