> The v2 repository and library is also available in English.

> **Deprecated**: AutoHotkey v1.1 is deprecated now, So I will update a different repository with the new libraries that available in AHK v2.<br>
> **버전 지원 종료됨**: 오토핫키 v1.1 버전이 더이상 나오지 않으므로, v2에 대응되는 새 라이브러리를 다른 저장소에 업데이트 할 예정입니다.

New repo: https://github.com/devPnal/HanulModu

> The new library supports all language that can use dll file.
> 새 라이브러리 파일은 dll 파일을 사용할 수 있는 모든 언어에 대응됩니다.

# 모두의 한글

## 소개
'모두의 한글'은 오토핫키에서 한글을 가공하기 위한 라이브러리입니다

많은 질문/답변 활동을 해오면서 한글 조작에 관해 여쭤보시는 분들이 많았지만,  
기존의 한글 관련 함수들은 이곳 저곳 흩어져있으며, 너무 오래되거나 여러 군데에서 짜깁기한 코드가 많습니다.

따라서, 모두가 쉽고 편하게 오토핫키에서 한글을 다룰 수 있게 하기 위해 **새로 함수를 작성하고**,
이를 라이브러리로 묶어 배포하게 되었습니다.

처음부터 직접 개발하였기 때문에 많은 검증이 이루어지지 않았습니다. GitHub 기여 또한 환영입니다.

## 사용 환경
오토핫키 v1.1.31 이상 버전에서 작동합니다.
(v2 버전은 https://github.com/devPnal/every-hangul-v2 에서 사용 가능합니다.)


따라서, 2019년 10월 이전에 오토핫키를 다운로드 하신 분들은 최신 버전으로 업데이트 해주세요. (https://autohotkey.com)  
Unicode 지원 환경에서만 작동합니다. ANSI는 안돼요 노노.

압축 파일에 있는 [**호환성 체크.ahk**]를 실행하시면 사용할 수 있는 환경인지 확인해줍니다.

```This line does not contain a recognized action```  
▲ 이 오류가 뜬다면 지원되지 않는 오토핫키 버전이니, 꼭 업데이트 해주세요.

각종 함수들이 정상 동작하지 않는다면 동작 환경을 Unicode로 설정한 후 재실행해주세요.

## 사용법 (간략)
아래와 같이 임포트해서 사용하시면 됩니다.

```#include EveryHangul.ahk```

자세한 방법은 파일 내 '예제'와 라이브러리 내 주석을 참고해주세요.

## 제공 기능
- 한글 자소 분리 (안녕 → ㅇㅏㄴㄴㅕㅇ)
- 한글 영타로 변환 (안녕 → dkssud)
- 조사 자동으로 선택 (철수 → 철수'가'(철수'는', 철수'를', 철수'야' 등)
- 초/중/종성 임의로 뽑기
- 한/영 상태 체크와 한/영 변환
- 문자열에서 초성 추출하기 (안녕 → ㅇㄴ)
- 문장의 어절 수 가져오기 (동해 물과 백두산이 마르고 닳도록 → 5)
- 한글 자모 조합 (ㅎ,ㅣ,ㅎ → 힣)

## 라이선스(이용허가)
MIT 라이선스를 따릅니다.

간단한 라이선스 요약:
- 이 소프트웨어를 누구라도 무상으로 제한없이 취급해도 좋습니다.
- 제가 허가한 특별한 경우가 아닌 한, 저작권 표시 및 라이선스 허가 표시(LICENSE 파일)를 소프트웨어의 모든 복제물 또는 중요한 부분에 기재해야 합니다.
- 저자 또는 저작권자인 저는 소프트웨어에 관해서 아무런 책임을 지지 않습니다.

위 요약은 요약일 뿐이며, 전문 라이선스는 LICENSE 파일을 참고하시길 바랍니다.

## 연락처
이메일: contact@pnal.dev
