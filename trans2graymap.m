function [ G] = Atrans2graymap( G)

G(isnan(G)) = 0;
Dim1 = size(G,1); Dim2 = size(G,2);
Gs = reshape(G,1,Dim1*Dim2);
Gs = sort(Gs);
Gmax = Gs(round(Dim1*Dim2*0.9995));
G = round(G/(Gmax)*254);
G = uint8(G);

end

