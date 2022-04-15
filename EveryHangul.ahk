/* #############################################################
 * 모두의 한글 v20220415
 *
 * 오토핫키에서 한글을 세부적으로 다루기 위한 라이브러리입니다.
 * 라이브러리상에서의 문제나 개선 사항 등 피드백은 이메일로 주세요.
 *
 * 만든 이: 프날(Pnal)
 * 이메일: contact@pnal.dev
 * #############################################################
 */
호환성체크()
{
	CheckVer := SubStr(A_AhkVersion, 5,2)
	if (CheckVer < 31)
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
	return true
}

; 한글 인덱스. 수정 금지!
global ChoSeong := ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
global JungSeong := ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
global JongSeong := ["ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ","ㅍ", "ㅎ"]

; 영타 인덱스. 수정 금지!
global EngIndexCho := ["r", "R", "s", "e", "E", "f", "a", "q", "Q", "t", "T", "d", "w", "W", "c", "z", "x", "v", "g"]
global EngIndexJung := ["k", "o", "i", "O", "j", "p", "u", "P", "h", "hk", "ho", "hl", "y", "n", "nj", "np", "nl", "b", "m", "ml", "l"]
global EngIndexJong := ["r", "R", "rt", "s", "sw", "sg", "e", "f", "fr", "fa", "fq", "ft", "fx", "fv", "fg", "a", "q", "qt", "t", "T", "d", "w", "c", "z", "x", "v", "g"]


/* =========================
 * 분리() 함수는 한글의 자모음을 분리합니다.
 *
 * [매개변수 설명]
 * _inputString: 분리할 문자열입니다.
 * _isHard: 1이 입력될 시, 겹받침 또한 분리시킵니다. (ㄳ → ㄱㅅ)
 *		   기본 값은 0이며, 겹받침 분리를 하지 않습니다. (ㄳ → ㄳ)
 *
 * [반환값]
 * string: 자모음 분리된 inputstring
 *
 * [특이사항]
 * 1. 한글 이외의 언어가 inputString에 온다면, 해당 부분은 분리를 하지 않습니다.
 * 2. 분리된 한글 문자열이 반환됩니다.
 * ==========================
 */

분리(_inputString, _isHard := 0)
{
	Loop, Parse, _inputString
	{
		Tmp := Asc(A_LoopField) - 44032
		Jong := Mod(tmp, 28) 
		Jung := Mod(Floor((tmp - Jong) / 28), 21) + 1
		Cho := Floor(tmp / (21 * 28)) + 1
		
		JongFinal := JongSeong[Jong]
		
		if (Cho < 0|| tmp > 11171)
			JongFinal := A_LoopField
		if (_isHard = 1)
		{
			Switch JongFinal ;이 부분에서 오류가 나면, 현재 오토핫키 버전이 낮은 것이니 최신 버전으로 업데이트 해주세요.
			{
				case "ㄳ":
					JongFinal := "ㄱㅅ"
				case "ㄵ":
					JongFinal := "ㄴㅈ"
				case "ㄶ":
					JongFinal := "ㄴㅎ"
				case "ㄺ":
					JongFinal := "ㄹㄱ"
				case "ㄻ":
					JongFinal := "ㄹㅁ"
				case "ㄼ":
					JongFinal := "ㄹㅂ"
				case "ㄽ":
					JongFinal := "ㄹㅅ"
				case "ㄾ":
					JongFinal := "ㄹㅌ"
				case "ㄿ":
					JongFinal := "ㄹㅍ"
				case "ㅀ":
					JongFinal := "ㄹㅎ"
				case "ㅄ":
					JongFinal := "ㅂㅅ"
			}
		}
		result .= ChoSeong[Cho] JungSeong[Jung] JongFinal
	}
	return result
}


/* =========================
 * 영타() 함수는 입력한 한글 문자열을 영타로 바꿔줍니다. (QWERTY키보드 기준)
 *
 * [매개변수 설명]
 * _inputString: 영타로 입력할 문자열입니다.
 *
 * [반환값]
 * string: 영타로 변환된 inputstring (예: inputstring이 '안녕'일때, 반환값은 'dkssud')
 *
 * [특이사항]
 * 1. 한글 이외의 언어가 inputString에 온다면, 해당 부분은 변환을 하지 않습니다.
 * 2. 변경된 알파벳 문자열이 반환됩니다.
 * ==========================
 */
