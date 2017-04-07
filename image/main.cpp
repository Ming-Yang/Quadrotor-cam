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

#define _SHOW_RAW_IMG 0
#define _SHOW_PARA_IN 0
#define _SHOW_PARA_CAL 0
#define _SHOW_REC_IMG 0
#define _SHOW_OBSTACLE_IMG 0

using namespace cv;
using namespace std;

Mat cameraMatrix1, cameraMatrix2, distCoeffs1, distCoeffs2, OM, R, T;
Mat Rl, Rr, Pl, Pr, Q;
Mat lmap1, lmap2, rmap1, rmap2;
Mat cam_img1, cam_img2;
Mat raw_img1, raw_img2;
Mat remap_img1, remap_img2;
Mat trans_img;
Mat BM_out_img ,BM_norm_out_img ;
Size imsize;
Mat bw_img, contours_bw_img;
vector< vector<Point> > contours, contours_tiny ;
vector<Point> merge_points;
vector < vector<Point> > merge_obstacle(1);
Point center;

bool ReadPara(const char*);
void PrintMat(Mat, const char*);
bool PreImageGet(const char*, const char*);
bool RectifyCorrespondence();
void saveDisp(const char*, const Mat&);
Point3i ObstacleCheck(int, int,float,float);
void StereoParaCal();
void Init();
Point FindCentre();
Point myPointPolygonTest(InputArray, Point2f, bool);

int main()
{
	Init();
	while (RectifyCorrespondence());
	cout << ObstacleCheck(5000, 20, 10000, 300) << endl;

	cout << "ok" << endl;

	while (1);
	return 0;
}

void Init()
{
	cout << "begin..." << endl;
	while (ReadPara("../data/para.txt"));
	while (PreImageGet("../data/R3.jpg", "../data/L3.jpg"));
	StereoParaCal();

	while (RectifyCorrespondence());
	center = FindCentre();
	cout<<ObstacleCheck(5000, 20, 10000, 300)<<endl;

	cout << "ok" << endl;
}

Point3i ObstacleCheck(int obstacle_threshold,int point_num, float min_distance,float merge_distance)
{
	Point3i obs;
	threshold(BM_norm_out_img, bw_img, 0, 255, CV_THRESH_OTSU);

	contours_bw_img = bw_img.clone();
	findContours(contours_bw_img, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);

	contours_tiny.resize(contours.size());
	Mat contour_image(contours_bw_img.size(), CV_8U);
	Mat obstacle_image(contours_bw_img.size(), CV_8U);

	int contours_len = 0;
	double contours_area;

	for (int i = 0; i < (int)contours.size(); i++)
	{
		contours_area = fabs(contourArea(contours.at(i)));
		if ( contours_area > obstacle_threshold)
		{
			//试图减小动态容器，做标记
			contours_tiny[contours_len++] = contours[i];
		}
	}

	//识别障碍
	/*obstacle：z轴有效点距离和 有效点个数 平均距离*/
	Mat obstacle = Mat::zeros(contours_len,3, CV_32F);
	float depth;
	int obstacle_num;

	for (int num = 0, num_x_l = imsize.width-1, num_y_t = imsize.height-1, num_x_r =  0, num_y_e = 0; num < contours_len; num++)
	{
		for (int i = 0; i < contours_tiny[num].size(); i++)
		{
			if (contours_tiny[num][i].x < num_x_l)
			{
				num_x_l = contours_tiny[num][i].x;
			}
			if (contours_tiny[num][i].x > num_x_r)
			{
				num_x_r = contours_tiny[num][i].x;
			}
			if (contours_tiny[num][i].y > num_y_e)
			{
				num_y_e = contours_tiny[num][i].y;
			}
			if (contours_tiny[num][i].y < num_y_t)
			{
				num_y_t = contours_tiny[num][i].y;
			}
		}

		for (int pj = num_y_t; pj < num_y_e; pj = pj + (num_y_e - num_y_t)/ point_num)
		{
			for (int pi = num_x_l; pi < num_x_r; pi = pi + (num_x_r - num_x_l)/ point_num)
			{
				depth = trans_img.at<Vec3f>(pj, pi).val[2];
				if (pointPolygonTest(contours_tiny[num], Point2f(pi, pj), false) == 1
					&& depth > 0)
				{
					obstacle.at<float>(num, 0) += depth;
					obstacle.at<float>(num, 1)++;
				}
			}
		}
		num_x_l = imsize.width - 1, num_y_t = imsize.height - 1, num_x_r = 0, num_y_e = 0;
	}

	for (int temp = 0; temp < contours_len; temp++)
	{
		obstacle.at<float>(temp, 2) = obstacle.at<float>(temp, 0) / obstacle.at<float>(temp, 1);

		if (obstacle.at<float>(temp, 2) < min_distance)
		{
			min_distance = obstacle.at<float>(temp, 2);
			obstacle_num = temp;
		}
		//合并近处障碍，并做多边形拟合
		if (obstacle.at<float>(temp, 2) < merge_distance)
		{
			merge_points.insert(merge_points.end(), contours_tiny[temp].begin(), contours_tiny[temp].end());
		}
		
	}
	if (merge_points.size())
	{
		convexHull(merge_points, merge_obstacle[0], false);
		Point(obs.x, obs.y) = myPointPolygonTest(merge_obstacle[0], center, true);
	}
	else
	{
		obs.x = obs.y = 0;
	}
	
	obs.z = min_distance;
#if _SHOW_OBSTACLE_IMG
	for (int ii = 0; ii < contours_len; ii++)
	{
		int color;
		if (ii == obstacle_num)
			color = 100;
		else
			color = 170;
		drawContours(contour_image, contours_tiny, ii, color);
	}
	imshow("contour_image", contour_image);

	drawContours(obstacle_image, merge_obstacle,0,0);
	imshow("obstacle_image", obstacle_image);

	cout << obstacle_num << endl;
	PrintMat(obstacle, "obstacle");
	
	waitKey(0);
#endif // 最近的障碍物

	return obs;
}

