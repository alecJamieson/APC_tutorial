   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DYNAMIC CAUSAL MODELLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear DCM

basepath = '/data/netapp01/work/alecj/APC_tutorial/Data';

id = {'sub-01'
'sub-02'
'sub-03'
'sub-04'
'sub-05'
'sub-06'
'sub-07'
};

for i = 1:length(id)
    curr_id = id(i);
 
    subject_num = i;
          
    new_id = strcat(basepath, curr_id, '/1st_level');  

    sav_id = strcat(new_id, '/DCM_Files');
   
    data_path = char(new_id);
   
    save_path = char(sav_id);
   cd(data_path)
   mkdir('DCM_Files')
  
% SPECIFICATION DCM 
%--------------------------------------------------------------------------
% To specify a DCM, you might want to create a template one using the GUI
% then use spm_dcm_U.m and spm_dcm_voi.m to insert new inputs and new
% regions. The following code creates a DCM file from scratch, which
% involves some technical subtleties and a deeper knowledge of the DCM
% structure.

load(fullfile(data_path,'SPM.mat'));

load(fullfile(data_path,'VOI_R_Amygdala_1.mat'),'xY');
DCM.xY(1) = xY;
load(fullfile(data_path,'VOI_L_Amygdala_1.mat'),'xY');
DCM.xY(2) = xY;
load(fullfile(data_path,'VOI_R_dlPFC_1.mat'),'xY');
DCM.xY(3) = xY;
load(fullfile(data_path,'VOI_L_dlPFC_1.mat'),'xY');
DCM.xY(4) = xY;


DCM.n = length(DCM.xY);      % number of regions
DCM.v = length(DCM.xY(1).u); % number of time points

% Time series
%

DCM.Y.dt  = SPM.xY.RT;
DCM.Y.X0  = DCM.xY(1).X0;
for i = 1:DCM.n
    DCM.Y.y(:,i)  = DCM.xY(i).u;
    DCM.Y.name{i} = DCM.xY(i).name;
end

DCM.Y.Q    = spm_Ce(ones(1,DCM.n)*DCM.v);

% Experimental inputs

DCM.U.dt   =  SPM.Sess.U(1).dt;
DCM.U.name = [SPM.Sess.U.name];
DCM.U.u    = [SPM.Sess.U(1).u(33:end,1) ...
              SPM.Sess.U(2).u(33:end,1)];

DCM.delays = repmat(SPM.xY.RT/2,DCM.n,1);
DCM.TE     = 0.030;

DCM.options.nonlinear  = 0;
DCM.options.two_state  = 0;
DCM.options.stochastic = 0;
DCM.options.centre    = 1;
DCM.options.induced    = 0;

% A, B and C matrix specification
%-------------------------------------------------------------------------
DCM.a = [1,1,1,0; 1,1,0,1; 1,0,1,1; 0,1,1,1];
DCM.b = zeros(4,4,2); DCM.b(1,2,2) = 1; DCM.b(2,1,2) = 1; DCM.b(1,3,2) = 1; DCM.b(3,1,2) = 1; DCM.b(4,3,2) = 1; DCM.b(3,4,2) = 1; DCM.b(4,2,2) = 1; DCM.b(2,4,2) = 1;
DCM.c = [1 0; 1 0; 0 0; 0 0];
DCM.d = zeros(4,4,0);

save(fullfile(save_path,'DCM_model.mat'),'DCM');

clear DCM
end