영타(_inputString)
{
	호환성체크()
	Loop, Parse, _inputString
	{
		if (개발용.자음에있냐(A_LoopField) != false)
		{
			result .= EngIndexCho[개발용.자음에있냐(A_LoopField)]
			continue
		}
		if (개발용.모음에있냐(A_LoopField) != false)
		{
			result .= EngIndexJung[개발용.모음에있냐(A_LoopField)]
			continue
		}
		Tmp := Asc(A_LoopField) - 44032
		Jong := Mod(tmp, 28) 
		Jung := Mod(Floor((tmp - Jong) / 28), 21) + 1
		Cho := Floor(tmp / (21 * 28)) + 1
		
		JongFinal := EngIndexJong[Jong]
		if (Cho < 0|| tmp > 11171)
		{
			Switch A_LoopField
			{
				case "ㄳ":
					JongFinal := "rt"
				case "ㄵ":
					JongFinal := "sw"
				case "ㄶ":
					JongFinal := "sg"
				case "ㄺ":
					JongFinal := "fr"
				case "ㄻ":
					JongFinal := "fa"
				case "ㄼ":
					JongFinal := "fq"
				case "ㄽ":
					JongFinal := "ft"
				case "ㄾ":
					JongFinal := "fx"
				case "ㄿ":
					JongFinal := "fv"
				case "ㅀ":
					JongFinal := "fg"
				case "ㅄ":
					JongFinal := "qt"
				default:
					JongFinal := A_LoopField
			}
		}
		result .= EngIndexCho[Cho] EngIndexJung[Jung] JongFinal
	}
	return result
}


/* =========================
 * 조사() 함수는 한국어 조사를 적절히 붙여줍니다.
 *
 * [매개변수 설명]
 * _inputString: 조사가 붙을 마지막 음절입니다.
 * _mode: 조사의 종류입니다.
 * 		 1이 입력될 시, "은"과 "는"을 처리합니다. (바나나는, 귤은)
 *	     2가 입력될 시, "을"과 "를"을 처리합니다. (바나나를, 귤을)
 *		 3이 입력될 시, "가"와 "이"를 처리합니다. (바나나가, 귤이)
 *		 4가 입력될 시, "과"와 "와"를 처리합니다. (바나나와, 귤과)
 *		 5가 입력될 시, "아"와 "야"를 처리합니다. (바나나야, 귤아)
 *		 6이 입력될 시, "이여"와 "여"를 처리합니다. (바나나여, 귤이여)
 *		 7이 입력될 시, "으로"와 "로"를 처리합니다. (바나나로, 귤로, 책으로)
 *		 8이 입력될 시, "라고"와 "이라고"를 처리합니다. (바나나라고, 귤이라고)
 *
 *		 각 조사 중 하나로 입력하셔도 됩니다. ("를"을 입력시 자동으로 "을"과 "를"중 하나로 처리)
 *
 * [반환값]
 * string: 적절한 조사(는/은/를/을/가/이/와/과/야/아/여/이여/로/으로/라고/이라고 중 하나)
 *
 * [특이사항]
 * 1. inputString은 한글만 와야합니다.
 * 2. 올바른 Mode 매개변수가 오지 않으면 "ERROR"를 반환합니다.
 * ==========================
 */
조사(_inputString, _mode)
{
	String := SubStr(_inputString, 0)
	Switch _mode
	{
		Case 1, "은", "는":
			result := Mod(Asc(String), 28) = 16 ? "는" : "은"
		Case 2, "을", "를":
			result := Mod(Asc(String), 28) = 16 ? "를" : "을"
		Case 3, "가", "이":
		    result := Mod(Asc(String), 28) = 16 ? "가" : "이"
		Case 4, "과", "와":
		    result := Mod(Asc(String), 28) = 16 ? "와" : "과"
		Case 5, "아", "야":
		    result := Mod(Asc(String), 28) = 16 ? "야" : "아"
		Case 6, "이여", "여":
		    result := Mod(Asc(String), 28) = 16 ? "여" : "이여"
		Case 7, "으로", "로":
		    result := Mod(Asc(String), 28) = 16 || Mod(Asc(String), 28) = 24 ? "로" : "으로"
		Case 8, "라고", "이라고":
		    result := Mod(Asc(String), 28) = 16 ? "라고" : "이라고"
		Default:
			result := "ERROR"
	}
	return result
}

/* =========================
 * 뽑기() 클래스의 각 함수는 한글 초중종성을 임의로 뽑습니다.
 * 
 * [매개변수]
 * 없음(뽑기.초성()과 같이 사용)
 *
 * [반환값]
 * string: 임의의 초성/중성/종성
 * ==========================
 */
class 뽑기
{
	초성()
	{
		Random, tmp, 1, 19
		return Choseong[tmp]
	}

	중성()
	{
		Random, tmp, 1, 21
		return JungSeong[tmp]
	}

	종성()
	{
		Random, tmp, 1, 27
		return JongSeong[tmp]
	}
}



/* =========================
 * 한영체크() 함수는 현재 한/영 상태를 반환합니다.
 *
 * [매개변수]
 * 없음(한영체크()로 사용)
 *
 * [반환값]
 * string: en/ko 중 하나 (en이 영어, ko가 한국어)
 *
 * [특이사항]
 * v2022.04.15 이전 버전의 라이브러리와 호환되지 않습니다. 라이브러리 버전이 올라갔다면 반환값을 다르게 이용해야합니다.
 * ==========================
 */
