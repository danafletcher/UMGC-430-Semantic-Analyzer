// CMSC 430 Compiler Theory and Design
// Project 3 Skeleton
// UMGC CITE
// Summer 2023

// This file contains type definitions and the function
// definitions for the evaluation functions

typedef char* CharPtr;

enum Operators {ADD, MULTIPLY, LESS, AND, SUBTRACT, DIVIDE, EQUAL, 
GREATER, GREATER_EQUAL, LESS_EQUAL, NOT_EQUAL, REM, EXP, NEG, OR, NOT, MOD};

enum Fold_Dirs {LEFT_DIR, RIGHT_DIR};

double evaluateArithmetic(double left, Operators operator_, double right);
double evaluateRelational(double left, Operators operator_, double right);
double evaluateFold(Fold_Dirs fold_dir, Operators operator_, vector<double> list);
// double evaluateExponential(double left, Operators operator_, double right);
int hex_to_int(const char *hex_string);
int char_to_int(const char *literal);

