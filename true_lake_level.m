[NUM,TXT,RAW]=xlsread('Historic_Lake_Levels','Historic_Lake_Levels','A3966:B6141');
LakeLevel(:,1) = datenum(RAW(:,2),'MM/DD/YYYY');
LakeLevel(:,2) = NUM(:,1);