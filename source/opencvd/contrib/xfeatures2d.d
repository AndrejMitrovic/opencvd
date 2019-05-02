/*
Copyright (c) 2019 Ferhat Kurtulmuş
Boost Software License - Version 1.0 - August 17th, 2003
Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:
The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
*/

module opencvd.contrib.xfeatures2d;

import opencvd.cvcore;

private extern (C){
    SIFT SIFT_Create();
    void SIFT_Close(SIFT f);
    KeyPoints SIFT_Detect(SIFT f, Mat src);
    KeyPoints SIFT_DetectAndCompute(SIFT f, Mat src, Mat mask, Mat desc);

    SURF SURF_Create();
    void SURF_Close(SURF f);
    KeyPoints SURF_Detect(SURF f, Mat src);
    KeyPoints SURF_DetectAndCompute(SURF f, Mat src, Mat mask, Mat desc);
}

struct _SIFT {
    void* p;
    
    void close(){
        SIFT_Close(&this);
    }
    
    KeyPoint[] detect(Mat src){
        KeyPoints kpts = SIFT_Detect(&this, src);
        KeyPoint[] ret = kpts.keypoints[0..kpts.length].dup;
        deleteArr(kpts.keypoints);
        return ret;
    }
    
    KeyPoint[] detectAndCompute(Mat src, Mat mask, Mat desc){
        KeyPoints kpts = SIFT_DetectAndCompute(&this, src, mask, desc);
        KeyPoint[] ret = kpts.keypoints[0..kpts.length].dup;
        deleteArr(kpts.keypoints);
        return ret;
    }
}

alias SIFT = _SIFT*;

SIFT newSIFT(){
    return SIFT_Create();
}

struct _SURF {
    void* p;
    
    void close(){
        SURF_Close(&this);
    }
    
    KeyPoint[] detect(Mat src){
        KeyPoints kpts = SURF_Detect(&this, src);
        KeyPoint[] ret = kpts.keypoints[0..kpts.length].dup;
        deleteArr(kpts.keypoints);
        return ret;
    }
    
    KeyPoint[] detectAndCompute(Mat src, Mat mask, Mat desc){
        KeyPoints kpts = SURF_DetectAndCompute(&this, src, mask, desc);
        KeyPoint[] ret = kpts.keypoints[0..kpts.length].dup;
        deleteArr(kpts.keypoints);
        return ret;
    }
}

alias SURF = _SURF*;

SURF newSURF(){
    return SURF_Create();
}
