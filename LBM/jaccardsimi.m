function [jaccard_similarity]=jaccardsimi(a,b)


% Calculate the intersection of the two sets
intersection = length(intersect(a,b));

% Calculate the union of the two sets
uni = length(union(a,b));

% Calculate Jaccard similarity
jaccard_similarity = intersection / uni;
end