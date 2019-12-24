# Triad-Constraints-for-Learning-Causal-Structure-of-Latent-Variables

Learning the causal structure of latent variables for linear non-Gaussian data.



## **Main Function**

function [G,Name] = NG2P_Main(X,alpha)

**Input:**

- X: M*N matrix, where M is the number of variables and N is the sample size.
- alpha: significance level of the independence test.

**Output:**

- G: connected matrix to represent recovered graph structure (including observed and latent variables).
- Name: the name of variables in G.

See more details in the README.txt.

## Test Example

One may use the Test_NG2P_Main.m to test our method.



### Notes

Our method relies heavily on independence tests, one can adjust some parameters, like kernel width, in the UInd_KCItest.m of the Package KCI, to ensure the accuracy.



### CITATION

If you use this code, please cite the following paper:

Cai, Ruichu, Feng Xie, Clark Glymour, Zhifeng Hao, and Kun Zhang. "Triad Constraints for Learning Causal Structure of Latent Variables." In *Advances in Neural Information Processing Systems*, pp. 12863-12872. 2019.

If you have problems or questions, do not hesitate to send an email to xiefeng009@gmail.com.
