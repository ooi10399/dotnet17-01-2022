using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClinicModelsLibrary;

namespace Clinic
{
    class Program
    {
        static void Main(string[] args)
        {
            User u = new User();
            u.TakeDetails();
            u.PrintDetails();
            Console.ReadKey();
        }
    }
}
