using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderstandingDelegateApp
{
    class Sample
    {   //Action - for mtheods with or without paramenter but no return
        // Func for methods with or without parameters with one return type
        //Predicate - for methods with one parameter with a boolean return type
        //public delegate void SampleDelegate(int n1,int n2);
        public delegate void SampleDelegate<T>(T n1, T n2);
        public SampleDelegate<int> MyDel;
        public SampleDelegate<string> MyStringDel;
        public Sample()
        {
            //MyDel = new SampleDelegate(Add);
            MyDel = delegate (int n1, int n2)
            {
                Console.WriteLine("The sum is " + (n1 + n2));
            };
            //MyDel += Product;
            //MyDel += delegate (int n1, int n2)
            //{
            //    Console.WriteLine("The product is " + (n1 * n2));
            //};
            //Simplified version
            MyDel += (n1, n2) => Console.WriteLine("The product is " + (n1 * n2));
            // this fellow "=>" call lambda expression
        }
        void Add(int num1, int num2)
        {
            int sum = num1 + num2;
            Console.WriteLine("The sum is " + sum);
        }
        void Product(int num1, int num2)
        {
            int sum = num1 * num2;
            Console.WriteLine("The product is " + sum);
        }
    }
}
