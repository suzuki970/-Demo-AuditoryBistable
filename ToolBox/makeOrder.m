
function [orderArray count_numOftarget] = makeOrder(numOfCondition,lenArray,allowCont)

count_numOftarget = ones(1,numOfCondition);

orderArray = [];
for i = 1:lenArray
    
    while 1
        ind = randi([1,numOfCondition],1);
        if min(count_numOftarget) == max(count_numOftarget)
            
            orderArray = [orderArray;ind];
            count_numOftarget(ind) = count_numOftarget(ind)+1;
            break;
        end
        
        if min(count_numOftarget)+allowCont > count_numOftarget(ind)
            
            orderArray = [orderArray;ind];
            count_numOftarget(ind) = count_numOftarget(ind)+1;
            break;
        end
    end 
end

end

