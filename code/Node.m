classdef Node
   properties
      NodeNr
      Maha
      Peale
      Xaeg
   end
methods
   function nd = Node(nodenr,maha,peale,xaeg) 
         nd.NodeNr = nodenr;
         nd.Maha = maha;
         nd.Peale = peale;
         nd.Xaeg=xaeg;
   end 
    
    function disp(nd)
      fprintf(1,...
         'NodeNr: %d\nKastid Maha: %d\nKastid peale: %d\n',...
         nd.NodeNr,nd.Maha,nd.Peale);
    end 
   
  end
end





