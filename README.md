#Epigenetics_workflow

**Worflow for epigenetics methylation analysis whithout a reference genome**

**WARNING**

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.


## Documentation

Note that **ALL** the scripts must be launched from the root folder **rna-seq_mapping_workflow/**
### 1. Clone git hub directory

```
git clone https://github.com/jleluyer/epigenetics_workflow
```

### 2. Import data

```
cp /path/to/the/data/repository/*.gz 02_data
```

### 3. Trimming the data

First you need to change the userID and userEmail for your proper info in **./00_scripts/colosse-jobs/01_trimmomatic_pe.sh**

Then launch:

```
sbatch 00_scripts/katak-jobs/01_trim_galore.sh
```

You may also want to check the quality of your data prior to trimming using **00_scripts/utility_scripts/fastq.sh**. This will require to have **fastQC** installed in your **$PATH**.

### 4. Create reference catalog

* Launch Ustacks

```
sbatch 00_scripts/02_ustacks_jobs.sh
```

* Launch Cstacks

```
sbatch 00_scripts/03_cstacks_jobs.sh
```

**Note: prior to launch the scripts, you will need to adapt the values (-M, -m and -N and -n, for ustacks and cstacks, respectively)**

### 5. Mapping

* Prepare reference genome

```
sbatch 00_scripts/04_prepare_reference.sh
```

* Index reference

```
sbatch 00_scripts/05_bismark_index.sh
```

* Mapping on reference genome

```
sbatch 00_scripts/06_bismark_align.sh
```

### 6. Methylation calls

```
sbatch 00_scripts/07_bismark_CpG_extractor.sh
```

### 7. Downstream analysis

##### 7.1 SNPs calling

**Import BS-SNPer**
```
git clone https://github.com/hellbelly/BS-Snper
cd BS-Snper-master
sh BS-Snper.sh
```
**launch BS-SNPer**

```
sbatch 00_scripts/11_bssnper.sh
```

## Notes

## Dependencies

### Softwares

[Bismark](http://www.bioinformatics.babraham.ac.uk/projects/index.html)

[Trim_galore!](http://www.bioinformatics.babraham.ac.uk/projects/index.html)

[FastQC](http://www.bioinformatics.babraham.ac.uk/projects/index.html)

[STACKS](http://catchenlab.life.illinois.edu/stacks/)

[BS-SNPer](https://github.com/hellbelly/BS-Snper)


## Licence


##Citations

F. Krueger, S. R. Andrews (2011). Bismark: a flexible aligner and methylation caller for Bisulfite-Seq applications [doi:  10.1093/bioinformatics/btr167](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3102221/)

J. M. Catchen, A. Amores, P. Hohenlohe. W.Cresko, J. H. Postlethwai (2011). Stacks: guilding and genotyping loci de novo from short-read sequences
[doi:  10.1534/g3.111.000240](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3276136/)

G. Shengjie, Z. Dan, M. Likai, et al. BS-SNPer: SNP calling in bisulfite-seq data. Bioinformatics, 2015, 31(24): 4006-4008.[doi:  10.1093/bioinformatics/btv507](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4673977/)

**_worflow in progress_**

*Contributors: Jeremy Le Luyer, Eric Normandeau, Madoka Krick*
