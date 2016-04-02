function [ Inter_Node,Way_Node_1,Way_Node_2 ] = FindInterection( Node,Ways,Node_x,Node_y,inter_search_width_v,inter_search_width_h )

Way_Node_1_x = [];
Way_Node_2_x = [];
Way_Node_1_y = [];
Way_Node_2_y = [];

Node_y = -Node_y;
index = find(Node_y > -inter_search_width_h & Node_y < inter_search_width_h & Node_x > -10 & Node_x < inter_search_width_v & Node(:,4)'>=3);
Inter_Node = [Node_x(index)' Node_y(index)'];

for i=1:1:length(index)
    [k,j] = find(Node(index(i),3) == Ways);
    for n=1:length(k)
        Way_Node_1_x = [Way_Node_1_x Node_x(index(i))];
        Way_Node_1_y = [Way_Node_1_y Node_y(index(i))];
        if j(n)>=2
           id = Ways(k(n),j(n)-1);
        else
           id = Ways(k(n),j(n)+1);
        end
        ind = find(Node(:,3) == id);
        Way_Node_2_x = [Way_Node_2_x Node_x(ind)];
        Way_Node_2_y = [Way_Node_2_y Node_y(ind)];    
    end
end
Way_Node_1 = [Way_Node_1_x' Way_Node_1_y'];
Way_Node_2 = [Way_Node_2_x' Way_Node_2_y'];

end

