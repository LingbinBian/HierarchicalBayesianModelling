#!/bin/bash
# if you can not find the commond circos: (1) bin/circos should add to export (2) PATH=~/software/circos/current/bin:$PATH (3) . ~/.bash_profile
# if you can not find the commond circos: (1) under directory circos-0.69: bin/circos -modules (2) pwd (2) export PATH=~/software/circos/current/bin:$PATH (3)export PATH=pwd/bin:$PATH(4) . ~/.bash_profile


cd Hierarchical/real/LR/sparsity_10/circos_configuration/brain
for t in 41 76 107 140 175 206 239 278 306 334 375; do 
   cd circos_t$t;
   circos -conf circos_t$t.conf;
   cd ..
done

cd ../../../..

