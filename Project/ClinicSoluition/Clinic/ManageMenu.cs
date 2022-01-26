using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using ClinicModelsLibrary;

namespace Clinic
{
    public class ManageMenu
    {
        public void PrintMainMenu()
        {
            Console.WriteLine("Welcome to the clinic");
            Console.WriteLine("Choose from the options");
            Console.WriteLine("1. You are a doctor");
            Console.WriteLine("2. You are a patient");
            Console.WriteLine("3. You are a new user"); 
            string option = Console.ReadLine();
        }
        public void PrintDoctorMenu()
        {
            Console.WriteLine("Choose from the options");
            Console.WriteLine("1. View your appointments");
            Console.WriteLine("2. View your past appointments");
            Console.WriteLine("3. Update appointment status");
            Console.WriteLine("4. Delete appointment");
            Console.WriteLine("5. Raise payment request for an appointment");
            Console.WriteLine("0. Exit");
            string option = Console.ReadLine();
        }
        public void PrintPatientMenu()
        {
            Console.WriteLine("Choose from the options");
            Console.WriteLine("1. View your appointments");
            Console.WriteLine("2. View your past appointments");
            Console.WriteLine("4. Add new appointment");
            Console.WriteLine("4. Edit appointment");
            Console.WriteLine("5. Delete appointment");
            Console.WriteLine("6. Make payment for an appointment");
            Console.WriteLine("0. Exit");
            string option = Console.ReadLine();
        }

        
    }
}
