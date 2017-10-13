function [w,b] = getW_from_alphas(model,y)
    % bilinarietà sui kernel nel dual relazione alpha svm e w
    b = model.Bias;
    svms = model.SupportVectors;
    svms_index = model.SupportVectorIndices;
    alphas = model.Alpha;
    [n_svm,k] = size(svms);
    w = alphas(1)*svms(1,:);
    for i=2:n_svm
        w = w + alphas(i)*y(svms_index(i))*svms(i,:);
    end
end

