if (A_AhkVersion <= 1.1.31.1)
{
	MsgBox,4,모두의 한글 라이브러리,[모두의 한글]이 지원되지 않는 오토핫키 버전입니다.`n오토핫키 공식 사이트로 이동하셔서 최신 버전으로 업데이트해주세요.`n`n이동하시겠습니까?
	IfMsgBox, Yes
		run, www.autohotkey.com
	ExitApp
}
if (A_IsUnicode != 1)
{
	MsgBox,,모두의 한글 라이브러리,모두의 한글은 Unicode지원이 필수적이며, ANSI환경을 지원하지 않습니다.`n실행 환경을 Unicode로 변경 후 사용해주세요.
	ExitApp
}
MsgBox, 정상적으로 호환이 되는 환경입니다 :)