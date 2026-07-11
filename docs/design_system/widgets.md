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

---

## KnittdaEmptyState

`lib/src/presentation/widgets/knittda_empty_state.dart` · Figma `EmptyState`

리스트가 비었거나 대상을 찾지 못했을 때 화면 중앙에 안내. 메시지는 `lg`·`grey400`.

### 옵션

| 옵션 | 타입 | 기본값 | 설명 |
|---|---|---|---|
| `message` | `String` | (필수) | 안내 문구. 중앙 정렬. |
| `icon` | `IconData?` | `null` | 문구 위 아이콘(`grey400`·`AppIconSize.xl`). 생략 시 문구만. |
| `action` | `Widget?` | `null` | 문구 아래 액션(예: 새로고침 버튼). |

### 사용되는 곳 (7)

| 화면 | 문구 |
|---|---|
| `projects_screen` | 작품이 없습니다 |
| `article_list_screen` | 아티클이 없습니다. |
| `announcement_screen` | 등록된 공지가 없습니다 |
| `announcement_detail_screen` | 공지를 찾을 수 없습니다 |
| `article_detail_screen` | 아티클을 찾을 수 없습니다. |
| `feed_search_screen` | 검색어를 입력해주세요 / "{키워드}" 에 대한 결과가 없습니다. |

> 현재 사용처는 전부 **아이콘 없이 문구만**(기존 UI 보존). `icon`은 향후 빈
> 상태를 더 풍부하게 만들 때 사용. Figma 컴포넌트는 아이콘 포함 형태를 제시.

### 사용하지 않은 경우 (예외)

| 위치 | 이유 |
|---|---|
| `SnackBar` 오류 메시지("링크를 열 수 없습니다" 등) | 빈 상태가 아니라 **일시적 알림** → `KnittdaSnackBar` 담당. |

---

## KnittdaSnackBar

`lib/src/presentation/widgets/knittda_snack_bar.dart` · Figma `Snackbar`
(Tone=Info/Success/Error)

`ScaffoldMessenger...showSnackBar(SnackBar(...))` 반복을 통합한 **정적 헬퍼**.
호출 전 `hideCurrentSnackBar`로 중복을 막고, floating·`AppRadius.button`·흰
`caption` 텍스트로 고정한다.

```dart
KnittdaSnackBar.show(context, '저장했어요', tone: KnittdaSnackTone.success);
```

### 옵션

| 옵션 | 타입 | 기본값 | 설명 |
|---|---|---|---|
| `context` | `BuildContext` | (필수) | ScaffoldMessenger 조회용. |
| `message` | `String` | (필수) | 표시 문구. |
| `tone` | `KnittdaSnackTone` | `info` | `success`→`primary` / `error`→`error` / `info`→`grey800`. |

### 사용되는 곳 (29)

두 갈래로 쓰인다.
- **직접 호출**: `launchUrl` 실패, 권한 안내 등 화면에서 즉시(purchase_link·note_section·mypage·report·record_add_edit 등).
- **이벤트 구동**: ViewModel이 `XxxUiEvent.showSnackBar(msg)`를 발행 → 화면
  `eventStream` 핸들러의 `case ShowSnackBar(:final message)`에서 `KnittdaSnackBar.show(context, message)` 호출(add_edit_project·record_details·project_details·login·feed_search·mypage(_setting_nickname)·add_edit_record).

### 사용하지 않은 경우 (예외)

| 위치 | 이유 |
|---|---|
| `ViewModel`의 `UiEvent.showSnackBar(...)` | SnackBar를 만드는 게 아니라 **이벤트 메시지 페이로드**. 화면 핸들러가 받아 `KnittdaSnackBar.show`를 호출하므로 그대로 둔다(아키텍처상 정상). |

---

## KnittdaLoadingView / KnittdaLoadingOverlay

`lib/src/presentation/widgets/knittda_loading.dart` · Figma `Loading`
(State=Inline/Overlay)

로딩 인디케이터를 `primary` 색으로 통일한다.

### KnittdaLoadingView

중앙 `primary` 스피너. **옵션 없음**(색·정렬 고정).

**사용되는 곳 (10)**: project_previews · announcement(_detail) · feed(_search) ·
article_detail · article_list · project_details 등의 "화면/영역 로딩" 자리.
기존 `Center(child: CircularProgressIndicator())`를 대체.

### KnittdaLoadingOverlay

`AbsorbPointer` + `AppColors.scrim` 딤 + 중앙 스피너. **`Stack`의
`Positioned.fill` 자식**으로 배치.