bool RectifyCorrespondence()
{
	remap(raw_img1, remap_img1, lmap1, lmap2, INTER_LINEAR);
	remap(raw_img2, remap_img2, rmap1, rmap2, INTER_LINEAR);

	//匹配
	BM_out_img = Mat(imsize.height, imsize.width, CV_16S);
	BM_norm_out_img = Mat(imsize.height, imsize.width, CV_16S);

	StereoBM BMState(StereoBM::BASIC_PRESET, 256);
	BMState.state->preFilterType = CV_STEREO_BM_NORMALIZED_RESPONSE;
	BMState.state->preFilterSize = 21;
	BMState.state->preFilterCap = 63;

	BMState.state->SADWindowSize = 35;//
	BMState.state->minDisparity = 0;
	BMState.state->numberOfDisparities = 96;//

	BMState.state->textureThreshold = 3;
	BMState.state->uniquenessRatio = 12;//
	BMState.state->speckleWindowSize = 20;
	BMState.state->speckleRange = 32;

	BMState.state->disp12MaxDiff = -1;
	BMState.operator()(remap_img1, remap_img2, BM_out_img, CV_16S);

	normalize(BM_out_img, BM_norm_out_img, 0, 255, NORM_MINMAX, CV_8U);

	reprojectImageTo3D(BM_out_img, trans_img, Q, false, -1);
	
#if _SHOW_REC_IMG
	//saveDisp("../dispict.txt", trans_img);
	imshow("trans_img", trans_img);
	imshow("BM_out_img", BM_out_img);
	imshow("BM_norm_out_img", BM_norm_out_img);
	setMouseCallback("BM_norm_out_img", onMouse, reinterpret_cast<void*> (&trans_img));
	waitKey(0);
#endif // 矫正图像

	//匹配参数对照组
	//Mat BM_out_img2 = Mat(imsize.height, imsize.width, CV_16S);
	//StereoBM bm(StereoBM::BASIC_PRESET, 128, 7);
	//bm.state->preFilterType = CV_STEREO_BM_NORMALIZED_RESPONSE;
	//bm.state->preFilterCap = 63;
	//bm.state->SADWindowSize = 35;
	//bm.state->minDisparity = 0;
	//bm.state->numberOfDisparities = 96;
	//bm.state->textureThreshold = 3;
	//bm.state->uniquenessRatio = 10;
	//bm.state->speckleWindowSize = 20;
	//bm.state->speckleRange = 32;
	//bm.state->disp12MaxDiff = 1;
	//bm.operator()(remap_img1, remap_img2, BM_out_img2);
	//Mat BM_norm_out_img2 = Mat(imsize.height, imsize.width, CV_16S);
	//normalize(BM_out_img2, BM_norm_out_img2, 1, 256, NORM_MINMAX, CV_8UC1);
	//imshow("imageOut2", BM_norm_out_img2);
	return 0;
}

