#Integer linear programming module for optimization
## Measure time preformance
time_performance(6).what = 'Integer Linear Programming Optimization';
time_performance(6).id = tic;
#Structure of data for optimization

#optimdata = struct(...
#                   'number_of_clients',[],... 
#                   'number_of_potential_sites',[],... 
#                   'number_of_facilities_to_open',[],... 
#                   'base_candidates',[]...
#                   );

number_of_clients = [stats(:).no_pts];
base_candidates = [[data.base(:).londec]',[data.base(:).latdec]']               
number_of_potential_sites = length(base_candidates);
number_of_facilities_to_open = 4;                  

#Create distance matrix MxN where M is the dimension of potential sites
#and N is the dimension of clients

for i=1:number_of_potential_sites
    dx_client_site(:,i) = abs(x_sim{1,1}.-base_candidates(i,1)); 
    dy_client_site(:,i) = abs(y_sim{1,1}.-base_candidates(i,2));
    dist_client_site(:,i) = sqrt(dx_client_site(:,i).^2+dy_client_site(:,i).^2);
endfor

#Create facility establishing cost vectorize
fac_estab_cost = repmat([1],1,number_of_potential_sites);

#Preparing glpk input: objective function coefficients
c=reshape(dist_client_site,1,prod(size(dist_client_site)));
c=cat(2, fac_estab_cost, c);

######## A Matrix
#Initialize 1st constraint matrix
A1 = zeros(number_of_clients(1),length(c));

#1st constraint, every client satisfied
for i=1:number_of_clients(1)
    for j=1:number_of_potential_sites
        A1(i,number_of_potential_sites+i+(j-1)*number_of_clients(1)) = 1;
    endfor
endfor

#Initialize 2nd constraint matrix
A2 = zeros(number_of_clients(1).*number_of_potential_sites,length(c));

#2nd set of constraints, clients served from an open facility
for i=1:number_of_clients(1)
    for j=1:number_of_potential_sites
        A2(i+(j-1)*number_of_clients(1),j) = 1;
        A2(i+(j-1)*number_of_clients(1),number_of_potential_sites+i+(j-1)*number_of_clients(1)) = [-1];
    endfor
endfor

#Initialize 3rd constraint matrix
A3 = zeros(1,length(c));

#3rd constraint, only number_of_facilities_to_open facilities may be open
A3(1,1:number_of_potential_sites) = 1;

########## B Vector
#1st constraint, right hand side and ctype
B1 = repmat([1],1,number_of_clients(1));
ctype1 = repmat(['S'],1,number_of_clients(1));

#2nd constraint, right hand side and ctype
B2 = repmat([0],1,number_of_clients(1).*number_of_potential_sites);
ctype2 = repmat(['L'],1,number_of_clients(1).*number_of_potential_sites);

#3rd constraint, right hand side and ctype
B3 = [number_of_facilities_to_open];
ctype3 = ['S'];

#Merge A1..3 and B1...3
A = cat(1,A1,A2,A3);
B = cat(2,B1,B2,B3);
ctype = cat(2,ctype1,ctype2,ctype3);

#An array containint the lower bound on each of the variables
lb = repmat([0],1,length(c));

#An array containint the upper bound on each of the variables
ub = repmat([1],1,length(c));


#A column array containing the types of the variables
vartype = repmat(["I"],1,length(c));

#If sense is 1, the problem is a minimization,
#if sense is -1, the problem is a maximization
sense = 1;

#A structure containint parameters used to define the behavior of solver
param.msglev = 3; #full output

#Full glpk arg list
#[xopt, fmin, errnum, extra] = glpk (c,A,b,lb,ub,ctype,vartype,sense, param)
[xopt, fmin, errnum, extra] = glpk (c,A,B,lb,ub,ctype,vartype,sense,param)

#Make solution more readable
base_idx=find(xopt(1:number_of_potential_sites));
x_solution=zeros(size(dist_client_site));
x_solution=reshape(xopt(1+number_of_potential_sites:end),size(dist_client_site));
for i=1:number_of_potential_sites
    action_idx{i}=find(x_solution(:,i));
endfor

time_performance(6).duration = toc(time_performance(6).id);

