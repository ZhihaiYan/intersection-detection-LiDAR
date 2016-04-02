function [velo_sample,x1,y1,rot_m  ] = GetROI( velo_sum,Way_Node_1,Way_Node_2,w,h  )

x1 = Way_Node_1(2);
y1 = Way_Node_1(1);
x2 = Way_Node_2(2);
y2 = Way_Node_2(1);
rot = atan2(y2-y1,x2-x1);
rot_m = [cos(rot) sin(rot) 0 0;-sin(rot) cos(rot) 0 0;0 0 1 0;0 0 0 1];
velo_sample =[];

for j=1:length(velo_sum)
    velo_sum{j}(:,1) = velo_sum{j}(:,1) - y1;
    velo_sum{j}(:,2) = velo_sum{j}(:,2) - x1;
    velo_sum{j} = velo_sum{j}*rot_m;
    iid = find(velo_sum{j}(:,2)>0 & velo_sum{j}(:,2)<h & velo_sum{j}(:,1)>-w/2 & velo_sum{j}(:,1)<w/2);
    velo_sample = [velo_sample;velo_sum{j}(iid,1) velo_sum{j}(iid,2) velo_sum{j}(iid,3)];
end
    

end