bool PreImageGet(const char *left_image, const char *right_image)
{
	//读入并转化为灰度
	raw_img1 = imread(left_image, IMREAD_GRAYSCALE);
	raw_img2 = imread(right_image, IMREAD_GRAYSCALE);

	//resize(cam_img1, raw_img1, Size(480, 360), 0, 0, INTER_AREA);
	//resize(cam_img2, raw_img2, Size(480, 360), 0, 0, INTER_AREA);

	//raw_img1 = cam_img1;
	//raw_img2 = cam_img2;

	if (raw_img1.size == raw_img2.size)
	{
		imsize.height = raw_img1.rows;
		imsize.width = raw_img1.cols;
	}
	else
	{
		printf("different image size\n");
		return 1;
	}

#if _SHOW_RAW_IMG
	printf("width:%d\nheight:%d\n", imsize.width, imsize.height);
	imshow("imageL", raw_img1);
	imshow("imageR", raw_img2);
	waitKey(0);
#endif // 显示图像
	
	return 0;
}

void StereoParaCal()
{
	stereoRectify(cameraMatrix1, distCoeffs1, cameraMatrix2, distCoeffs2, imsize, R, T,
		Rl, Rr, Pl, Pr, Q, CV_CALIB_ZERO_DISPARITY, -1);

#if _SHOW_PARA_CAL
	PrintMat(Rl, "Rl");
	PrintMat(Rr, "Rr");
	PrintMat(Pl, "Pl");
	PrintMat(Pr, "Pr");
	PrintMat(Q, "Q");
#endif // 矫正矩阵

	initUndistortRectifyMap(cameraMatrix1, distCoeffs1, Rl, Pl, imsize, CV_32F, lmap1, lmap2);
	initUndistortRectifyMap(cameraMatrix2, distCoeffs2, Rr, Pr, imsize, CV_32F, rmap1, rmap2);
}

Point FindCentre()
{
	float x_num =0, x_point=0, y_num=0, y_point = 0;
	bool flag;
	for (int i = 0; i < imsize.height; i++)
	{
		for (int j = 0; j < imsize.width; j++)
		{
			if (trans_img.at<Vec3f>(i, j).val[2] > 0)
			{
				//if(fabs(trans_img.at<Vec3f>(i, j).val[0]) < 1 && fabs(trans_img.at<Vec3f>(i, j).val[1]) < 1)
				//{
				//	x_num++;
				//	x_point += j;
				//	y_num++;
				//	y_point += i;
				//}
				//else
				{
					if (fabs(trans_img.at<Vec3f>(i, j).val[0]) < 1)
					{
						x_num++;
						x_point += j;
					}
					if (fabs(trans_img.at<Vec3f>(i, j).val[1]) < 1)
					{
						y_num++;
						y_point += i;
					}
				}
			}
		}
	}
	return Point((int)(x_point / x_num), (int)(y_point / y_num));
}

bool ReadPara(const char *filename)
{
	double camera1[9], camera2[9], dist1[5], dist2[5], r[9], om[3], t[3];
	FILE *fp = fopen(filename, "r");

	if (fp == NULL)
	{
		cout << "open file failed \n" << fp << endl;
		return 1;
	}

	fscanf(fp,
		"fc_left=[%lf,%lf]\n\
cc_left=[%lf,%lf]\n\
kc_left=[%lf,%lf,%lf,%lf,%lf]\n\
fc_right=[%lf,%lf]\n\
cc_right=[%lf,%lf]\n\
kc_right=[%lf,%lf,%lf,%lf,%lf]\n\
om=[%lf,%lf,%lf]\n\
T=[%lf,%lf,%lf]",
&camera1[0], &camera1[4],
&camera1[2], &camera1[5],
&dist1[0], &dist1[1], &dist1[2], &dist1[3], &dist1[4],
&camera2[0], &camera2[4],
&camera2[2], &camera2[5],
&dist2[0], &dist2[1], &dist2[2], &dist2[3], &dist2[4],
&om[0], &om[1], &om[2],
&t[0], &t[1], &t[2]
);

	camera1[1] = camera1[3] = camera1[6] = camera1[7] = 0;
	camera2[1] = camera2[3] = camera2[6] = camera2[7] = 0;
	camera1[8] = 1;
	camera2[8] = 1;

	cameraMatrix1 = Mat(3, 3, CV_64F, camera1).clone();
	cameraMatrix2 = Mat(3, 3, CV_64F, camera2).clone();
	distCoeffs1 = Mat(5, 1, CV_64F, dist1).clone();
	distCoeffs2 = Mat(5, 1, CV_64F, dist2).clone();
	OM = Mat(3, 1, CV_64F, om).clone();
	R = Mat(3, 3, CV_64F, r).clone();
	T = Mat(3, 1, CV_64F, t).clone();
	Rodrigues(OM, R);

#if _SHOW_PARA_IN
	PrintMat(cameraMatrix1, "cameraMatrix1");
	PrintMat(cameraMatrix2, "cameraMatrix2");
	PrintMat(distCoeffs1, "distCoeffs1");
	PrintMat(distCoeffs2, "distCoeffs2");
	PrintMat(R, "R");
	PrintMat(T, "T");
#endif // 参数矩阵

	return 0;
}

