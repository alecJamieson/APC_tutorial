%-----------------------------------------------------------------------
% Job saved on 01-Sep-2023 10:52:54 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7487)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
basepath = '/data/netapp01/work/alecj/APC_tutorial/';
GCM_file = 'GCM_negative_face';
save_file = [basepath, GCM_file, '_estimated.mat'];

%Default = Full + BMR; 2 = Full + BMR PEB
peb_option = 1;

% Load the GCM of filenames
load([basepath, GCM_file]);

% Convert filenames -> DCMs
GCM = spm_dcm_load(GCM);

% Iteratively fit using PEB
if peb_option == 2
    GCM = spm_dcm_peb_fit(GCM);
else
    GCM = spm_dcm_fit(GCM);
end
    
% Save
save(save_file, 'GCM');