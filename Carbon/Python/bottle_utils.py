# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:light
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.13.0
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# +
import re
import pandas as pd

class QualityFlags():
    """Primary flags for QARTOD"""
    
    GOOD = 1
    UNKNOWN = 2
    SUSPECT = 3
    BAD = 4
    MISSING = 9

FLAGS = QualityFlags

def check_fill(flag):
    """Function to check if the flag is a fill value"""
    if pd.isna(flag):
        return True
    elif str(flag) == "-9999999":
        return True
    elif "1" not in str(flag):
        return True
    else:
        return False

def parse_flag(flag):
    """Function to parse the quality flag. Returns fill or nan when appropriate."""
    locs=[]
    for match in re.finditer("1", flag[::-1], re.S):
        locs.append(match.span()[0])
    return locs
    
def interp_ctd_flag(flag):
    "Function which interprets CTD flags to standard convention"
    
    # First filter for fill 
    if check_fill(flag):
        return flag
    else:
        parsed_flag = parse_flag(flag)
        max_bit = max(parsed_flag)
        if max_bit == 1:
            return QualityFlags.MISSING
        elif max_bit == 2:
            return QualityFlags.GOOD
        elif max_bit == 3:
            return QualityFlags.SUSPECT
        elif max_bit == 4:
            return QualityFlags.BAD
        else:
            return QualityFlags.UNKNOWN
        
def interp_discrete_flag(flag):
    """Function which interprets discrete Bottle flags to standard convention."""
    
    # First filter for fill values
    if check_fill(flag):
        return flag
    else:
        parsed_flag = parse_flag(flag)
        max_bit = max(parsed_flag)
        if max_bit == 1:
            return QualityFlags.MISSING
        elif max_bit == 2:
            return QualityFlags.GOOD
        elif max_bit == 3:
            return QualityFlags.SUSPECT
        elif max_bit == 4:
            return QualityFlags.BAD
        else:
            return QualityFlags.UNKNOWN
        
def interp_replicate_flag(flag):
    """Function which returns a boolean if a sample has a duplicate/replicate sample."""
    
    # First filter for fill values
    if check_fill(flag):
        return flag
    else:
        parsed_flag = parse_flag(flag)
        max_bit = max(parsed_flag)
        if max_bit == 3 or max_bit == 4:
            return True
        else:
            return False
        
def interp_niskin_flag(flag):
    """Function which interprets Niskin bottle flags"""
    
    if check_fill(flag):
        return flag
    else:
        parsed_flag = parse_flag(flag)
        max_bit = max(parsed_flag)
        if max_bit == 1:
            return QualityFlags.MISSING
        elif max_bit == 2:
            return QualityFlags.GOOD
        elif max_bit == 3 or max_bit == 4 or max_bit == 5:
            return QualityFlags.SUSPECT
        else:
            return QualityFlags.UNKNOWN
        
def convert_times(x):
    if type(x) is str:
        x = x.replace(" ","")
        x = pd.to_datetime(x, utc=False)
    else:
        pass
    return x

def not_statistically_sigificant(x):
    if type(x) is str:
        if "<" in x:
            x = 0
    return x
# -


