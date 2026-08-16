# Knittda 공용 위젯 (Design System Widgets)

앱 전반의 반복 UI를 디자인 토큰 기반 공용 위젯으로 통합한다. 위젯은
`lib/src/presentation/widgets/`에, 디자인은 Figma "디자인 시스템" 페이지
(fileKey `UFKXUOUJKrnxKKryVhSlH2`)의 컴포넌트와 1:1로 대응한다.

네이밍 컨벤션은 **`Knittda*`** 로 통일한다.

각 섹션은 **옵션 설명 / 사용되는 곳 / 사용하지 않은 경우(예외)** 순으로 기술한다.

---

## 색 토큰 사용 규칙 (AppColors)

`lib/src/core/theme/app_colors.dart`. 원시 중립색(`greyNNN`)과 **역할 의미 별칭**
(`textPrimary`/`textSecondary`/`textHint`/`border`/`surfaceAlt`)이 함께 있다.

> **규칙: 화면·컴포넌트는 역할이 맞는 의미 별칭을 쓴다. 원시 `greyNNN`은
> 별칭으로 표현되지 않는 용도(특정 채움·아이콘·플레이스홀더 배경 등)에만 쓴다.**

목적: `greyNNN`은 스케일이 조정되면 의미가 딸려 흔들린다. 텍스트·테두리·표면은
**역할 별칭**을 통해 참조하면 스케일 변경이 의미를 깨지 않는다.

| 역할 | 별칭 | 값 |
|---|---|---|
| 본문/제목 텍스트 | `textPrimary` | `black` |
| 보조 텍스트 | `textSecondary` | `grey800` |
| 힌트·비활성·플레이스홀더 텍스트 | `textHint` | `grey400` |
| 테두리 | `border` | `grey200` |
| muted 표면 | `surfaceAlt` | `grey100` |

### 적용 기준 (역할로 고른다)

- **텍스트 색**: `black`→`textPrimary`, `grey800`→`textSecondary`,
  `grey400`(힌트/비활성/플레이스홀더)→`textHint`. (Text·마크다운 `p`/`a`·TextSpan)
- **비(非)텍스트**는 별칭 강제 대상이 아니다: `Border`/`BorderSide`는 역할이
  테두리면 `border`, 그 외 채움·아이콘·배경(`CircleAvatar` bg, 이미지 플레이스홀더
  `Container` color, `Icon` color, `BottomNavigationBar` 속성 등)은 원시 `greyNNN` 유지.
- `caption` 프리셋 기본색이 이미 `textHint`이므로, caption 텍스트에 `grey400`을
  다시 지정하지 않는다(중복).

### 예외 / 미정 (별칭 없음)

| 원시색 | 상황 | 처리 |
|---|---|---|
| `grey600` | "보조 텍스트"로 3곳(projects_item·article_card_small)에 텍스트로 쓰이나 | `textSecondary`(800)/`textHint`(400) 어느 쪽도 아님. **텍스트 3단계(secondary/tertiary/hint) 확정 전까지 원시 `grey600` 유지.** 반복되면 `textTertiary` 별칭 신설 검토. |
| `grey50` | 배경 틴트 1곳 | 표면 계열. 반복되면 `surfaceTint` 등 검토. |

---

## 타이포그래피 프리셋 (AppTextStyles)

`lib/src/core/theme/app_typography.dart` (배럴 `theme.dart` export).

화면의 인라인 `TextStyle(fontSize:…, fontWeight:…)` 조립을 **의미 기반 프리셋**으로
통합한다. 프리셋은 `height: 1.4`(Figma 디자인 시스템 행간)를 포함하므로,
프리셋을 쓰면 Figma 렌더와 자동으로 정합된다.

| 프리셋 | 크기 | 굵기 | 용도 |
|---|---|---|---|
| `display` | 24 | semibold | 대형 히어로 제목(리포트·아티클 타이틀) |
| `title` | 20 | semibold | 화면/섹션 제목 |
| `heading` | 16 | semibold | 소제목·필드 라벨 |
| `body` | 14 | regular | 본문 기본 |
| `bodyStrong` | 14 | semibold | 강조 본문·리스트 항목명·버튼 |
| `caption` | 12 | regular | 보조·힌트·메타(기본색 `textHint`) |

### 사용 규칙

- 크기/굵기/행간은 **프리셋 그대로** 두고, 다른 축(색·decoration)만
  `.copyWith(color: …)`로 덮는다. **`fontSize`를 copyWith로 다시 지정하지 않는다.**
