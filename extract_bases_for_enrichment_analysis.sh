

# This creates bed files with the desired flanking base pairs

bedtools flank -l 0 -r 500 -s -i bedfiles/181130TSS_single_bp_prox.bed\
    -g genome_files/SK1_PacBio_spikes.genome.fa.fai\
    > bedfiles/proxdown500.bed
    
bedtools flank -l 0 -r 500 -s -i bedfiles/181130TSS_single_bp_all.bed\
    -g genome_files/SK1_PacBio_spikes.genome.fa.fai\
    > bedfiles/alldown500.bed

bedtools flank -l 50 -r 0 -s -i bedfiles/181130TSS_single_bp_prox.bed\
    -g genome_files/SK1_PacBio_spikes.genome.fa.fai\
    > bedfiles/proxup50.bed
    
bedtools flank -l 50 -r 0 -s -i bedfiles/181130TSS_single_bp_all.bed\
    -g SK1_PacBio_spikes.genome.fa.fai\
    > bedfiles/allup50.bed
    
    
# Extract out the information in the .bw file from the regions designated by the inputted bed file

for f in chromatin_mods_FE_files/*.bw
do	
    foo=${f#chromatin_mods_FE_files/}
	prefix=${foo%_diffbind_narrow_FE.bw}
	echo "Running $prefix"
	bwtool extract bed bedfiles/proxdown500.bed $f ${prefix}-proxdown500.txt
    mv ${prefix}-proxdown500.txt chromatin_mods_FE_files/down500/prox/
    bwtool extract bed bedfiles/alldown500.bed $f ${prefix}-alldown500.txt
    mv ${prefix}-alldown500.txt chromatin_mods_FE_files/down500/all/
    bwtool extract bed bedfiles/proxup50.bed $f ${prefix}-proxup50.txt
    mv ${prefix}-proxup50.txt chromatin_mods_FE_files/up50/prox/
    bwtool extract bed bedfiles/allup50.bed $f ${prefix}-allup50.txt
    mv ${prefix}-allup50.txt chromatin_mods_FE_files/up50/all/
done
exit 