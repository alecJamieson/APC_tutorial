   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create GCM file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear GCM

basepath = '/data/netapp01/work/alecj/APC_tutorial/';

id = {'sub-01'
'sub-02'
'sub-03'
'sub-04'
'sub-05'
'sub-06'
'sub-07'
};

DCM_Files = {'DCM_model.mat'};

for i = 1:length(id)
    curr_id = id{i}; % Use curly braces {} to access cell elements

    subject_num = i;

    for d = 1:length(DCM_Files)
        curr_file = DCM_Files{d}; % Use curly braces {} to access cell elements
        DCM_path = strcat(basepath, 'Data/', curr_id, '/1st_level/DCM_Files/', curr_file); 
        GCM{i,1} = strrep(DCM_path, '''', ''); % Remove apostrophes using strrep
    end  
end
save(fullfile(basepath,'GCM_negative_face.mat'),'GCM');
