import sys
import os
import json
from itertools import product

# Automates the common implementation and formatting of the json files
# Programmers: Zeid Al-Ameedi & Blakely Frechette
# Dates worked on 06-26-18 --- 06-28-18

def load():
    if(len(sys.argv) > 1): # sys.argv[0] is the name of the script 1 - ... are the cmd args
        p_filename = sys.argv[1]
        infile = open(p_filename, "r")
        to_convert=infile.read()
        prod_load = json.loads(to_convert);

        c_filename = sys.argv[2]
        infile = open(c_filename, "r")
        to_convert2 = infile.read()
        central_load=json.loads(to_convert2)

        #Stores parsed file into a dictionary (Prod)(Central) --- (Common)
        print("--Prod Dictionary--")
        for key in prod_load.keys():
           print(key,":",prod_load[key])
        first_dict = {"PROD":prod_load}
        myJson = json.dumps(first_dict)

        print("--Central Dictionary--")
        for key in central_load.keys():
            print(key,":", central_load[key])
        second_dict={"TSQA":central_load}


        #Begin initialization of the common dictionary
        common_dict = {}
        #for (k,v), (k2, v2) in zip(first_dict.items(), second_dict.items()):
        # for k,k2 in first_dict.keys(), second_dict.keys():
        #     for j, j2 in first_dict[k].keys(), second_dict[k2].keys():
        #         if( j == j2):
        #             common_dict[k]==v
        #             try:
        #                 first_dict.pop(k,v)
        #                 second_dict.pop(k2, v2) 
        #             except:
        #                 raise ValueError('Dictionaries retained info that should not be present.')
        print("\n\n")
        d1_lst = []
        d2_lst = []
        for k in first_dict.keys():
            for k2 in first_dict[k].keys():
                d1_lst.append(k2)
        for k3 in second_dict.keys():
            for k4 in second_dict[k3].keys():
                d2_lst.append(k4)

        #Check every key/val
        for present in d1_lst:
            if present in d2_lst:
                if(first_dict['PROD'][present] == second_dict['TSQA'][present]):
                    common_dict[present]=first_dict['PROD'][present]
                    try:
                        first_dict['PROD'].pop(present, first_dict['PROD'])
                        second_dict['TSQA'].pop(present, second_dict['TSQA'])
                    except:
                        raise ValueError("Removal was not handled properly")

        

        
        common_dict2 = {"common":common_dict}
        final_dict = {**first_dict, **second_dict, **common_dict2}
        #Creates the JSON formatted file
        
        with open('result.json', "w") as fp:
           json.dump(final_dict, fp, indent=4)
        print("\nSuccess. Data stored in ---> {0}".format(jsonfile))



if __name__ == '__main__':
    print("Executing parser...\n")
    load()
    
        

