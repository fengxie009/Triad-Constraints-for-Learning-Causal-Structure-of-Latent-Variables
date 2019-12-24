
-------------------------------------------------------------------------------

BASIC INFO

Name of the pack: 	NG2P (LSTC algorithm)


Version:	0.0 (26 October 2019)
Version:	1.0 (24 December 2019)

What it does:	 Learning Causal Structure of Latent Variables for Non-Gaussian Two-Pure Linear Latent Structure Model.
		See the details in the following paper:
			Ruichu Cai*, Feng Xie*, Clark Glymour, Zhifeng Hao, Kun Zhang. Triad Constraints for Learning Causal Structure of Latent Variables. NeurIPS 2019


Requirements:	Matlab 

-------------------------------------------------------------------------------

USAGE

Main code files:

NG2P_Main.m		-the main function for learning the causal structure of latent variables 

-------------------------------------------------------------------------------

Independent Test(KCI)

This package is the KCI code package, which is modified by Kun Zhang and Jonas Peters.
Goal: To test if x and y are independent with bootstrap (which is the same as in HSIC test) or with the finite-sample Gamma approximation.

we use the UInd_KCItest.m to test the independence of any two variables,
available from 

http://people.tuebingen.mpg.de/kzhang/KCI-test.zip

Note: in order to ensure the accuracy of the independent test, one can adjust some parameters, like kernel width, in the UInd_KCItest.m.

For convenience, this code is supplied as part of this package, so there
should be no need for you to separately download this code. 

One may also directly use the original HSIC code package,
available from

http://www.gatsby.ucl.ac.uk/~gretton/indepTestFiles/indep.htm

Gretton, A., K. Fukumizu, C.-H. Teo, L. Song, B. Schoelkopf and A. Smola: A kernel Statistical test of independence. NIPS 21, 2007.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

Kernel Mutual Information

We use the Kernel Independent Component Analysis package to calculate the mutual information.
available from

https://www.di.ens.fr/~fbach/kernel-ica/index.htm

For convenience, this code is supplied as part of this package, so there
should be no need for you to separately download this code.
Francis R. Bach, Michael I. Jordan. Kernel Independent Component Analysis, 
Journal of Machine Learning Research, 3, 1-48, 2002. 
-------------------------------------------------------------------------------

---
Updated 24 December 2019
Feng Xie 
xiefeng009@gmail.com

-------------------------------------------------------------------------------
