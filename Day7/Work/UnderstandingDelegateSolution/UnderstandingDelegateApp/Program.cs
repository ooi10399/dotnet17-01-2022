using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderstandingDelegateApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Sample s = new Sample();
            s.MyDel(10, 20);
            Console.ReadKey();
        }
    }
}