- 제목/헤딩의 `medium`(w500)은 **DS 표준인 semibold(w600)로 정규화**한다.
- `color: black`(=`textPrimary`)·`color: grey400`(=caption 기본 `textHint`)처럼
  프리셋 기본색과 같으면 `copyWith`를 생략한다.
- **버튼 등 `foregroundColor` 상속 컨텍스트**에서는 프리셋의 기본색이 상속색을
  덮어쓰므로, 원래 색(예: `white`)을 `copyWith(color:)`로 **명시**한다.

### 사용하지 않은 경우 (예외)

| 위치 | 값 | 이유 |
|---|---|---|
| `record_details`·`article_card_large`·`knittda_empty_state` | `lg`(16) regular | 16px **regular 본문**. 프리셋에 16-regular가 없고, `heading`(16 semibold)로 바꾸면 굵어짐 → `AppFontSize.lg` 토큰 유지. |
| `announcement_list_item` 날짜 | `xs`(10) | 프리셋 최소가 `caption`(12) → `AppFontSize.xs` 토큰 유지. |
| `report_screen` 히어로 제목 | `display` + **bold**(w700) | 강조 히어로. `display.copyWith(fontWeight: bold)`로 굵기만 덮음. |
| `Text.rich` 자식 `TextSpan` | 색만 | 부모 프리셋에서 크기·굵기·행간 상속, 색만 재정의(정상). |

> 남은 예외 4곳은 raw 숫자가 아니라 **`AppFontSize` 토큰**을 쓰므로 DS 규약 위반이
> 아니다. 16-regular·10px 프리셋이 반복 필요해지면 프리셋 신설을 검토한다.

---

## 레이아웃 토큰 (AppLayout)

`lib/src/core/theme/app_layout.dart` (배럴 `theme.dart` export).

원자 간격 토큰 `AppSpacing`("얼마나") 위 계층으로, 화면 레벨 여백/인셋
**패턴**("어디에 쓰는가")을 의미 단위로 정의한다. 값이 아니라 목적으로 고른다.

| 토큰 | 값 | 용도 |
|---|---|---|
| `AppLayout.screenPaddingH` | `AppSpacing.space20`(20) | 화면 좌우 가장자리 표준 여백. (기존 16/20/24 혼재 → 20 통일) |
| `AppLayout.contentBottomInset` | 48 | 스크롤 콘텐츠 하단 여유(마지막 항목이 화면 끝에 붙지 않게). 편집 폼·아티클 스크롤. (기존 50 → 48 정규화) |
| `AppLayout.fabBottomInset` | 80 | FAB가 리스트 마지막 항목을 가리지 않게 하는 하단 인셋. (projects) |
| `AppLayout.actionBottomInset` | 120 | 하단 고정 액션 버튼(로그인 등) 위 여유. |

> **주의**: 스크린 최상위(가장자리) 패딩에만 쓴다. 컴포넌트 내부 여백
> (`widgets/knittda_*`)이나 섹션 내부 버튼 인셋(예: `purchase_link_section` 버튼
> `horizontal:24`)은 컴포넌트 자체 여백이므로 건드리지 않는다.

### 채택된 곳

| 화면 | 토큰 |
|---|---|
| `add_edit_project_screen` / `add_edit_record_screen` 폼 하단 | `contentBottomInset` |
| `article_detail_screen` 스크롤 하단·좌우 | `contentBottomInset` / `screenPaddingH` |
| `projects_screen` 리스트 하단 | `fabBottomInset` |
| `login_screen` 버튼 영역 하단 | `actionBottomInset` |
| `announcement_detail_screen` / `record_details_screen` 좌우 가장자리 | `screenPaddingH` |

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

## KnittdaTag (뜨개 태그, 2상태)

`lib/src/presentation/widgets/knittda_tag.dart` · Figma `Tag`
(State=Selected/Disabled)

**선택 상태를 갖는** 뜨개 라벨. 아웃라인 2상태 고정, `caption` 크기,
radius `AppRadius.tag`(**6**). 인터랙션(토글)은 상위에서 `GestureDetector`로 감싼다.

### 옵션

| 옵션 | 타입 | 기본값 | 설명 |
|---|---|---|---|
| `label` | `String` | (필수) | 태그 문구. |
| `selected` | `bool` | `true` | 선택 상태. `true`=primary 테두리+글씨 / `false`=grey400 테두리+글씨(미선택). |

### 사용되는 곳 (4)

