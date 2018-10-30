//Programmer Blakely Frechette & Zeid Alameedi

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
 
namespace AB_Parser
{
    class Program
    {
 
        static void Main(string [] args)
        {
            do
            {
                Program obj = new Program();
                obj.ReturnCMD();
                Console.WriteLine("Continue? (y/n)");
            } while (Console.ReadLine() != "n");
 
 
            //do
            //{
            //    Program a = new Program();
            //    //a.ParseArgs();
            //    //a.StartScript();
            //    //Console.Write("JSON file name: ");
            //    //string jsonFileName = Console.ReadLine();
            //    System.IO.File.Move("result.json", jsonFileName + ".json");
            //    Console.WriteLine("Continue? (y/n)");
            //}
            //while (Console.ReadLine() != "n");
 
        }
 
        public void ParseArgs()
        {
            for (int i = 0; i < 2; i++)
            {
                string cmdargs;
                Console.Write("Args: ");
                byte[] inputBuffer = new byte[1024];
                Stream inputStream = Console.OpenStandardInput(inputBuffer.Length);
                Console.SetIn(new StreamReader(inputStream, Console.InputEncoding, false, inputBuffer.Length));
                //string strInput = Console.ReadLine();
                cmdargs = Console.ReadLine();
                string[] args = cmdargs.Split(' ');
 
                Dictionary<string, object> Container = new Dictionary<string, object>();
 
                foreach (string arg in args)
                {
                    string argKey = string.Empty;
                    string argValue = string.Empty;
 
                    if (arg.StartsWith("--"))
                    {
                        string[] argParts = arg.Split('=');
                        argKey = argParts[0].Substring(2);
 
 
                        if (argParts.Length > 1)
                        {
                            argValue = argParts[1];
                            if (argValue.Contains("\""))
                            {
                                argValue = argValue.Replace("\"", "");
                            }
                            if (argValue.Contains('$') || argKey.Contains("site") || argKey.Contains("environment") || argKey.Contains("module"))
                            {
 
                            }
                            else
                            {
                                Container[argKey] = argValue;
                            }
                        }
 
                    }
 
 
                }
 
                string Test = JsonConvert.SerializeObject(Container);
                string[] lines = new string[] { Test };
 
                if (i == 0)
                {
                    System.IO.File.WriteAllLines(@"c:\users\bfrechette\source\repos\AB_Parser\AB_Parser\PROD.txt", lines);
 
                }
                else
                {
                    System.IO.File.WriteAllLines(@"c:\users\bfrechette\source\repos\AB_Parser\AB_Parser\TSQA.txt", lines);
 
                }
            }
        }
 
        public void StartScript()
        {
            ProcessStartInfo start = new ProcessStartInfo("cmd.exe", "/c python HelperScript.py PROD.txt TSQA.txt");
            Process.Start(start);
        }
 
        public void ReturnCMD()
        {
                string cmdargs;
                Console.Write("Args: ");
                byte[] inputBuffer = new byte[1024];
                Stream inputStream = Console.OpenStandardInput(inputBuffer.Length);
                Console.SetIn(new StreamReader(inputStream, Console.InputEncoding, false, inputBuffer.Length));
                cmdargs = Console.ReadLine();
                string[] args = cmdargs.Split(' ');
 
                Dictionary<string, object> Container = new Dictionary<string, object>();
 
                foreach (string arg in args)
                {
                    string argKey = string.Empty;
                    string argValue = string.Empty;
 
                if (arg.StartsWith("--"))
                {
                    string[] argParts = arg.Split('=');
                    argKey = argParts[0].Substring(2);
 
 
                    if (argParts.Length > 1)
                    {
                        argValue = argParts[1];
                        if (argValue.Contains("\""))
                        {
                            argValue = argValue.Replace("\"", "");
                        }
                        if (argValue.Contains('$') || argKey.Contains("site") || argKey.Contains("environment") || argKey.Contains("module"))
                        {
                            Container[argKey] = argValue;
                        }
                    }
 
                }
            }
 
            //foreach (var item in Container)
            //{
            //    string test = item.Key;
            //    Console.WriteLine("--", test, ":", item.Value, ",");
            //}
 
 
            foreach (KeyValuePair<string, object> item2 in Container)
            {
                    Console.Write("--{0}:{1} ", item2.Key, item2.Value);
            }
            
 
           
            Console.ReadLine();
 
          
 
         
        }
    }
}

