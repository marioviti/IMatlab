function [centers] = computeVisualDico(pathsrc,K,initializations,eps,epochs)
    if nargin==1
        K = 1e3;
        eps = 1e-3;
        epochs = 1000;
        initializations = 10;
    end
    N = 50e3;
    [X,~] = randomSampling(pathsrc,N);
    [~,n_features] = size(X);
    centers = [];
    best_error = 10e100;
    for i=1:initializations
        [temp_centers, errors] = kmeans(X,K,eps,epochs);
        final_error = errors(end);
        if final_error < best_error
           best_error=final_error;
            centers = temp_centers;
            best_error
        end
     end
   
    % add null point
    centers = [centers;zeros(1,n_features)];
end

