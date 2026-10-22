# 핸드오프 — 레이아웃 토큰(AppLayout) 신설

> 이 문서 하나로 새 세션/다른 agent가 **레이아웃 토큰 작업**을 동일하게 수행할 수
> 있도록 필요한 컨텍스트(Figma·lib 구조·작업 목록·규약)를 자체완결로 담는다.

## 0. 목표 (이 작업이 할 일)

1. **`AppLayout` 레이아웃 토큰 신설** — 화면 가장자리 여백·스크롤 하단 여백 등
   "레이아웃 패턴"을 의미 토큰으로 정의(원자 간격 `AppSpacing` 위 계층).
2. **화면 가장자리 좌우 여백 통일** — 현재 16/20/24 혼재 → 하나로.
3. **오프스케일 하단 여백 토큰화** — `bottom: 50/80/120` 하드코딩 → `AppLayout` 참조.

배경: 원자 간격 토큰(`space0~40`)은 이미 있고 광범위 채택됨. 그러나 화면 레벨
여백/레이아웃 패턴이 미정립이라 화면마다 가장자리 여백·하단 인셋이 제각각.

## 1. 저장소·브랜치 상태 (중요)

- **메인 작업 브랜치**: `refactor/design-system-tokens`, HEAD `c2b3850`
  (`/Users/jisoolee/Downloads/knittda-frontend-beta`).
- **격리 규약(백그라운드 잡)**: 편집은 격리 워크트리에서. 기존 `.claude/worktrees/ds-work`
  worktree(브랜치 `ds-work`)를 쓰거나 새로 생성. 단, **디자인 시스템 파일 다수가
  untracked/미커밋이었어서** 과거엔 origin 기준 worktree가 비어 실패한 적 있음 —
  현재는 전부 커밋됨(`c2b3850`)이라 `git worktree add <path> refactor/design-system-tokens`로
  안전.
- **반영 경로(필수)**: 작업은 worktree 브랜치에 커밋 → **메인 체크아웃에 FF 병합**해야
  사용자 앱에 반영됨:
  `git -C /Users/jisoolee/Downloads/knittda-frontend-beta merge --ff-only <작업브랜치>`.
  (이 단계를 빼먹으면 "코드 고쳤는데 앱에 안 나옴"이 됨 — 실제로 발생했던 이슈.)
- **커밋 스타일**: Co-Authored-By 줄 넣지 않음.
- **네이밍 컨벤션**: 공용 위젯·토큰은 `Knittda*` / `AppXxx`.

## 2. 코드 토큰 계층 (여기에 AppLayout 추가)

`lib/src/core/theme/` — 배럴 `theme.dart`가 전부 export.

| 파일 | 내용 |
|---|---|
| `app_colors.dart` | `AppColors` (색). scrim/overlay 포함. |
| `app_spacing.dart` | `AppSpacing`(space0/4/8/12/16/20/24/32/40) + `AppRadius`(none0/chip4/button8/card10/pill20) |
| `app_typography.dart` | `AppFontSize`(xs10~display24)·`AppFontWeight`·`AppTextStyles`(display/title/heading/body/bodyStrong/caption, height 1.4) |
| `app_icon_size.dart` | `AppIconSize`(sm16/md20/base24/lg32/xl40) |
| `app_elevation.dart` | `AppElevation`(none/card) |
| `app_theme.dart` | `AppTheme.light` 전역 ThemeData |
| `theme.dart` | **배럴 export** — 새 `app_layout.dart` 추가 시 여기 export 추가 |

→ **`app_layout.dart` 신설 후 `theme.dart`에 `export 'app_layout.dart';` 추가.**
사용처는 `import 'package:knittda/src/core/theme/theme.dart';` 한 줄로 접근.

`AppLayout` 예시(값은 작업자가 확정):
```dart
class AppLayout {
  AppLayout._();
  /// 화면 좌우 가장자리 표준 여백.
  static const double screenPaddingH = AppSpacing.space20; // 16/20/24 → 20 통일 권장
  /// 스크롤 리스트 하단 인셋(FAB/하단 컨트롤 가림 방지).
  static const double scrollBottomInset = 80;   // projects(FAB)
  static const double formBottomInset = 48;     // 편집 폼(기존 50)
  static const double loginBottomInset = 120;   // 로그인(기존 120)
}
```
> 하단 인셋 50/80/120은 목적이 달라(폼 여유·FAB 가림·로그인 버튼) 단일값이 아님.
> 스케일(4배수) 강제보다 **목적별 레이아웃 토큰**으로 두는 게 맞음. 값은 작업자 판단.

## 3. 작업 목록 (구체 위치)

