using System;

namespace UnderstandingArraysApplication
{
    class Program
    {
        void UnderstandingBasicArray()
        {
            int[] arrNumbers = new int[3];//3 means inside have 3 empty slotint, fixed 3 , only can input 3 int
            Console.WriteLine("Please enter the numebrs");
            for (int i = 0; i < arrNumbers.Length; i++)
            {
                arrNumbers[i] = Convert.ToInt32(Console.ReadLine());
            }
            for (int i = 0; i < arrNumbers.Length; i++)
            {
                Console.WriteLine(arrNumbers[i]);
            }
        }
        static void Main(string[] args)
        {
            Program program = new Program();
            program.UnderstandingBasicArray();
            Console.ReadKey();
        }
    }
}
