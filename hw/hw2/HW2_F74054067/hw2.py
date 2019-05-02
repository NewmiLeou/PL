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
    x = []
    y = []
    co_author = []
    times = []
    print("Input Author: [" + author + "]")
    for j in range(0,start+1) :
        url2="https://arxiv.org/search/?query="+author+"&searchtype=author&order=-announced_date_first&size=50&abstracts=show&start="+str(j*50)
        content2 = urllib.request.urlopen(url2)
        html_str2 = content2.read().decode('utf-8')
        # announced year
        year_pattern = 'originally announced[\s\S]*?</p>'
        year_result = re.findall(year_pattern,html_str2)
        for k in year_result:
            year = k.split("originally announced</span>")[1].split("\n      \n    </p>")[0].strip()
            x.append(year[-5:-1])
            X = list(set(x))
            X.sort()
        # co-author
        author_pattern = '<span class="search-hit">Authors:</span>[\s\S]*?</p>'
        author_result = re.findall(author_pattern,html_str2)
        for l in author_result:
            href = l.split("<span class=\"search-hit\">Authors:</span>\n      \n      ")[1].split("\n      \n    </p>")[0].strip()
            #獲取超連結<a>和</a>之間內容
            coauthor_pattern = '<a .*?>(.*?)</a>'
            coauthor_texts = re.findall(coauthor_pattern, href, re.S|re.M)
            for t in coauthor_texts:
                co_author.append(t.strip())
                Co_author = list(set(co_author))
                Co_author.sort()
    
    # Question 2
    for name in Co_author:
        times = co_author.count(name)
        if name == author.replace('+',' ') :  #去掉自己
            continue
        else:   # print the answer
            print('[' + name + ']: ' + str(times) + ' times' )

    # Question 1
    for m in X:
        counter = x.count(m)
        y.append(counter)
    ax = plt.figure().gca()
    ymajorFormatter = FormatStrFormatter('%d') #設置y軸標籤文本的格式
    ax.yaxis.set_major_formatter(ymajorFormatter)
    plt.ylabel('The number of papers been published')
    plt.title("Input Author: [" + author + "]")
    plt.bar(X,y)
    plt.show()

