# Knittda 공용 위젯 (Design System Widgets)

앱 전반의 반복 UI를 디자인 토큰 기반 공용 위젯으로 통합한다. 위젯은
`lib/src/presentation/widgets/`에, 디자인은 Figma "디자인 시스템" 페이지
(fileKey `UFKXUOUJKrnxKKryVhSlH2`)의 컴포넌트와 1:1로 대응한다.

네이밍 컨벤션은 **`Knittda*`** 로 통일한다.

각 섹션은 **옵션 설명 / 사용되는 곳 / 사용하지 않은 경우(예외)** 순으로 기술한다.

---

## KnittdaButton

`lib/src/presentation/widgets/knittda_button.dart` · Figma `Button`
(Style=Primary/Secondary/Text × State=Default/Disabled)

토큰 기반 버튼. 모서리는 항상 `AppRadius.button`(8), 텍스트는 `bodyStrong`,
패딩은 `space20 × space12`.

### 옵션

| 옵션 | 타입 | 기본값 | 설명 |
|---|---|---|---|
| `label` | `String` | (필수) | 버튼 텍스트. |
| `onPressed` | `VoidCallback?` | (필수) | 탭 콜백. **`null`이면 비활성(disabled)** 렌더. |
| `style` | `KnittdaButtonStyle` | `primary` | `primary`(초록 채움·흰 글씨) / `secondary`(흰 배경·테두리·초록 글씨) / `text`(투명·초록 글씨). |
| `expanded` | `bool` | `false` | `true`면 가로 100%(`double.infinity`). |

**상태별 색(자동)**: primary 비활성 → 배경 `grey400`. secondary/text 비활성 →
글씨 `textHint`, secondary 테두리 `grey200`.

### 사용되는 곳 (4)

| 화면 | style | 비고 |
|---|---|---|
| `add_edit_project_screen` 저장 | primary | 앱바 액션. `onPressed: isLoading ? null : _save` 로 비활성 연동 |
| `add_edit_record_screen` 저장 | primary | 동일 패턴 |
| `mypage_setting_nickname_screen` 저장 | primary | 인라인 검증 후 저장 |
| `projects_screen` 주간 리포트 확인 | secondary | 기존 primary 테두리 → DS 표준 `border`(grey)로 통일 |

### 사용하지 않은 경우 (예외)

| 위치 | 이유 |
|---|---|
| `bottom_banner_overlay` "하루 동안 보지 않기"·"닫기" | **컬러 배너 위 흰 글씨 CTA**. KnittdaButton.text는 초록 글씨 고정이라 대비가 안 맞음. |
| `purchase_link_section_widget` 구매 CTA | **pill 모양 풀폭 강조 버튼**(`AppRadius.pill`). KnittdaButton은 button 모서리(8) 고정. pill 강조 의도 보존. |
| `progress_section` 진행 토글 | **pill 아웃라인 + primary 테두리**. secondary(grey 테두리·button 모서리)와 형태가 달라 보존. |
| 다이얼로그 액션 6곳 (`mypage`·`popup_menu_section`·`edit_delete_menu`의 취소/삭제/탈퇴) | **AlertDialog 액션**. "삭제/탈퇴"는 error 색 파괴적 액션이라 별도 처리. → 향후 **KnittDialog** 위젯이 흡수 예정. |

> 확장 여지: pill 모양·파괴적(error) 스타일·아이콘 동반 버튼이 반복되면
> `shape`/`tone`/`icon` 옵션 추가를 검토한다(현재는 실사용 근거가 위 예외 소수뿐이라 미도입).
