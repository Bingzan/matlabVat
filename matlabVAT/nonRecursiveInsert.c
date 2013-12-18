#include "mex.h"

/*  Input Arguments */
#define F_IN    prhs[0]
#define S_IN    prhs[1]
#define T_IN    prhs[2]
#define Fo_IN   prhs[3]
#define Fi_IN   prhs[4]

/*  Output Arguments    */
#define F_OUT   plhs[0]
#define S_OUT   plhs[1]
#define T_OUT   plhs[2]
#define Fo_OUT  plhs[3]

void nonRecursiveInsert(int mNewMst[], double mNewDis[], int mNewExist[], int vNewRoot, 
        double mDis, int vExist[], double vNewR[], int mMst[], int mExist[])
{
    //vSum = sum(mMst);
    //[~,rootVert] = min(vSum);
    
    int insertedVert;
    insertedVert = mxGetM(mMst) +  1;
    
    mNewMst = insert(mDis,vExist,vNewR,mMst,insertedVert,rootVert);
    
    mNewExist = mExist;
    mNewDis = mDis;
    
    return;
}

void insert(int mNewMst, 
        double mDis[], int vExist[], double vNewR[], int mMst[], int insertedVert, int rootVert)
{
    
}

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray*prhs[] )
{
    int *mNewMst, *mNewExist, *vExist, *mMst, *mExist;
    double *mNewDis, *mDis, *vNewR;
    int *vNewRoot;
    size_t mDism, mDisn, vExistm, vExistn, vNewRm, vNewRn, mMstm, mMstn;
    
    if (nrhs != 5){
        mexErrMsgInAndTxt("MATLAB:nonRecursiveInsert:invalidNumInputs", "Five input arguments required");
    }else if (nlhs > 5){
        mexErrMsgInAndTxt("MATLAB:nonRecursiveInsert:maxlhs", "Too many output arguments");
    }
    
    mDism = mxGetM(F_IN)+1;
    mDisn = mxGetN(F_IN)+1;
    
    vExistm = mxGetM(S_IN)+1;
    vExistn = mxGetN(S_IN)+1;
    
    //vNewRm = mxGetM(T_IN);
    //vNewRn = mxGetN(T_IN);
    
    mMstm = mxGetM(Fo_IN)+1;
    mMstn = mxGetN(Fo_IN)+1;
    
    F_OUT = mxCreateDoubleMatrix((mwSize)mMstm, (mwSize)mMstn, mxREAL);
    S_OUT = mxCreateDoubleMatrix((mwSize)mDism, (mwSize)mDisn, mxREAL);
    T_OUT = mxCreateDoubleMatrix((mwSize)vExistn, (mwSize)vExistn, mxREAL);
    
    mNewMst = mxGetPr(F_OUT);
    mNewDis = mxGetPr(S_OUT);
    mNewEixst = mxGetPr(T_OUT);
    
    mDis = mxGetPr(F_IN);
    vExist = mxGetPr(S_IN);
    vNewR = mxGetPr(T_IN);
    mMst = mxGetPr(Fo_IN);
    mExist = mxGetPr(Fi_IN);
    
    nonRecursiveInsert(mNewMst, mNewDis, mNewExist, vNewRoot, 
        mDis, vExist, vNewR, mMst, mExist)
    
    return;
}

