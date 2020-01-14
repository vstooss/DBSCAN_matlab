function [IDX]=lib_dbscan(X,epsilon,MinPts)
    
       
    C=0;
    
    n=size(X,1);
    IDX=zeros(n,1);
    
    D=pdist2(X,X);
    
    for i=1:n
        if IDX(i) == 0
                       
            Neighbors=RegionQuery(i);
            if numel(Neighbors)<MinPts
                % X(i,:) is NOISE
                IDX(i) = -1;
            else
                C=C+1;
                ExpandCluster(i,Neighbors,C);
            end
            
        end
 
    end
    
    function ExpandCluster(i,Neighbors,C)
        IDX(i)=C;
        
        k = 1;
        while true
            j = Neighbors(k);
            if IDX(j) == -1
                IDX(j) = C;
            end
            if IDX(j) == 0
                IDX(j)=C;
                Neighbors2=RegionQuery(j);
                if numel(Neighbors2)>=MinPts
                    Neighbors=[Neighbors Neighbors2];   %#ok
                end
            end
                      
            k = k + 1;
            if k > numel(Neighbors)
                break;
            end
        end
    end
    
    function Neighbors=RegionQuery(i)
        Neighbors=find(D(i,:)<=epsilon);
        Neighbors=Neighbors(Neighbors~=i); % exclude current point as its own neighbor
    end

end

