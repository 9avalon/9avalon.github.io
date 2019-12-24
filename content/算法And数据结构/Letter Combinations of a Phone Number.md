---
title: Letter Combinations of a Phone Number
date: 2016-6-23 17:50:10
collection: 未分类
---

#### 暴力破解
```java
    public List<String> letterCombinations(String digits) {
    	String[] s = {"abc","def","ghi","jkl","mno","pqrs","tuv","wxyz"};
    	List<String> list = new ArrayList<String>();
    	
    	
    	for (int i=0; i<digits.length(); i++){
    		String tempStr = s[digits.charAt(i)-'2'];
    		if (i == 0){
    			for (int f=0; f<tempStr.length(); f++){
    				list.add(String.valueOf(tempStr.charAt(f)));
    			}
    			continue;
    		}
    		
    		List<String> tempList = new ArrayList<String>();
    		for (int j=0; j<list.size(); j++){
    			for (int k=0; k<tempStr.length(); k++){
    				tempList.add(list.get(j)+tempStr.charAt(k));
    			}
    		}
    		list = tempList;
    	}
    	
    	return list;        
    }
```


#### DFS
因为有深度可以限制，因为可以用dfs把所有的可能性都遍历一遍。不过还是感觉挺模糊的。
```java
    public List<String> letterCombinations(String digits) {
        // 建立映射表
        String[] table = {" ", " ", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        StringBuilder tmp = new StringBuilder();
        List<String> res = new ArrayList<String>();
        if (digits.equals("")){
        	return res;
        }
        dfs(table,0, tmp, res, digits);
        return res;
    }
    
    public static void dfs(String[] table, int dep, StringBuilder tmp,List<String> list, String digits){
    	if (dep == digits.length()){
    		list.add(tmp.toString());//算出了结果
    	}else{
    		String tempStr = table[digits.charAt(dep)- '0'];
        	for (int i=0; i<tempStr.length(); i++){
        		tmp.append(tempStr.charAt(i));
        		dfs(table, dep+1, tmp, list, digits);
        		tmp.deleteCharAt(tmp.length()-1);
        	}
    	}
    }
```
