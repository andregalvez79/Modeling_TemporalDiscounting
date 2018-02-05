% Provided a certain k for simulating choices, this function return the k
% that minimizes errors for subjects that have preferences according to a
% logit destribution with unit variance

function [x,y] = findK(k)
%%%%%%%%%%%%%%%%%%%%%%%%%
% READING IN DATA %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Questionnaire Data
% Four columns:
% 1. Order 
% 2. SIR (small immediate reward) 
% 3. LDR (large delayed reward) 
% 4. Delay
% By Chabris/Laibson 2008
% LDR (large delayed reward) // coded as 1
% SIR (small immediate reward) // coded as 0
qdat = readtable('pptest.csv');

len = length(qdat.LDR);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     DEFINE OBJECTIVE FUNCTION         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sumloglik = GenerateLogLik(cur_k)
    % Define vector that will store the probability that the model chooses
    % as the participant for every choice
   choiceprobabilities = zeros(length(qdat.Choices),1);
   
   for j = 1:len
       % load the choice probability vector for every choice
    choiceprobabilities(j) = GetPChoice(cur_k,qdat.SIR(j),qdat.LDR(j),qdat.Delay(j),qdat.Choices(j));
   end
   
   % take sum of logs and negative to be able to work within minimization
   % framework
   sumloglik = (-1)*(sum(log(choiceprobabilities)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RECOVER K WHEN HAVING SET OF CHOICES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run minimization to find k-value
[x, y] = fminbnd(@GenerateLogLik,0,1);
end

