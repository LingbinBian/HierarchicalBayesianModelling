#!bin/bash
# K, W, n,  

mkdir Data/synthetic_n1
for i in `seq -w 1001 1100`; do   
    mkdir Data/synthetic_n1/$i 
done

mkdir Global_fitting_thres_synthetic/infer_synthetic_K6_W20_n1.7783
for i in `seq -w 1001 1100`; do    
    mkdir Global_fitting_thres_synthetic/infer_synthetic_K6_W20_n1.7783/$i 
done

mkdir Local_inference_thres_synthetic/n1.7783
mkdir Local_fitting_thres_synthetic/n1.7783