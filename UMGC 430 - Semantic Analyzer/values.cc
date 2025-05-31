// CMSC 430 Compiler Theory and Design
// Project 3 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the evaluation functions

#include <string>
#include <cmath>
#include <cstring>
#include <ctype.h>
#include <vector>


using namespace std;

#include "values.h"
#include "listing.h"

double evaluateArithmetic(double left, Operators operator_, double right) {
	double result;
	switch (operator_) {
		case ADD:
			result = left + right;
			break;
		case MULTIPLY:
			result = left * right;
			break;
		case DIVIDE:
			result = left / right;
			break;
		case SUBTRACT:
			result = left - right;
			break;
		case NEG:
			result = left * (-1);
			break;
		case MOD:
			result = fmod(left, right);
			break;
		case EXP:
			result = pow(left, right);
			break;	
	}
	return result;
}

double evaluateRelational(double left, Operators operator_, double right) {
	double result;
	switch (operator_) {
		case LESS:
			result = left < right;
			break;
		case NOT:
			result = left /= right;
			break;
		case GREATER:
			result = left > right;
			break;
		case GREATER_EQUAL:
			result = left >= right;
			break;
		case LESS_EQUAL:
			result = left <= right;
			break;
		case EQUAL:
			result = left = right;
			break;
	}
	return result;
}


int hex_to_int(const char *hex_string) {
    int result = 0;
    int len = strlen(hex_string);
    for (int i = 1; i < len; ++i) {
        char c = hex_string[i];
        if (c >= '0' && c <= '9') {
            result = result * 16 + (c - '0');
        } else if (c >= 'a' && c <= 'f') {
            result = result * 16 + (c - 'a' + 10);
        } else if (c >= 'A' && c <= 'F') {
            result = result * 16 + (c - 'A' + 10);
        }
    }
    return result;
}

int char_to_int(const char *literal) {
  int value = 0;
  if (literal[0] == '\'') {
    if (literal[1] == '\\') {
      switch (literal[2]) {
        case 'n': value = 10; 
		break; 
        case 't': value = 9; 
		break;  
        case 'r': value = 13; 
		break; 
        case 'f': value = 12; 
		break; 
        case '\\': value = 92; 
		break; 
        case '\'': value = 39; 
		break; 
        case '\"': value = 34; 
		break; 
        case '0': value = 0; 
		break; 
        default: value = literal[2]; 
		break; 
      }
    } else {
      value = literal[1]; // Regular characters
    }
  }
  return value;
}

double evaluateFold(Fold_Dirs fold_dir, Operators operator_, vector<double> list) {
	double result;
	if (fold_dir == LEFT_DIR) {
		result = list[0];
		for (int i = 1; i < list.size(); i++) 
			result = evaluateArithmetic(result, operator_, list[i]);
	}
	else {
		result = list[list.size() - 1];
		for (int i = list.size() - 2; i >=  0; i--)
			result = evaluateArithmetic(list[i], operator_, result);
	}
	return result;
}