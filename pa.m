
function pa()
  [training_data,testing_data] = preprocessing();
   weights = training_model(0.1,10,training_data);
   testing_model(testing_data,weights);
endfunction



  #loading the dataset
function [training_data,testing_data ] = preprocessing()
    data = load("datafile.csv"); 
    #no of rows and features
    noOfRows = size(data,1);
    noOfFeatures = size(data,2)-2;
    #replacing class variables accordingly (2 is -1 and 4 is 1)
    for i=1:noOfRows,
      if(data(i,11) == 2)
        data(i,11) = -1;
      else
        data(i,11)= 1;
      endif
    endfor
    shuffled_data = data;
    #shuffled_data = data(randperm(noOfRows), :);
    #traning set
    training_data = shuffled_data(1:noOfRows*2/3,:);
    #testing_set
    testing_data = shuffled_data((noOfRows*2/3)+1:end,:);
    
endfunction 
 
function w = training_model(c,iterations,training_data)
  noOfTrainingData = size(training_data,1);
  featuresCount = size(training_data,2)-1;
  #feature set
  
  notHomo = training_data(:,[2:10]);
  homo = [notHomo ones(noOfTrainingData,1)];
  X = homo;
  #labels set
  Y = training_data(:,[11]);
  #initializing weight vector
  w = zeros(1,featuresCount);
  #Traning the model
  for j=1:iterations
    correct_predictions = 0;
    for k=1:noOfTrainingData
    x_t = X(k,:);
    y_pred= sign(w*x_t');
    y_t = Y(k,:);
    if(y_pred == y_t)
     correct_predictions = correct_predictions+1;
    endif
    l_t = max(0,1-y_t*(w*x_t'));
    n_t = norm(x_t)^2;
    #tau_t = l_t/n_t;
    tau_t = min(c,l_t/n_t);
    #tau_t = l_t/(n_t+(1/2*C));
    w = w + tau_t*y_t*x_t;
 endfor
 Taccuracy = correct_predictions/noOfTrainingData*100;
 printf('accuracy for %d ephocs is: %f \n',j,Taccuracy);
endfor
endfunction

function testing_model(testing_data,weights)
 #Testing the algorithm
 noOfTestingData = size(testing_data,1);
 xx_test = testing_data(:,[2:10]);
 #X_test = testing_data(:,[2:10]);
 X_test = [xx_test ones(noOfTestingData,1)];
 Y_test = testing_data(:,[11]);
 correct_predictions = 0;
  for z=1:size(X_test,1)
    x_tt = X_test(z,:);
    y_pred_t = sign(weights*x_tt');
    y_tt = Y_test(z,:);
    #disp([testing_data(z,1),y_tt,y_pred_t]);
    if(y_pred_t == y_tt)
      correct_predictions = correct_predictions+1;
    endif
  endfor
  printf("Accuracy for Testing dataset: %f \n",correct_predictions*100/size(X_test,1));
endfunction

 
 
 
  
    
    
    
   
   
 
 