"""Skill file integrity checks."""

import re
from pathlib import Path

REPO = Path(__file__).parent.parent
SKILL_MD = REPO / "skill" / "SKILL.md"
REFS_DIR = REPO / "skill" / "references"

EXPECTED_REFS = [
    "allocation-framework.md",
    "tax-brazil.md",
    "tax-usa.md",
    "dividend-analysis.md",
]

REQUIRED_SKILL_SECTIONS = [
    "Passo 1",
    "Passo 2",
    "Passo 3",
    "Passo 4",
    "Passo 5",
]

REQUIRED_FRONTMATTER_KEYS = ["name", "description"]


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _skill_text() -> str:
    return SKILL_MD.read_text(encoding="utf-8")


def _ref_text(filename: str) -> str:
    return (REFS_DIR / filename).read_text(encoding="utf-8")


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

def test_skill_md_exists():
    assert SKILL_MD.exists(), "skill/SKILL.md must exist"


def test_all_reference_files_exist():
    for ref in EXPECTED_REFS:
        path = REFS_DIR / ref
        assert path.exists(), f"Missing reference file: skill/references/{ref}"


def test_skill_md_has_yaml_frontmatter():
    text = _skill_text()
    assert text.startswith("---"), "SKILL.md must start with YAML frontmatter (---)"
    end = text.index("---", 3)
    frontmatter = text[3:end]
    for key in REQUIRED_FRONTMATTER_KEYS:
        assert f"{key}:" in frontmatter, f"Frontmatter missing key: {key}"


def test_skill_md_has_required_steps():
    text = _skill_text()
    for section in REQUIRED_SKILL_SECTIONS:
        assert section in text, f"SKILL.md missing required section: {section}"


def test_skill_md_references_resolve():
    """Every references/... link in SKILL.md must point to an existing file."""
    text = _skill_text()
    links = re.findall(r'\(references/([^)]+\.md)\)', text)
    assert links, "SKILL.md should contain at least one reference link"
    for link in links:
        path = REFS_DIR / link
        assert path.exists(), f"Broken reference link in SKILL.md: references/{link}"


def test_skill_md_has_privacy_statement():
    text = _skill_text()
    assert "localmente" in text.lower() or "locally" in text.lower(), \
        "SKILL.md must contain a privacy/local-processing statement"


def test_skill_md_has_disclaimer():
    text = _skill_text()
    keywords = ["consultoria", "não é", "aviso", "disclaimer", "licenciada"]
    assert any(k in text.lower() for k in keywords), \
        "SKILL.md must contain a disclaimer that this is not licensed financial advice"


def test_tax_brazil_mentions_gcap():
    text = _ref_text("tax-brazil.md")
    assert "GCAP" in text or "ganho de capital" in text.lower(), \
        "tax-brazil.md must mention GCAP / ganho de capital"


def test_tax_brazil_mentions_exemption_limit():
    text = _ref_text("tax-brazil.md")
    assert "20.000" in text or "20000" in text, \
        "tax-brazil.md must mention the R$20,000/month exemption limit"


def test_tax_usa_mentions_nra():
    text = _ref_text("tax-usa.md")
    assert "NRA" in text or "Non-Resident" in text or "não residente" in text.lower(), \
        "tax-usa.md must mention NRA (Non-Resident Alien) status"


def test_tax_usa_mentions_withholding():
    text = _ref_text("tax-usa.md")
    assert "withholding" in text.lower() or "retenção" in text.lower(), \
        "tax-usa.md must mention dividend withholding"


def test_allocation_framework_mentions_moderate_profile():
    text = _ref_text("allocation-framework.md")
    assert "moderado" in text.lower() or "moderate" in text.lower(), \
        "allocation-framework.md must describe the moderate risk profile"


def test_allocation_framework_percentages_are_plausible():
    """All percentage values found must be between 0 and 100."""
    text = _ref_text("allocation-framework.md")
    pcts = [int(m) for m in re.findall(r'\b(\d{1,3})%', text)]
    assert pcts, "allocation-framework.md should contain percentage values"
    for p in pcts:
        assert 0 <= p <= 100, f"Implausible percentage in allocation-framework.md: {p}%"


def test_dividend_analysis_mentions_withholding_for_usa():
    text = _ref_text("dividend-analysis.md")
    assert "30%" in text or "withholding" in text.lower(), \
        "dividend-analysis.md must mention the 30% US dividend withholding for NRA"


def test_dividend_analysis_mentions_jcp():
    text = _ref_text("dividend-analysis.md")
    assert "JCP" in text or "juros sobre capital" in text.lower(), \
        "dividend-analysis.md must mention JCP and its 15% source withholding"


def test_no_reference_file_is_empty():
    for ref in EXPECTED_REFS:
        text = _ref_text(ref)
        assert len(text.strip()) > 100, \
            f"Reference file appears empty or too short: skill/references/{ref}"


def test_skill_md_not_empty():
    text = _skill_text()
    assert len(text.strip()) > 200, "SKILL.md appears empty or too short"
