from datime import datetime

def read_csv(file_path, date_format="%Y-%m-%dT%Hh%MZ"):
    """Function for reading csv files created by the write_csv.m matlab file
       which output file_names, Hm0 and peak period
    """
    df = pd.read_csv(file_path)
    date_time_array = []
    for date_time_string in df['file_name'].values:
        date_time_array.append(datetime.strptime(date_time_string.split('}')[1][:-4],
                                                 date_format))
        
    df.index = pd.DatetimeIndex(date_time_array)
    return df
