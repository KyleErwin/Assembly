#include <stdio.h>

struct Shape {
	int id;
	char name[19];
	char formula[67];
	double area;
	double A;
	double B;
	double C;
	double D;
	double radius;
};

extern int shaper(struct Shape* mysteryShape);

int main()
{
	struct Shape mysteryShape;
	mysteryShape.id =0;
	mysteryShape.area =0.0;
	mysteryShape.A =1.0;
	mysteryShape.B =4.0;
	mysteryShape.C =3.3;
	mysteryShape.D =0.0;
	mysteryShape.radius =0.0;

	shaper(&mysteryShape);
	printf("ID: %d\n",mysteryShape.id);
	printf("Name: %s\n",mysteryShape.name);
	printf("Formula: %s\n",mysteryShape.formula);
	printf("Area: %f\n",mysteryShape.area);
	printf("Side A: %f\n",mysteryShape.A);
	printf("Side B: %f\n",mysteryShape.B);
	printf("Side C: %f\n",mysteryShape.C);
	printf("Side D: %f\n",mysteryShape.D);
	printf("Radius: %f\n",mysteryShape.radius);
	return 0;
}
