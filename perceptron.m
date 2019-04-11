function perceptronAlgo
X_T=[0,1;
    0.45,0.89; 
    0.35, 0.94;
    0,1;
    0.73, 0.69;
    0.66, 0.75;
    0.77, 0.64;
    0.71, 0.71
];

X=X_T'
Y=[-1;-1;-1;-1;+1;+1;+1;+1];

N=size(X_T,1);
num_features = size(X_T,2);
w=zeros(num_features,1);
b = 0;
maxIter=3;
for iter=1:maxIter
  for n=1:N
    x=X(:,n)
    y_pred = w'*x
    y=Y(n,1);
    if (y_pred*y<=0) 
      w=w+y*x;
      
    end
 end

end
endfunction

