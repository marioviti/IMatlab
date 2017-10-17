function [heat_map,nc] = test_heatmap_prediction(I, sift, visual_dico, ws, indcat)
    nc = assignementKMeans( double(sift') , visual_dico );
    heat_map = compute_prediction_heatmap( I, nc, ws(indcat,:)');
end