| 위치 | 용도 | selected |
|---|---|---|
| `record_details_screen`·`record_item` (`_RecordTags`) | 선택된 태그 나열 | 기본 `true` |
| `feed_item` (`_FeedTags`) | 선택된 태그 나열 | 기본 `true` |
| `add_edit_record_screen` (태그 피커) | 선택/해제 토글 | `isSelected` |

> **모서리 규칙**: 뜨개 태그는 `AppRadius.tag`(6). 카테고리는 `KnittdaChip`(radius 4).
> 표시 전용(이미 선택된 태그 나열)은 기본 `selected: true`, 피커는 `selected: isSelected`.

## KnittdaChip (카테고리, 3스타일)

`lib/src/presentation/widgets/knittda_chip.dart` · Figma `Chip`
(Style=Outline/Filled/Grey)

**표시 전용** 카테고리 라벨(인터랙션 없음). `caption` 크기 고정,
radius `AppRadius.chip`(**4**), **스타일 3종**.

### 옵션

| 옵션 | 타입 | 기본값 | 설명 |
|---|---|---|---|
| `label` | `String` | (필수) | 칩 문구. |
| `style` | `KnittdaChipStyle` | `outline` | `outline`(투명+primary 테두리) / `filled`(primary 채움+흰 글씨) / `grey`(surfaceAlt 배경+textSecondary). |

### 사용되는 곳 (2)

| 위치 | 스타일 |
|---|---|
| `article_card_small` (카테고리) | outline |
| `announcement_list_item` (카테고리) | outline |

> **분리 이력**: 기존 `KnittdaTag`(3스타일+radius 옵션)이 성격이 다른 두 용도를
> 겸하던 것을, 선택형 뜨개 태그(`KnittdaTag`, 2상태) + 표시용 카테고리
> (`KnittdaChip`, 3스타일)로 분리. `AppRadius.tag`(6) 신설. Figma `Tag`→`Chip` rename,
> 새 `Tag`(State=Selected/Disabled) 신설.

## KnittdaCard · KnittdaListItem (정의됨)

두 위젯은 Figma `Card`/`ListItem`과 1:1로 정의돼 있으나, **현재
코드의 인라인 대상들과 디자인이 달라** 채택하지 않았다(무리 적용 시 UI 훼손).

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

---

## KnittdaDialog

`lib/src/presentation/widgets/knittda_dialog.dart` · Figma `Dialog`

`showDialog(AlertDialog(...))` 확인 다이얼로그를 통합한 **정적 헬퍼**.
모서리 `AppRadius.card`, 제목 `heading`, 본문 `body`.

```dart
final ok = await KnittdaDialog.confirm(context,
  title: '작품 삭제', message: '정말 삭제하시겠습니까?',
  confirmLabel: '삭제', destructive: true);
```

### 옵션 (`confirm`)

| 옵션 | 타입 | 기본값 | 설명 |
|---|---|---|---|
| `title` | `String` | (필수) | 제목. |
| `message` | `String?` | `null` | 본문. |
| `cancelLabel` | `String` | `'취소'` | 취소 버튼(`textHint`). |
| `confirmLabel` | `String` | `'확인'` | 확인 버튼. |
| `destructive` | `bool` | `false` | true면 확인 버튼 `error` 색(삭제·탈퇴). |

**반환**: 확인=`true`, 취소·바깥탭=`false`(non-null).

### 사용되는 곳 (3)

| 위치 | 다이얼로그 |
|---|---|
| `popup_menu_section` | 작품 삭제 (destructive) |
| `edit_delete_menu` | 삭제 (destructive, 제목/본문 파라미터화) |
| `mypage_screen` | 회원탈퇴 (destructive) |

> Phase 1에서 KnittdaButton 예외로 뒀던 **다이얼로그 액션 버튼(취소/삭제/탈퇴)**을
> 이 헬퍼가 흡수했다.

---

## 미도입 (저우선 · 근거 부족)

| 후보 | 현황 | 판단 |
|---|---|---|
| **KnittDivider** | Divider/Border(bottom) ~10 | 구분선은 이미 대부분 컴포넌트 내부(KnittdaListItem·KnittdaAppBar)에 흡수됨. 남은 것은 화면별 1회성이 많아 위젯화 이득 작음. 반복 근거 쌓이면 도입. |
| **KnittFab** | FloatingActionButton 2 | 사용 2곳뿐(YAGNI). 3곳 이상 반복 시 도입. |
