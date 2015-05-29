%ComputeJointDistribution Computes the joint distribution defined by a set
% of given factors
%
%   Joint = ComputeJointDistribution(F) computes the joint distribution
%   defined by a set of given factors
%
%   Joint is a factor that encapsulates the joint distribution given by F
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%

function Joint = ComputeJointDistribution(F)

  % Check for empty factor list
  if (numel(F) == 0)
      warning('Error: empty factor list');
      Joint = struct('var', [], 'card', [], 'val', []);      
      return;
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% Compute the joint distribution defined by F
% You may assume that you are given legal CPDs so no input checking is required.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (numel(F) == 1)
   Joint    = F;
end

%  OPTION 1
% G = F(1);
% for j = 2:numel(F)
%    jVar         = union(G.var, F(j).var);
%    [~, mapFj]   = ismember(F(j).var, jVar);
%    [~, mapG]    = ismember(G.var, jVar);
% 
%    % Set the cardinality of variables in G
%    jCard          = zeros(1, length(jVar));
%    jCard(mapFj)   = F(j).card;
%    jCard(mapG)    = G.card;
%    
%    % Set a value storer
%    jVal           = zeros(1, prod(jCard));
%    
%    % Find the correct indices and assignments
%    assignments   = IndexToAssignment(1:numel(jVal), jCard);
%    indxFj        = AssignmentToIndex(assignments(:, mapFj), F(j).card);
%    indxG         = AssignmentToIndex(assignments(:, mapG), G.card);
%    
%    % Compute product
%    jVal   = F(j).val(indxFj) .* G.val(indxG);
%    
%    % Assign
%    G = struct('var', jVar, 'card', jCard, 'val', jVal); 
%    
% end

%  OPTION 2

G = struct('var', [], 'card', [], 'val', []); 
for j = 1:numel(F)
   G   = FactorProduct(G, F(j));
end
% -----------------------

% Normalise
G.val   = G.val/sum(G.val);

% Assign to return variable
Joint = G;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

