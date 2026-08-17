# 핸드오프 — Tag / Chip 컴포넌트 분리

> 이 문서 하나로 다른 agent가 **KnittdaTag를 Tag(뜨개 태그)와 Chip(카테고리)로
> 분리**하는 작업을 동일하게 수행할 수 있도록, 목적·스타일·사용처·규약을 자체완결로 담는다.

## 0. 배경 & 목표

현재 `KnittdaTag`(outline/filled/grey 3스타일 + radius 옵션) 하나가 성격이 다른 두
용도를 겸하고 있다. 이를 **목적이 다른 두 컴포넌트로 분리**한다.

| | **KnittdaTag** (뜨개 태그) | **KnittdaChip** (카테고리) |
|---|---|---|
| 목적 | **선택 상태를 갖는** 뜨개 라벨 | **표시 전용** 카테고리 라벨 |
| 인터랙션 | 선택/해제(토글) | 없음(표시) |
| 상태/스타일 | **selected / disabled 2상태** | **outline / filled / grey 3스타일** |
| 텍스트 | 뜨개 태그(기분·상태) | 카테고리 텍스트 |
| radius | `AppRadius.tag`(**6**) | `AppRadius.chip`(**4**) |

목표:
1. `AppRadius.tag = 6` 토큰 신설(기존 `chip = 4` 유지).
2. **KnittdaTag** 재작성 → selected/disabled 2상태(아웃라인, radius tag).
3. **KnittdaChip** 신설(현 KnittdaTag의 3스타일 내용을 이관, radius chip).
4. 사용처를 Tag/Chip으로 각각 이전.
5. Figma·문서 동기화.

## 1. 컴포넌트 스타일 (정확한 스펙)

패딩 공통 `h: space8, v: space4`, 텍스트 `caption`(12).

### KnittdaTag (2상태, 아웃라인, radius `AppRadius.tag`=6)
- **selected**: 투명 배경 + `primary` 테두리(1) + `primary` 글씨.
- **disabled**(미선택): 투명 배경 + `grey400` 테두리(1) + `grey400` 글씨.
- API 제안: `KnittdaTag({required String label, bool selected = true})`.
  표시 전용(이미 선택된 태그 나열)은 기본 `selected: true`, 피커는 `selected: isSelected`.

### KnittdaChip (3스타일, radius `AppRadius.chip`=4)
- 현재 `knittda_tag.dart`의 내용을 그대로 이관(이름만 `KnittdaChip`/`KnittdaChipStyle`).
- **outline**: 투명 + `primary` 테두리 + `primary` 글씨.
- **filled**: `primary` 배경 + `white` 글씨.
- **grey**: `surfaceAlt` 배경 + `textSecondary` 글씨.
- API: `KnittdaChip({required String label, KnittdaChipStyle style = outline})`.

## 2. 파일 작업

- `lib/src/presentation/widgets/knittda_tag.dart` → **재작성**(2상태 Tag).
- `lib/src/presentation/widgets/knittda_chip.dart` → **신설**(현 knittda_tag.dart의 3스타일
  내용을 `KnittdaTag`→`KnittdaChip`, `KnittdaTagStyle`→`KnittdaChipStyle`로 이관).
- 두 위젯 모두 `import '.../core/theme/theme.dart';`로 토큰 접근.
- `AppRadius.tag = 6` 추가: `lib/src/core/theme/app_spacing.dart`의 `AppRadius`
  (`chip = 4` 아래). 주석 예: `/// 뜨개 태그(선택형).`

## 3. 사용처 이전 (정확한 위치, HEAD `5812c9a` 기준)

### → KnittdaTag (뜨개 태그)
| 위치 | 현재 | 변경 |
|---|---|---|
| `record_details_screen.dart:268` (`_RecordTags` Wrap) | `KnittdaTag(label: tag, radius: 6)` | `KnittdaTag(label: tag)` (selected 기본 true, radius 내장) |
| `feed/components/feed_item.dart:179` (`_FeedTags`) | 〃 | 〃 |
| `project_details/components/record_item.dart:148` (`_RecordTags`) | 〃 | 〃 |
| `record_add_edit/add_edit_record_screen.dart:262~300` **피커** | 인라인 `Container`(border/text = `isSelected ? PRIMARY : grey400`, radius pill) | `GestureDetector(onTap: 토글, child: KnittdaTag(label: tag, selected: isSelected))` — 인라인 Container 제거 |
| `project_details/components/progress_section.dart` "뜨고있어요/다떴어요" | pill 아웃라인 `TextButton`(primary) | (선택) `GestureDetector(onTap: onPressed, child: KnittdaTag(label, selected: true))` — 상태 토글 버튼. radius pill→6로 통일됨. **버튼 성격이라 borderline — 유지/이전은 작업자 판단** |

