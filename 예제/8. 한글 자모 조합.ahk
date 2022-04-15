﻿#Include ..\EveryHangul.ahk

/* =========================
 * 한글조합()함수는 초,중,종성을 조합합니다.
 *
 * [사용법]
 * 한글조합("초성", "중성", "종성"(생략가능))
 * ==========================
 */
 
MsgBox, % 한글조합("ㅎ", "ㅣ", "ㅇ")

MsgBox, % 한글조합(뽑기.초성(), 뽑기.중성(), 뽑기.종성()) ; 뽑기 클래스와 함께 쓰면 완성된 글자를 임의로 뽑을 수 있겠지요?
MsgBox, % 한글조합(뽑기.초성(), 뽑기.중성()) ;종성은 입력하지 않을 수 있습니다.

MsgBox, % 한글조합("아무말", "아무말") ;올바른 자모가 오지 않으면 "ERROR"를 반환합니다.