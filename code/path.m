 %1007->1
 %1029->2
 %1038->3
 %1035->4
 %1009->5
S = [1 1 2 2 2 3 3 3 4 5 5];
T = [2 3 3 4 1 2 4 1 5 1 4];
Weights = [42 70 28 125 42 28 97 70 122 5 122];
G = digraph(S,T,Weights);
p=plot(G,'EdgeLabel',G.Edges.Weight)
% plot(G)
startNode=1
endNode=5
[path1,d] = shortestpath(G,startNode,endNode)
highlight(p,path1,'EdgeColor','r','LineWidth',1.5)
% igas sõlmes peale=1 kui on mida peale võtta