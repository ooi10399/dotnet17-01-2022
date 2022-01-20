using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FirstApplication
{
    internal class Program
    {
        //Method Header
        void PrintName() //
        {//Method BOdy
            Console.WriteLine("Hello Max");
        }

        void PrintAnyName(string name)
        {
            Console.WriteLine("Hello " + name);
        }

        void Greet(String greet)
        {
            string name;
            Console.WriteLine("Pls enter your name: ");//input qns
            name = Console.ReadLine();//run input to show and assign to a variable 
            Console.WriteLine(greet+ " "+name);
        }
        static void Main(string[] args)
        {
            //Console.WriteLine("Hello World");
            //Program program = new Program(); // Create method
            //program.PrintName();//Call Method
            //program.Greet("Belloooo");
            //program.PrintAnyName("Ruby");

            //Calculator calc = new Calculator();
            //calc.Add();
            //calc.Product();

            //Statement s = new Statement();

            //s.UnderstandingSelection();
            //s.UnderstandingSelectionWithSwitch();
            //s.IterationWithFor();
            //s.IterationWithWhile();
            //s.IterationWithDoWhile();


            //Pizza pizza = new Pizza();
            AssignmentDay4 a = new AssignmentDay4();
            a.isHappy(45);
            Console.ReadKey(); //Press any key it will close the program
        }
    }
}
