function [ center_x,center_y ] = GetEntrance( velo_sample,rot_m,s_x,s_y )

x_min=-15;x_max=15;y_min=0;y_max=40;
resolution = 1;

X = [];Y = [];V = [];
X = [X velo_sample(:,1)'];
Y = [Y velo_sample(:,2)'];
V = [V velo_sample(:,3)'];

X = (X - x_min)/resolution;
Y = (Y - y_min)/resolution;
X_Size = round((x_max-x_min)/resolution);
Y_Size = round((y_max-y_min)/resolution);
[Xq,Yq] = meshgrid(0:1:X_Size,1:1:Y_Size);

Vq = griddata(X,Y,V,Xq,Yq,'natural');

[Gx,Gy] = gradient(Vq);
Gx = abs(Gx);Gy = abs(Gy);
G = sqrt(Gx.^2 + Gy.^2);

[G] = trans2graymap(G);
feat = double(reshape(G,1,size(G,1)*size(G,2)));
feat = feat/255.0;


load('Model\h_model.mat');
[head, accuracy, dec_values] = svmpredict(0, sparse(feat), model_max);
load('Model\b_model.mat');
[bias, accuracy, dec_values] = svmpredict(0, sparse(feat), model_max);
center_x = 8:0.5:40;
k = tan(head);
center_y = k.*center_x + bias;
points = [center_y' center_x' zeros(length(center_x),1) zeros(length(center_x),1)];
points = points * inv(rot_m);
center_x = points(:,2);
center_y = points(:,1);
center_x = center_x + s_x;
center_y = center_y + s_y;

end

