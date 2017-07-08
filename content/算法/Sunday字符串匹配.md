---
title: 字符串匹配
date: 2016-6-23 17:51:46
collection: 字符串
---

传闻中比kmp快的算法，但在leetcode中速度却很慢，百思不得其解。。。

```
    public int strStr(String haystack, String needle) {
    	if (needle.length() > haystack.length()){
    		return -1;
    	}
    	if (needle.equals("")){
    		return 0;
    	}
    	Map<Character,Integer> map = new HashMap<Character, Integer>();
    	for (int i=0; i<needle.length(); i++){
    		map.put(needle.charAt(i), i);
    	}
    	int result = -1;
    	boolean match = false;
    	int i=0;
    	while (i<haystack.length()){
    		int itemp = i;
    		int j=0;
    		while (j<needle.length()){
    			//处理itemp越界
    			if (itemp>=haystack.length()) return -1;
    			if (haystack.charAt(itemp) != needle.charAt(j)){
    				//处理跳跃的时候越界
    				if (i+needle.length() >= haystack.length()){
    					return -1;
    				}
    				char next = haystack.charAt(i + needle.length());
    				//遍历查找next是否在needle中出现
    				Integer nextpos = map.get(next);
    				if (nextpos == null){
    					i += needle.length();
    				}else{
    					//有匹配，则最后匹配的地方对齐
    					i += needle.length() - nextpos - 1;
    				}
    				break;
    			}
    			//成功匹配
    			if (j == needle.length()-1){
    				match = true;
    				result = i;
    				break;
    			}
    			j++;
    			itemp++;
    		}
    		if (match == true){
    			break;
    		}
    		i++;
    	}
    	
        return result;
    }
```