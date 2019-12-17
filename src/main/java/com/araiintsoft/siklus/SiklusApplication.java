package com.araiintsoft.siklus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

import java.util.ArrayList;
import java.util.List;

@ServletComponentScan
@SpringBootApplication
public class SiklusApplication {

	public static void main(String[] args) {
		SpringApplication.run(SiklusApplication.class, args);
	}

	public static boolean solution(int[] A) {
		int aLength = A.length;
		boolean isBreak = false;
		for(int i = 0; i < aLength-1; i++){
			if(isBreak){
				break;
			}
			int ai = A[i];
			boolean isMove = false;
			for(int x = 1; x <aLength-i; x++){
				if(ai>A[i+x] ){
					isMove = true;
					if (x == aLength-1-i){
						A[i] = A[i+x];
						A[i+x] = ai;
						isBreak = true;
						break;
					}
				} else if(isMove){
					A[i] = A[i+x-1];
					A[i+x-1] = ai;
					isBreak = true;
					break;
				}
			}
		}
		if(isOrdered(A)){
			return true;
		}
		return false;
	}

	public static boolean isOrdered(int[] A){
		int aLength = A.length;
		for(int i = 0; i < aLength-1; i++){
			if (A[i]>A[i+1]){
				return false;
			}
		}
		return true;
	}

	static class Tree {
		public int x;
		public Tree l;
		public Tree r;
	}

	public static int solution(Tree T){
		int result = 0;
		List<Integer> a = new ArrayList<>();
		getNodes(T, a);
		int root = T.x;
		for (int b : a){
			if (b>=root){
				result++;
			}
		}
		return result;
	}

	public static void getNodes(Tree T, List<Integer> a){
		if (null!=T.l){
			a.add(T.l.x);
			getNodes(T.l, a);
		}
		if (null!=T.r){
			a.add(T.r.x);
			getNodes(T.r, a);
		}
	}

	public static String solution(String S){
		String reverse = "";
		String[] splitS = S.split(" ");
		for (String s : splitS){
			char[] chars = s.toCharArray();
			int cl = chars.length;
			char[] newChars = new char[cl];
			cl--;
			for(char c: chars){
				newChars[cl] = c;
				cl--;
			}
			String sReversed = "";
			for (char c : newChars){
				sReversed = sReversed+c;
			}
			if (reverse.isEmpty()){
				reverse = sReversed;
			} else {
				reverse = reverse+" "+sReversed;
			}
		}
		return reverse;
	}


	public static int solution(int[] A, int X) {
		int N = A.length;
		if (N == 0) {
			return -1;
		}
		int l = 0;
		int r = N - 1;
		while (l < r) {
			int m = (l + r) / 2;
			if (A[l] == X) {
				l = r;
			} else {
				l++;
			}
		}
		if (A[l] == X) {
			return l;
		}
		return -1;
	}

}