한영체크()
{
	WinGet, hwnd, ID, A
	tmp := A_DetectHiddenWindows 
	DetectHiddenWindows, ON 
	SendMessage, 643, 0x5, "", , % "ahk_id" DllCall("imm32\ImmGetDefaultIMEWnd", Uint, hwnd)
	DetectHiddenWindows, % tmp
	result := ErrorLevel = 0 ? "en" : "ko"
	return result
}




/* =========================
 * 한영변환() 함수는 현재 한/영 상태를 반환합니다.
 *
 * [매개변수 설명]
 * _mode: 한/영 상태를 한글로 하고싶은 경우 "ko", 한/영 상태를 영어로 하고싶은 경우 "en"
 *
 * [반환값]
 * int: 매개변수가 잘못됐을 경우 -1, 정상 수행시엔 0
 *
 * [특이사항]
 * v2022.04.15 이전 버전의 라이브러리와 호환되지 않습니다. 라이브러리 버전이 올라갔다면 매개변수도 변경해야합니다.
 * ==========================
 */
한영변환(_mode := "en")
{
	if (_mode = "ko")
	{
		if (한영체크() = "en")
			SendInput, {VK15}
	}
	else if (_mode = "en")
	{
		if (한영체크() = "ko")
			SendInput, {VK15}
	}
	else
		return, -1
	return 0
}




/* =========================
 * 초성추출()함수는 주어진 문자열의 초성을 반환합니다.
 *
 * [매개변수 설명]
 * _inputString: 초성만 가져올 문자열입니다.
 * _includeSpace: 공백을 포함할지 여부입니다.
 *				  0: 공백을 포함하지 않습니다. (안 녕 → ㅇㄴ)
 *				  1: 공백을 포함합니다. (안 녕 → ㅇ ㄴ)
 * _onlyKorean: 한글 이외의 문자를 반환할지 여부입니다.
 *			    0: 포함합니다. (안a녕 → ㅇaㄴ)
 *			    1: 포함하지 않습니다. (안a녕 → ㅇㄴ)
 *
 * [반환값]
 * string: 추출된 초성 문자열이 반환됩니다.
 * ==========================
 */
초성추출(_inputString, _includeSpace := 0, _onlyKorean := 0)
{
	Loop, Parse, _inputString
	{	
		Tmp := Asc(A_LoopField) - 44032
		Cho := Floor(tmp / (21 * 28)) + 1
		
		if (_onlyKorean = 0)
		{
			if ((Cho < 0 || tmp > 11171) && A_LoopField != A_space)
				result .= A_LoopField
		}
		result .= _includeSpace != 0 && A_LoopField = A_Space ? A_Space : ChoSeong[Cho]
	}
	return result
}



/* =========================
 * 어절세기()함수는 주어진 문자열의 어절을 판단합니다.
 *
 * [매개변수 설명]
 * _inputString: 어절을 셀 문자열입니다.
 *
 * [반환값]
 * int: 어절의 개수
 *
 * [특이사항]
 * 1. 공백을 기준으로 어절을 셉니다. (수평 탭 X)
 * 2. 두 어절 사이에 몇 번의 공백이 있든, 하나의 공백으로 취급합니다.
 * ==========================
 */
어절세기(_inputString)
{
	result := 0
	Loop, Parse, _inputString, %A_Space%
	{
		if (A_loopfield = "")
			result--
		result++
	}
	return result
}



/* =========================
 * 한글조합()함수는 초,중,종성을 조합합니다.
 *
 * [매개변수 설명]
 * inputCho: 조합할 초성입니다.
 * inputJung: 조합할 중성입니다.
 * inputJong: 조합할 종성입니다.
 *
 * [반환값]
 * string: 조합된 글자
 *
 * [특이사항]
 * 1. 종성은 입력하지 않을 수 있습니다.
 * ==========================
 */
한글조합(inputCho, inputJung, inputJong := "")
{
	Jongindex := 0
	Loop, % ChoSeong.Length()
		if (inputCho = ChoSeong[A_Index])
			Choindex := A_index
	Loop, % JungSeong.Length()
		if (inputJung = JungSeong[A_Index])
			Jungindex := A_index
	if (inputJong != "")
		Loop, % JongSeong.Length()
			if (inputJong = JongSeong[A_Index])
				Jongindex := A_index
		
	tmp := Chr(0xAC00 + (((Choindex-1) * 21 + (Jungindex-1)) * 28 + Jongindex))
	result := Asc(tmp) > 44031 && ASC(tmp) < 55215 ? tmp : "ERROR"
	return result
}

/*
 * ###############################
 *
 * 개발용 함수
 * 라이브러리에서 직접 쓰는 함수입니다.
 *
 * ################################
 */
 
class 개발용
{
	모음에있냐(input:="")
	{
		Loop, 30
			if (JungSeong[A_index] == input)
				return A_index
		return false
	}
	
	자음에있냐(input:="")
	{
		Loop, 30
			if (ChoSeong[A_index] == input)
				return A_index
		return false
	}
}