Point myPointPolygonTest(InputArray _contour, Point2f pt, bool measureDist)
{
	Point nearest_point;
	double result = 0;
	Mat contour = _contour.getMat();
	int i, total = contour.checkVector(2), counter = 0;
	int depth = contour.depth();
	CV_Assert(total >= 0 && (depth == CV_32S || depth == CV_32F));

	bool is_float = depth == CV_32F;
	double min_dist_num = FLT_MAX, min_dist_denom = 1;
	Point ip(cvRound(pt.x), cvRound(pt.y));

	const Point* cnt = contour.ptr<Point>();
	const Point2f* cntf = (const Point2f*)cnt;


	Point2f v0, v;
	Point iv;

	for (i = 0; i < total; i++)
	{
		double dx, dy, dx1, dy1, dx2, dy2, dist_num, dist_denom = 1;

		v0 = v;
		if (is_float)
			v = cntf[i];
		else
			v = cnt[i];

		dx = v.x - v0.x; dy = v.y - v0.y;
		dx1 = pt.x - v0.x; dy1 = pt.y - v0.y;
		dx2 = pt.x - v.x; dy2 = pt.y - v.y;

		if (dx1*dx + dy1*dy <= 0)
			dist_num = dx1*dx1 + dy1*dy1;
		else if (dx2*dx + dy2*dy >= 0)
			dist_num = dx2*dx2 + dy2*dy2;
		else
		{
			dist_num = (dy1*dx - dx1*dy);
			dist_num *= dist_num;
			dist_denom = dx*dx + dy*dy;
		}

		if (dist_num*min_dist_denom < min_dist_num*dist_denom)
		{
			min_dist_num = dist_num;
			min_dist_denom = dist_denom;
			nearest_point = v;
			if (min_dist_num == 0)
				break;
		}

		if ((v0.y <= pt.y && v.y <= pt.y) ||
			(v0.y > pt.y && v.y > pt.y) ||
			(v0.x < pt.x && v.x < pt.x))
			continue;

		dist_num = dy1*dx - dx1*dy;
		if (dy < 0)
			dist_num = -dist_num;
		counter += dist_num > 0;
	}


	if (counter % 2 == 0)
		return Point2f(0,0);
	else
		return Point2f(nearest_point.x- pt.x, nearest_point.y - pt.y);
}

void PrintMat(Mat matrix, const char* sting = 0)
{
	static int num = 0;
	if (*sting == 0)
		cout << "Matrix" << num++ << ":" << endl;
	else
		cout << sting << ":" << endl;

	for (int i = 0; i < matrix.rows; i++)
	{
		for (int j = 0; j < matrix.cols; j++)
		{
			switch (matrix.type())
			{
			case CV_64F:
				cout << setiosflags(ios::left) << matrix.at<double>(i, j) << "\t";
				break;
			case CV_32F:
				cout << setiosflags(ios::left) << matrix.at<float>(i, j) << "\t";
				break;
			case CV_16S:
				cout << setiosflags(ios::left) << matrix.at<int>(i, j) << "\t";
				break;
			default: cout << "wrong type" << endl;
				break;
			}
		}
		cout << endl;
	}
	cout << endl;

}

void saveDisp(const char* filename, const Mat& mat)
{
	FILE* fp = fopen(filename, "wt");
	fprintf(fp, "rows:%02d\n", mat.rows);
	fprintf(fp, "cols:%02d\n", mat.cols);
	for (int y = 0; y < mat.rows; y++)
	{
		for (int x = 0; x < mat.cols; x++)
		{
			// 这里视差矩阵是CV_16S 格式的，故用 short 类型读取,若视差矩阵是 CV_32F 格式，则用 float 类型读取
			Vec3f  disp = mat.at<Vec3f>(y, x);
			fprintf(fp, "%f,%f,%f\n", disp.val[0], disp.val[1], disp.val[2]);
		}
	}
	fclose(fp);
}