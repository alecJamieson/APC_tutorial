basepath = '/data/netapp01/work/alecj/APC_tutorial/';
GCM_file = 'GCM_negative_face';

%Default = Full + BMR; 2 = Full + BMR PEB
peb_option = 1;

% Load the GCM of filenames
load([basepath, GCM_file]);

% Convert filenames -> DCMs
GCM = spm_dcm_load(GCM);

% Iteratively fit using PEB
if peb_option == 2
    GCM = spm_dcm_peb_fit(GCM);
    save_file = [basepath, GCM_file, '_estimated_PEB.mat'];
else
    GCM = spm_dcm_fit(GCM);
    save_file = [basepath, GCM_file, '_estimated_no_PEB.mat'];
end
    
% Save
save(save_file, 'GCM');