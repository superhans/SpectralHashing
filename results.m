video_id = [1, 10, 11, 12, 13, 14, 15, 2,3,4,5,6,7,8,9];
returned = [27, 21, 73, 41, 11, 17, 68, 51, 8, 73, 44, 76, 48, 45, 9];
actual = [27, 21, 37, -1, 11, 17, 68, -1, 8, -1, 44, 76, -1, -1, 9];
n_hashes = [16763, 13293, 14803, 17643, 28226, 49279, 92138, 6608, 11535, 9140, 23800, 9584, 4227, 15838, 18303];
n_matches_first = [192, 48, 19, 13, 532, 421, 1291, 11, 354, 16, 264, 21, 9, 25, 1846 ];
n_matches_second = [17, 22, 19, 13, 18, 23, 57, 11, 20, 14, 22, 17, 9, 21, 18];
% correctness = [1, -1, 1, -1, 1, 1, -1, -1, 1, 1, 0, -1, 1, 1,1]
correctness = [1, 1, 0, -1, 1, 1, 1, -1, 1, -1, 1, 1, -1, -1, 1]
% confidence = [1, 0, 0, 0, 1, ]

[video_id' (n_matches_first./n_hashes)' correctness' (n_matches_first./n_matches_second)']
crit1 = (n_matches_first./n_matches_second)';
crit2 = (n_matches_first./n_hashes)';
% precision : TP/(TP+FP)
% recall : TP/(TP+FN)

t1 = [0:0.5:102];
t2 = [0:0.001:0.4];
c = zeros(15,1);

for j=1:size(t2,2)
	tp = 0;fp=0;fn = 0;
	for i=1:15 
		if(crit2(i) < t2(j) )
			returned(i) = -1;
		end

		% true positive
		if(returned(i) == actual(i) && returned(i) > 0)
			tp = tp + 1;
		end

		if(returned(i) ~= actual(i) && returned(i) > 0)
			fp = fp + 1;
		end

		if(returned(i) < 0 && actual(i) > 0)
			fn = fn + 1;
		end
	end

	precision(j) = tp/(tp+fp);
	recall(j) = tp/(tp+fn);

end

returned = [27, 21, 73, 41, 11, 17, 68, 51, 8, 73, 44, 76, 48, 45, 9];
actual = [27, 21, 37, -1, 11, 17, 68, -1, 8, -1, 44, 76, -1, -1, 9];


for j=1:size(t1,2)
	tp = 0;fp=0;fn = 0;
	for i=1:15 
		if(crit1(i) < t1(j) )
			returned(i) = -1;
		end

		% true positive
		if(returned(i) == actual(i) && returned(i) > 0)
			tp = tp + 1;
		end

		if(returned(i) ~= actual(i) && returned(i) > 0)
			fp = fp + 1;
		end

		if(returned(i) < 0 && actual(i) > 0)
			fn = fn + 1;
		end
	end

	precision2(j) = tp/(tp+fp);
	recall2(j) = tp/(tp+fn);

end

hold on;
plot(recall,precision,'r-*');
plot(recall2,precision2,'b-o');
axis([0 1.2 0 1.2]);
xlabel('recall');
ylabel('precision');

% ST1Query1 movie27
% ST1Query2 not_in_db
% ST1Query3 movie8
% ST1Query4 not_in_db
% ST1Query5 movie44
% ST1Query6 movie76
% ST1Query7 not_in_db
% ST1Query8 not_in_db
% ST1Query9 movie9
% ST1Query10 movie21
% ST1Query11 movie37
% ST1Query12 not_in_db
% ST1Query13 movie11
% ST1Query14 movie17
% ST1Query15 movie68
