clear all 
% sõlmede tähistused
 %1007->1
 %1029->2
 %1038->3
 %1035->4
 %1009->5
S = [1 1 2 2 2 3 3 3 4 5 5];
T = [2 3 3 4 1 2 4 1 5 1 4];
Weights = [42 70 28 125 42 28 97 70 122 5 122];
G = digraph(S,T,Weights);
%p=plot(G,'EdgeLabel',G.Edges.Weight)
% plot(G)


% Klassi Node kasutamine
maxOoteaeg=25;

%L=length(inputNodeArr);

missionNr=0;
while true
    missionNr=missionNr+1;
    if(missionNr==1)   % lähteandmete kompleks 1, mission 1
        startNode=Node(1,0,1,0);
        node2=Node(2,1,1,10);
        node3=Node(3,1,0,10);
        inputNodeArr = [node2, node3];
        outputNode=Node(4,1,1,0);
        washNode=Node(5,1,0,0);
    elseif(missionNr==2)   % lähteandmete kompleks 2, mission 2
        startNode=Node(1,0,1,0);
        node2=Node(2,1,0,10);
        node3=Node(3,1,1,10);
        inputNodeArr = [node2, node3];
        outputNode=Node(4,1,1,0);
        washNode=Node(5,1,0,0);
    elseif(missionNr==3) % lähteandmete kompleks 3, mission 3
        startNode=Node(1,0,1,0);
        node2=Node(2,1,1,15);
        node3=Node(3,1,1,10);
        inputNodeArr = [node2, node3];
        outputNode=Node(4,1,1,0);
        washNode=Node(5,1,0,0);
    elseif(missionNr==4)% lähteandmete kompleks 4, mission 4
        startNode=Node(1,0,1,0);
        node2=Node(2,1,1,10);
        node3=Node(3,1,1,15);
        inputNodeArr = [node2, node3];
        outputNode=Node(4,1,1,0);
        washNode=Node(5,1,0,0);
    elseif(missionNr==5) % lähteandmete kompleks 5, mission 5
        startNode=Node(1,0,1,0);
        node2=Node(2,1,0,10);
        node3=Node(3,1,0,10);
        inputNodeArr = [node2, node3];
        outputNode=Node(4,1,1,0);
        washNode=Node(5,1,0,0);
    else 
        break;
    end
    
    activeNode=startNode;
    fprintf(1,'\nMissionNr: %d',missionNr);
    Optimalpath(1)=activeNode.NodeNr;
    
  if activeNode.NodeNr==1   
     if outputNode.Maha==1 % teele saab minna kui on kuhu pealevõetud kaup maha panna
         indPeale=0;       % index of node with Peale=1 ()
         countPeale=0;        % total number of input nodes where Peale =1
         indmaxOoteaeg=0;  % maxOoteajaga sõlme index
         for i=1:length(inputNodeArr)
             if inputNodeArr(i).Peale==1
                indPeale=i;
                countPeale=countPeale+1;
             end   
             
         end
         if countPeale==1 
             % goto node nr: find to take boxes  (exist 1 node with Peale=1)
             if (inputNodeArr(indPeale).Maha==1) &&(activeNode.Peale==1)
                 % võtame aktiivsest node-st tühjad kastid peale ja liigume sõlme
                 % inputNodeArr(find), paneme kastid  maha
                
             else
                 % liigume tühjalt node: inputNodeArr(find)
             end
              activeNode=inputNodeArr(indPeale);
              Optimalpath(2)=activeNode.NodeNr;
       % liikuda node inputNodeArr(find) ->  outputNode , panna kastid maha
              activeNode=outputNode;
              Optimalpath(3)=activeNode.NodeNr;
         elseif countPeale>1  % mitmes sõlmes on kaupa peale võtta
             % minna kaste võtma inpotNode, kus Ooteaeg on suurim
             maxOoteaeg=inputNodeArr(1).Xaeg;
             indMaxOoteaeg=1;
             for i=2:length(inputNodeArr)  % leiame max ooteajaga kauba
               if inputNodeArr(i).Xaeg>maxOoteaeg;
                   indMaxOoteaeg=i;     
               end                
             end
             
             
             if (inputNodeArr(indMaxOoteaeg).Maha==1) &&(activeNode.Peale==1)
                % võtame solmest activeNode kastid ja viime sõlme
                % inputNodeArr(indMaxOoteaeg), paneme maha
             else
                 % Liigime tühjalt sõlme: inputNodeArr(indMaxOoteaeg)
             end
             activeNode=inputNodeArr(indMaxOoteaeg);
              Optimalpath(2)=activeNode.NodeNr;
                % Liigume sõlmest inputNodeArr(indmaxOoteaeg)sõlme outputNode, paneme maha  
             activeNode=outputNode;
              Optimalpath(3)=activeNode.NodeNr;
         end       
     end 
  end    
  
  if (washNode.Maha==1)  % tühjade kastide viimise variandid
     if (countPeale==0) && (outputNode.Peale==1)
         if(activeNode.Peale==0)
            % liigume tühjalt sõlmest 1 sõlme 4 kaste peale võtma (lühim tee)
            activeNode=outputNode;
        %    activeNode=washNode;
         else
             % võtame  sõlmest 1 kastid peale ja liigume sõlme 4
         indMaha=0;       % index of node with Maha=1 
         countMaha=0;        % total number of input nodes where Maha=1
         indShortest=0;
         pathLength=1000;
         
         for j=1:length(inputNodeArr)
             if inputNodeArr(j).Maha==1
                indMaha=j;
                countMaha=countMaha+1;
             end            
             [sp1,d1]=shortestpath(G,activeNode.NodeNr,inputNodeArr(j).NodeNr);
             [sp2,d2]=shortestpath(G,inputNodeArr(j).NodeNr,outputNode.NodeNr);
             d=d1+d2;
             if (pathLength>d)
                 pathLength=d;
                 indShortest=j;
             end
         end
          if countMaha==1 
             % liigume aktiivsest sõlmest sõlme  inputNodeArr(indMaha),
             % paneme kastid maha,liigume edasi sõlme outputNode 
               activeNode=inputNodeArr(indMaha);
               activeNode=outputNode;
          elseif countMaha>1    
             % liigume aktiivsest sõlmest sõlme  inputNodeArr(indShortest),
             % paneme kastid maha,liigume edasi sõlme outputNode 
              activeNode=inputNodeArr(indShortest);
              activeNode=outputNode;
          elseif countMaha==0
              activeNode=outputNode;  % liigume tühjalt sõlmest 1 sõlme 4 tühje kaste peale võtma    
          end
          
         end
     end
 
   end 
  % kastide etteviimine massiivi on tegemisel
  
  if activeNode.NodeNr==outputNode.NodeNr
    if (activeNode.Peale==1) && (washNode.Maha==1)
        % vta määrdunud kastid peale liigu 4->5
    end
    if activeNode.Peale==0
       % liigu 4->5  
    end
  activeNode=washNode;
  Optimalpath(4)=activeNode.NodeNr;
  end
  if activeNode.NodeNr==washNode.NodeNr;
      activeNode=startNode; 
      Optimalpath(5)=activeNode.NodeNr;
  end
 

  Optimalpath
  figure(missionNr)
  p=plot(G,'EdgeLabel',G.Edges.Weight);  % säilib viimase andmekomplekti graafik
  highlight(p,Optimalpath,'EdgeColor','r','LineWidth',1.5)
  
  % fprintf(1,'\nOptimalpath: %d',Optimalpath);
end  % while end