### 3-1. 오프스케일 하단 여백 → AppLayout (5곳)
| 위치 | 현재 | 목적 |
|---|---|---|
| `project_add_edit/add_edit_project_screen.dart:219` | `bottom: 50` | 편집 폼 하단 여유 |
| `record_add_edit/add_edit_record_screen.dart:248` | `bottom: 50` | 편집 폼 하단 여유 |
| `projects/projects_screen.dart:115` | `EdgeInsets.only(bottom: 80)` | FAB 가림 방지 |
| `article_detail/article_detail_screen.dart:239` | `only(bottom: 50, left/right: space20)` | 스크롤 하단 |
| `login/login_screen.dart:93` | `EdgeInsets.only(bottom: 120)` | 로그인 버튼 여유 |

### 3-2. 화면 가장자리 좌우 여백 통일 (혼재)
**주의**: 아래 중 위젯 내부 패딩(`widgets/knittda_*`)은 컴포넌트 자체 여백이라
**건드리지 말 것**. 화면(스크린) 가장자리만 `AppLayout.screenPaddingH`로 통일.
| 위치 | 현재 | 화면 edge? |
|---|---|---|
| `announcement_detail_screen.dart:42` | space20 | ✅ 화면 |
| `record_details_screen.dart:166` | space20 | ✅ 화면 |
| `article_detail/purchase_link_section_widget.dart:57` | space24 | ✅ 섹션(검토) |
| `project_add_edit/...:312` | space16 | ⚠️ 날짜 컨테이너 내부(검토) |
| `home/bottom_banner_overlay.dart:54,89` | space16/20 | ⚠️ 배너 내부(검토) |
| `widgets/knittda_button/input/list_item` | space16/20 | ❌ 위젯 내부 — 유지 |
> 스크린 파일 전반에 `EdgeInsets` 34곳 산재. 각 화면 `ListView`/`Padding`의
> **최상위(가장자리) 여백**만 대상. grep: `horizontal: AppSpacing.space(16|20|24)`.

## 4. Figma 디자인 시스템

- **fileKey**: `UFKXUOUJKrnxKKryVhSlH2` / DS 페이지 node **`2502:863`**.
- **MCP 도구**: `mcp__claude_ai_Figma__*`. 쓰기(`use_figma`)는 **`figma-use` 스킬 선로드 필수** —
  `ReadMcpResourceTool(server: "claude_ai_Figma", uri: "skill://figma/figma-use/SKILL.md")`.
  읽기: `get_metadata`·`get_screenshot`·`get_variable_defs`.
- **변수 컬렉션**: Primitives `2504:2` / Spacing `2504:184`(space/0…40) / Radius `2504:197`
  (radius/chip=**4**) / Color(semantic) `2505:2` / Icon `2559:4`.
- **폰트 제약(중요)**: 이 MCP 환경엔 **Pretendard 미설치**(Noto Sans KR만). 새 텍스트는
  Noto로 생성하고, Pretendard 텍스트 스타일은 `await node.setTextStyleIdAsync(styleId)`를
  **그 노드의 마지막 쓰기**로 적용(그 뒤 폰트 필요한 쓰기 금지 — "unloaded font" 에러).
- **레이아웃의 Figma화**: 레이아웃은 변수화가 어렵다(간격 변수 외엔 auto-layout이
  프레임별 처리). DS 페이지에 "Layout" 섹션으로 **문서/시각화**는 가능하나, 코드 쪽
  `AppLayout` 토큰이 소스 오브 트루스. 필수는 아님(선택).

## 5. 공용 위젯·문서

- 위젯: `lib/src/presentation/widgets/knittda_*.dart`
  (button/tag/card/input/list_item/app_bar/network_image/snack_bar/empty_state/loading/dialog).
- **위젯 문서**: `docs/design_system/widgets.md` — 위젯별 옵션·사용처·예외. 새 레이아웃
  래퍼(`KnittdaScreen` 등)를 만들면 여기에 섹션 추가.
- 메모리(누적 이력): `~/.claude/projects/.../memory/project_design_system.md`.

## 6. 검증 방법 (worktree 주의)

- **worktree엔 코드 생성물(`*.freezed.dart`/`*.g.dart`)이 없어** `flutter analyze`가
  수백 개 에러를 냄 — **대부분 기존 노이즈**(undefined getter/copyWith/uri_does_not_exist 등).
  판별: 토큰 파일 단독 분석(`flutter analyze lib/src/core/theme`)은 **깨끗해야** 함.
  변경 화면은 `grep -v`로 freezed/생성물 에러를 걸러 실오류만 확인.
- 값 변경(여백)은 렌더 영향 → 가능하면 hot restart로 화면 육안 확인 권장.

## 7. 권장 진행 순서

1. worktree 생성(`refactor/design-system-tokens` 기준) → `app_layout.dart` 신설 + 배럴 export.
2. 3-1 하단 여백 5곳 토큰화.
3. 3-2 화면 가장자리 여백을 `AppLayout.screenPaddingH`(20 권장)로 통일(위젯 내부 제외).
4. 토큰 파일 단독 analyze 통과 확인 → 커밋 → **메인에 FF 병합**.
5. `widgets.md`/메모리에 AppLayout 요약 추가.
