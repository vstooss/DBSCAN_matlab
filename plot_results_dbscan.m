function tb_plot_dbscan(X, IDX)
    
    k=unique(IDX);
    Colors=hsv(length(k(k~=0)));
    Legends = {};
    for i=1:length(k)
        Xi=X(IDX==k(i),:);
        if k(i)>0
            Style = 'x';
            MarkerSize = 8;
            Color = Colors(i,:);
            Legends{end+1} = ['Cluster #' num2str(k(i))];
        elseif k(i) == -1
            Style = 'x';
            MarkerSize = 6;
            Color = Colors(i,:);
            if ~isempty(Xi)
                Legends{end+1} = 'Noise';
            end
        else
            Style = 'o';
            MarkerSize = 6;
            Color = [0 0 0];
            Legends{end+1} = 'Undefined';
        end
        if ~isempty(Xi)
            plot(Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
        end
        hold on;
    end
    hold off;
    axis equal;
    grid on;
    legend(Legends);
    legend('Location', 'NorthEastOutside');
end

