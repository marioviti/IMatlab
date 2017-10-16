function [ hmap ] = compute_prediction_heatmap( I , nc , ws )
    size(ws)
    r = denseSampling(I,16,8);
    hmap = 0;
    size(r)
end

