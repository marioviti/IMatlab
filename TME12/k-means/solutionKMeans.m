% init aleatoire de données jouet

clear all;
close all;
clc;

X = rand(100, 2);
C = randomSeed(X, 4);

plot(X(:,1), X(:,2), '.')
hold on
plot(C(:,1), C(:,2), 'o')

% assignation aux clusters
%
% 1. calcul de la distance entre X et C
% 2. recuperation de l'argmin pour chaque xi
% fonctions utiles:
% - repmat(x, 1, n) fait n copies en colonnes de x
% - [min_val, min_arg] = min(X, [], 2) fourni les valeurs et arguments min
%    pour chaque ligne de X
% - sqrt(sum(X.^2, 2)) calcule un vecteur contenant la norme de chaque
%    ligne de X

% TODO
for test = 1 : 5
    normec = sum(C.^2, 2);
  
    V = 2 * X * C';
    for i = 1 : 100 
        W(i,:) = normec';
    end
    dist = W - V; 
    [minimum argmin] = min(dist');

    argmin = argmin';
    
    sommeX = 0;
    sommeY = 0;
    
    for j = 1 : 4  
        iteration = 0;
        for i = 1:100
            if argmin(i,:) == j 
                sommeX = X(i,1) + sommeX;
                sommeY = X(i,2) + sommeY;
                iteration = iteration+1;
            end
            if iteration > 0 
                newX = sommeX / iteration;
                newY = sommeY / iteration;
            end 
        end     
        C(j,1) = newX;
        C(j,2) = newY;
    end
    
nc = round(rand(100, 1) * 3) + 1 % a remplacer bien sur

end
% affichage des point avec 1 couleur par cluster
for i = 1:4
    plot(X(nc == i, 1), X(nc == i, 2), '.')
end

%recalcul des centres
%
% pour chaque cluster:
% 1. calcul du centre
% 2. calcul de l'erreur (variance intra-cluster)
% 3. cacul de la distance entre l'ancien et le nouveau centre
%
% fonction utile:
% - X(nc == i, :) retourne les points qui appartiennent au cluster i

% TODO
C_new = randomSeed(X, 4); % a remplacer

% affichage des nouveaux centres et de leur deplacement
plot(C_new(:,1), C_new(:,2), 's')
for i = 1:size(C, 1)
    plot([C(i,1); C_new(i,1)], [C(i,2); C_new(i,2)], 'b-')
end

% iterer
%
% mettre le code ci dessus dans 2 fonctions, iterer, regarder les centres
% se deplacer. une fois le code fonctionnel, le mettre dans une fonction
% solutionKMeans

% TODO



