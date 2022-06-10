#include <iostream>
#include <string>
using namespace std;

class employee {
    protected:
        string name;
        string curp;
        int hoursPerWeek;
        int salaryPerHour;

    public:
        employee(string n, string c, int hours, int salary) {
            name = n;
            curp = c;
            hoursPerWeek = hours;
            salaryPerHour = salary;
        }
};

class programmer: public employee {
    private:
        int bonusPerExtraHour;
    
    public:
        programmer(string n, string c, int hours, int salary, int bonus) : employee(n, c, hours, salary) {
            bonusPerExtraHour = bonus;
        } 

        int getSalary() {
            return hoursPerWeek*salaryPerHour;
        }

        int getBonus() {
            if (hoursPerWeek > 40) {
                int extraHours = hoursPerWeek-40;
                return extraHours*bonusPerExtraHour;
            } else {
                return 0;
            }
        }

        void showInfo() {
            cout << "Employee: " << name << endl;
            cout << "CURP: \t" << curp << endl;
            cout << "Hours/week: " << hoursPerWeek << " hours" << endl;
            cout << "Salary/hour: " << salaryPerHour << endl;
            cout << "Bonus/extra hour: " << bonusPerExtraHour << endl;
            cout << "Salary/week: " << getSalary() << endl;
            cout << "Total bonus/week: " << getBonus() << endl;
        }
};

int main() {
    string name;
    string curp;
    string hoursPerWeek;
    string salaryPerHour;
    string bonusPerExtra;

    cout << "Enter your name: " << endl;
    cin >> name;
    cout << "Enter your CURP: " << endl;
    cin >> curp;
    cout << "Enter working hours a week: " << endl;
    cin >> hoursPerWeek;
    cout << "Enter salary per hour: " << endl;
    cin >> salaryPerHour;
    cout << "Enter bonus per extra hour: " << endl;
    cin >> bonusPerExtra;

    programmer employee1(name, curp, stoi(hoursPerWeek), stoi(salaryPerHour), stoi(bonusPerExtra));

    employee1.showInfo();
    cout << "------------------------------------------------------" << endl;
    cout << "Total Salary per week: " << employee1.getSalary()+employee1.getBonus() << endl;

    return 0;
}