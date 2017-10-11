% mots visuels
M = 1e3;
% nombre des examples
N = 50e3;
[X,norms] = randomSampling('./descriptors3/');
T = 100;
centers = [];
best_error = 10e100;
for i=1:T
    [temp_centers, errors] = kmeans(X,M);
    final_error = errors(end);
    if final_error < best_error
        final_error
        best_error=final_error;
        centers = temp_centers;
    end
end
save('./visual_dico.mat','centers');

