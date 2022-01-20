using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FirstApplication
{
    internal class AssignmentDay4
    {
         public void isHappy(int n)
        {
            if (n==1)
            {
                Console.WriteLine("It is a happy number!!!");
            }
            else
            {
               if (n > 1 && n < 5)
                    Console.WriteLine("It is not a happy number!!!");
                    break;                
                int num = n;
                int digit;
                int sum = 0;                
                while (num > 0)
                {
                    digit = num % 10;
                    sum = sum + (digit * digit);
                    num = num / 10;
                }
                
                isHappy(sum);
            }

        }
     }
}

