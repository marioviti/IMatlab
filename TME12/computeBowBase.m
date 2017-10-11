
addpath('descripteurs');
addpath('bow');
addpath('k-means');

% A REMPLACER AVEC LE DOSSIER CONTENANT LES DESCRIPTEURS SIFT 
pathsift = './descriptors3/';

% A REMPLACER AVEC LE DOSSIER CONTENANT LES DESCRIPTEURS BOW 
pathdes = './descriptors_bow/';

% A REMPLACER AVEC LE DOSSIER CONTENANT LES DICO 
baseDirDico = './visual_dico.mat';

load(baseDirDico);
clusters = centers;
matNormClusters = sum(clusters.^2,2);

cate = categories();
catinit = 1;
catend =15;

for index=catinit:catend
    cat = cate{index};
    % CREATION DU DOSSIER DESCRIPTEURS POUR LA CLASSE SI INEXISTANT
    pathcat = strcat(pathdes,cat,'/');
    if(exist(pathcat)==0)
        mkdir(pathcat);
    end
    
    tstarttot= tic;

    direc = strcat(pathsift,cat,'/');
    listima=dir([direc '*.mat'] );
    n=length(listima);
    
    % CALCUL DES DESCRIPTEURS POUR LA CLASSE INDEX 
    for num=1:n
        % OUVERTURE  IMAGE
        % I = imread(strcat(direc,listima(num).name));
        
        % load sifts
        load(strcat(direc,listima(num).name));
        
        % CALCUL DES BOW (VOTRE FONCTION)
        [bow,nc] = computeBow(sifts,clusters,matNormClusters);
        % bow = bow';
     
        % STOCKAGE DES BOW
        desname = strcat(pathcat,listima(num).name(1:length(listima(num).name)-4),'.mat');
        
        save(desname,'bow');
        
        if(mod(num,100)==0)
            strcat('nb patchs=',num2str(size(sifts,2)))
            tcal = toc(tstarttot);
            strcat('temps de calcul =',num2str(tcal))
        end
    end    
    tcaltot = toc(tstarttot);
    strcat('computation time for category :',cat,' =',num2str(tcaltot))
end