### → KnittdaChip (카테고리)
| 위치 | 현재 | 변경 |
|---|---|---|
| `article_list/components/article_card_small.dart:50` | `KnittdaTag(label: article.category)` | `KnittdaChip(label: article.category)` (기본 outline) |
| `announcement/components/announcement_list_item.dart:29` | `KnittdaTag(label: announcement.categoryLabel)` | `KnittdaChip(label: announcement.categoryLabel)` |

> import 교체 주의: 카테고리 파일은 `knittda_tag.dart` import → `knittda_chip.dart`로.
> 뜨개 파일은 `knittda_tag.dart` 유지.

### 제외
- `add_edit_record_screen.dart:313~357` "얼마나 떴나요?" — **원형 스텝 인디케이터**
  (선 위 점들), 태그 아님 → 건드리지 않음.

## 4. Figma 동기화

- **fileKey** `UFKXUOUJKrnxKKryVhSlH2` / DS 페이지 node **`2502:863`**.
- 현재 Figma **`Tag`** 컴포넌트(변형 `Style=Outline/Filled/Grey`)는 **실은 Chip**에
  해당 → **`Tag`→`Chip`으로 rename**(3스타일 유지).
- **새 `Tag` 컴포넌트 신설**: 변형 `State=Selected/Disabled`(아웃라인, selected=primary /
  disabled=grey400, radius 6, "태그" 텍스트).
- 쓰기는 `use_figma` + **`figma-use` 스킬 선로드 필수**
  (`ReadMcpResourceTool(server:"claude_ai_Figma", uri:"skill://figma/figma-use/SKILL.md")`).
- **폰트 제약**: MCP 환경 Pretendard 미설치 → 새 텍스트는 Noto Sans KR로 만들고
  Pretendard 텍스트 스타일은 `setTextStyleIdAsync`를 **마지막 쓰기**로 적용. 텍스트
  **fill 변경은 폰트 로드 불필요**(색만 바꿀 땐 자유).
- caption 스타일 id `S:781572904611bb8e0bc023a93562ce1684a21d05,`. primary 변수
  `VariableID:2504:3`, grey/400 `VariableID:2504:12`.

## 5. 저장소·규약 (중요)

- 메인 브랜치 `refactor/design-system-tokens`, HEAD `5812c9a`
  (`/Users/jisoolee/Downloads/knittda-frontend-beta`).
- **격리**: bg 잡은 worktree에서 편집 → 메인에 `git -C <메인> merge --ff-only <브랜치>`로 반영.
- **⚠️ 동시 작업 주의**: 최근 두 세션이 같은 `ds-work` 워크트리를 동시 편집해 사고가
  났다(`git add -A`가 상대 WIP를 함께 커밋 → 미완성 export로 메인 컴파일 깨짐).
  **`git add -A` 금지, 변경 파일만 명시적 `git add <file>`.** 가능하면 **별도 worktree**에서.
- 커밋 메시지 **Co-Authored-By 넣지 않음**. 네이밍 `Knittda*`.

## 6. 검증

- worktree엔 생성물(`*.freezed.dart`)이 없어 `flutter analyze`가 수백 에러(대부분
  기존 노이즈). **토큰/위젯 단독 분석은 깨끗해야**:
  `flutter analyze lib/src/core/theme lib/src/presentation/widgets/knittda_tag.dart lib/src/presentation/widgets/knittda_chip.dart` → No issues.
- 잔여 `KnittdaTag(` 는 뜨개 태그만, `KnittdaChip(`은 카테고리만인지 grep 확인.
- 값(radius/상태 색) 변경은 렌더 영향 → full restart로 육안 확인 권장.

## 7. 문서

- `docs/design_system/widgets.md`의 `## KnittdaTag` 섹션을 **KnittdaTag(2상태)** +
  **KnittdaChip(3스타일)** 두 섹션으로 분리해 갱신(옵션표·사용처·radius).
- 메모리 `project_design_system.md`에 분리 결과 1줄 추가.

## 8. 권장 순서

1. (별도) worktree 생성(`refactor/design-system-tokens` 기준).
2. `AppRadius.tag=6` 추가 → `knittda_chip.dart` 신설(현 tag 내용 이관) →
   `knittda_tag.dart` 재작성(2상태).
3. 사용처 이전(뜨개 3+피커1(+progress) → Tag / 카테고리 2 → Chip).
4. 토큰·위젯 단독 analyze 통과 → 변경 파일만 `git add` → 커밋 → 메인 FF 병합.
5. Figma(Tag rename→Chip, 새 Tag 신설) + 문서 갱신.
