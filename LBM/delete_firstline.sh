#!/bin/bash

# This script deletes the first line of the node.txt and connectivity.txt

cd Hierarchical/real/LR/sparsity_10

for t in 41 76 107 140 175 206 239 278 306 334 375; do 

 sed '1d' circos_node_v_t$t.txt >> circos_brain_network/circos_brain_node_t$t.txt;
 sed '1d' circos_connectivity_in_v_t$t.txt >> circos_brain_network/circos_brain_connectivity_in_t$t.txt;
 sed '1d' circos_connectivity_out_v_t$t.txt >> circos_brain_network/circos_brain_connectivity_out_t$t.txt;
  
done

cd ../..

