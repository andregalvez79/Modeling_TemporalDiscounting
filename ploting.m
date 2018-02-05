ks = 0.001:0.001:0.03;
optimk = zeros(length(ks),1);

for k = 1:length(ks)
    optimk(k) = findK(ks(k));
end

plot(ks,optimk)
