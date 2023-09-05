% Specify PEB model settings- code sourced from https://en.wikibooks.org/wiki/SPM/Parametric_Empirical_Bayes_(PEB)
%Set up paths
basepath = '/data/netapp01/work/alecj/APC_tutorial/';
GCM_file = 'GCM_negative_face';
GCM_path = [basepath, GCM_file, '_estimated_no_PEB.mat'];

load(GCM_path);
N = size(GCM,1);

% The 'all' option means the between-subject variability of each connection will 
% be estimated individually
M   = struct();
M.Q = 'all'; 
M.beta = 16;
M.hE = 0;
M.hC = 0.0625;

% Specify design matrix for N subjects. It should start with a constant column
M.X = ones(N,1);

% Choose field
field = {'B'};

% Estimate model
PEB = spm_dcm_peb(GCM,M,field);

save([basepath,'PEB_group_level_estimated_together.mat'],'PEB');

% Search over nested PEB models.
BMA = spm_dcm_peb_bmc(PEB);

save([basepath,'BMA_search_PEB_group_level_estimated_together.mat'],'BMA');
spm_dcm_peb_review(BMA,GCM)