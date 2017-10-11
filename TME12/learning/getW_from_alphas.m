function [w,b] = getW_from_alphas(model)
    b = model.Bias;
    svms = model.SupportVectors;
    alphas = model.Alpha;
    [n_svm,k] = size(svms);
    w = alphas(1)*svms(1,:);
    for i=2:n_svm
        w = w + alphas(i)*svms(i,:);
    end
end

