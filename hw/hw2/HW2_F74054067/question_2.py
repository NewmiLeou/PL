import urllib.request
import re
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter

author = "Ian+Goodfellow"
url = "https://arxiv.org/search/?query=" + author + "&searchtype=author"
content = urllib.request.urlopen(url)
html_str = content.read().decode('utf-8')
# number of the paper
num_pattern = 'title is-clearfix[\s\S]*?:'
num_result = re.findall(num_pattern,html_str)
for i in num_result:
    number = i.split("title is-clearfix\">\n    \n        Showing 1&ndash;50 of ")[1].split(" results for author:")[0].strip()
    start = int(int(number)/50)
    co_author = []
    print("Input Author: [" + author + "]")
    for page in range(0,start+1) :
        url2="https://arxiv.org/search/?query="+author+"&searchtype=author&order=-announced_date_first&size=50&abstracts=show&start="+str(page*50)
        content2 = urllib.request.urlopen(url2)
        html_str2 = content2.read().decode('utf-8')
        # check if it is equal to the input
        check_flag = False
        check_pattern = 'Authors:[\s\S]*?originally announced[\s\S]*?</p>'
        check_result = re.findall(check_pattern,html_str2)
        for check in check_result:
            name_pattern = 'a href=\"[\s\S]*?\">[\s\S]*?</a>'
            name_result = re.findall(name_pattern,check)
            for name in name_result:
                Name = name.split("\">")[1].split("</a>")[0].strip()
                if(Name.lower() == author.replace('+',' ').lower()):
                    check_flag = True
            if(check_flag==True):
                # co-author
                author_pattern = 'Authors:</span>[\s\S]*?</p>'
                author_result = re.findall(author_pattern,check)
                for l in author_result:
                    href = l.split("Authors:</span>\n      \n      ")[1].split("\n      \n    </p>")[0].strip()
                    #獲取超連結<a>和</a>之間名字
                    coauthor_pattern = '<a .*?>(.*?)</a>'
                    coauthor_texts = re.findall(coauthor_pattern, href, re.S|re.M)
                    for t in coauthor_texts:
                        co_author.append(t.strip())
                        Co_author = list(set(co_author))
                        Co_author.sort()
            check_flag = False 
    for name in Co_author:
        times = co_author.count(name)
        if name == author.replace('+',' ') :  #去掉自己
            continue
        else:   # print the answer
            print('[' + name + ']: ' + str(times) + ' times' )


