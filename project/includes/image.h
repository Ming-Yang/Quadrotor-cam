#ifndef _IMAGE_H
#define _IMAGE_H

#include <opencv2/core/core.hpp>
#include <opencv2/calib3d/calib3d.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#include <iostream>
#include <vector>
#include <iomanip>
#include <stdio.h>
#include <stdlib.h>
//#include <mouse.h>

using namespace cv;

extern Mat cameraMatrix1, cameraMatrix2, distCoeffs1, distCoeffs2, OM, R, T;
extern Mat Rl, Rr, Pl, Pr, Q;
extern Mat lmap1, lmap2, rmap1, rmap2;
extern Mat cam_img1, cam_img2;
extern Mat raw_img1, raw_img2;
extern Mat remap_img1, remap_img2;
extern Mat trans_img;
extern Mat BM_out_img ,BM_norm_out_img ;
extern Size imsize;
extern Mat bw_img, contours_bw_img;
extern vector< vector<Point> > contours, contours_tiny ;
extern vector<Point> merge_points;
extern vector < vector<Point> > merge_obstacle;
extern Point center;




bool ReadPara(const char*);
void PrintMat(Mat, const char*);
bool PreImageGet(const char*, const char*);
bool RectifyCorrespondence();
void saveDisp(const char*, const Mat&);
Point3i ObstacleCheck(int, int,float,float);
void StereoParaCal();
Point FindCentre();
Point myPointPolygonTest(InputArray, Point2f, bool);

#endif
