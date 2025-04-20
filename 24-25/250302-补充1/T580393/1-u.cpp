#include <iostream>
using namespace std;

int main() {
    int x;
    cin >> x;
    int abs = x < 0 ? -x : x;
    int neg = x < 0 ? 1 : 0;

    int original[32];
    int temp = abs;
    for (int i = 31; i >= 1; i--) {
        original[i] = temp & 1;
        temp >>= 1;
    }
    original[0] = temp < 0;
    for (int i = 0; i < 32; i++) {
        cout << original[i];
    }
    cout << endl;

    int complement[32];
    temp = temp < 0 ? (~(-x) + 1) : x;
    for (int i = 31; i >= 0; i--) {
        complement[i] = temp & 1;
        temp >>= 1;
    }
    for (int i = 0; i < 32; i++) {
        cout << complement[i];
    }
    cout << endl;

    int inverse[32];
    temp = temp < 0 ? (~(-x)) : x;
    for (int i = 31; i >= 0; i--) {
        inverse[i] = temp & 1;
        temp >>= 1;
    }
    for (int i = 0; i < 32; i++) {
        cout << inverse[i];
    }
    cout << endl;

    return 0;
}