```dart
Stack(children: [
  content,
  if (state.isLoading) const Positioned.fill(child: KnittdaLoadingOverlay()),
]);
```

**사용되는 곳 (3)**: add_edit_project · add_edit_record · login (저장/로그인 처리 중 화면 딤).

### 사용하지 않은 경우 (예외)

| 위치 | 이유 |
|---|---|
| record_details "기록 불러오는 중…" + 스피너 컬럼 | **문구 동반 로딩**. LoadingView(스피너만)와 형태가 달라 보존. |
| 리스트 하단 `isLoadingMore` 인디케이터 | **더 불러오기** 전용(페이지네이션). 화면 로딩과 의미가 달라 별도. |

---

## KnittdaInput

`lib/src/presentation/widgets/knittda_input.dart` · Figma `Input`
(State=Default/Focused/Error)

`TextFormField` 래퍼. 테두리 상태색(기본 `border`/포커스 `primary`/에러 `error`)을
토큰으로 고정. `AppRadius.button` 모서리.

### 옵션

| 옵션 | 타입 | 기본값 | 설명 |
|---|---|---|---|
| `controller` | `TextEditingController?` | `null` | |
| `hintText` | `String?` | `null` | 플레이스홀더. |
| `errorText` | `String?` | `null` | 있으면 에러 테두리. |
| `onChanged` | `ValueChanged<String>?` | `null` | |
| `obscureText` | `bool` | `false` | 비밀번호 마스킹. |
| `keyboardType` | `TextInputType?` | `null` | 멀티라인 등. |
| `maxLines` | `int` | `1` | |
| `maxLength` | `int?` | `null` | 글자 수 제한·카운터. |
| `enabled` | `bool` | `true` | |

### 사용되는 곳 (7)

| 화면 | 필드 |
|---|---|
| `add_edit_project_screen` | 작품 이름·도안명·작가·실·바늘 (5) |
| `mypage_setting_nickname_screen` | 닉네임(`enabled: !isLoading`) |
| `add_edit_record_screen` | 기록 내용(멀티라인 `maxLines: 8`) |

### 사용하지 않은 경우 (예외)

| 위치 | 이유 |
|---|---|
| `feed_search_screen` 검색 필드 | **prefix(검색)·suffix(X) 아이콘** 동반. KnittdaInput은 아이콘 미지원. 아이콘 슬롯 추가 시 흡수 가능. |

---

## KnittdaBadge · KnittdaCard · KnittdaListItem (정의됨)

세 위젯은 Figma `Badge`/`Card`/`ListItem`과 1:1로 정의돼 있으나, **현재
코드의 인라인 대상들과 디자인이 달라** 대부분 채택하지 않았다(무리 적용 시 UI 훼손).

### KnittdaBadge

`knittda_badge.dart` — filled 배지(`primary`/`neutral` 톤, `AppRadius.chip`, caption).
옵션: `label`, `tone`.
- **채택 (1)**: `announcement_list_item` 카테고리 라벨.
- **예외**: `_RecordTags`/`_FeedTags`(**pill 아웃라인**·primary 테두리·투명),
  `_CategoryTag`(**filled primaryLight**·card 모서리). 셋 다 KnittdaBadge(filled
  primary·chip)와 형태가 달라 보존. → 통합하려면 KnittdaBadge에 `outline`·`pill`·
  `primaryLight` 변형 추가 필요(태그 디자인 통일 결정 후 진행 권장).

### KnittdaListItem

`knittda_list_item.dart` — 썸네일+제목+부제+chevron+하단 divider. 옵션:
`title`, `subtitle`, `leading`, `onTap`, `showChevron`.
- **채택 (0)**.
- **예외**: 현재 `ListTile` 6곳은 전부 **바텀시트 메뉴 행**(제목+onTap만, 썸네일·
  chevron 없음)이라 KnittdaListItem(썸네일·chevron·divider 강제)과 안 맞음. 시트
  메뉴용 경량 변형이 필요하면 별도 위젯 검토.

### KnittdaCard

`knittda_card.dart` — 흰 표면·테두리·`AppRadius.card`·선택 그림자. 옵션:
`child`, `padding`, `onTap`, `elevated`.
- **채택 (0)**.
- **예외**: 현재 카드형은 대부분 **이미지+그라디언트 오버레이**를 가진 커스텀
  카드(article_card_large 등)라 단순 컨테이너 KnittdaCard와 구조가 다름. 순수
  컨테이너 카드가 생기면 우선 채택.
