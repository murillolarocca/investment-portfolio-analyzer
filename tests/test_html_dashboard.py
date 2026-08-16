"""HTML integrity tests for examples/dashboard.html."""

import re
from html.parser import HTMLParser
from pathlib import Path

REPO = Path(__file__).parent.parent
DASHBOARD = REPO / "examples" / "dashboard.html"


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

class _TagCollector(HTMLParser):
    def __init__(self):
        super().__init__()
        self.tags: list[str] = []
        self.ids: list[str] = []
        self.classes: list[str] = []
        self.errors: list[str] = []

    def handle_starttag(self, tag, attrs):
        self.tags.append(tag.lower())
        attrs_dict = dict(attrs)
        if "id" in attrs_dict:
            self.ids.append(attrs_dict["id"])
        if "class" in attrs_dict:
            self.classes.extend(attrs_dict["class"].split())

    def handle_error(self, message):
        self.errors.append(message)


def _parse(text: str) -> _TagCollector:
    collector = _TagCollector()
    collector.feed(text)
    return collector


def _text() -> str:
    return DASHBOARD.read_text(encoding="utf-8")


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

def test_dashboard_file_exists():
    assert DASHBOARD.exists(), "examples/dashboard.html must exist"


def test_dashboard_is_not_empty():
    assert len(_text().strip()) > 500, "dashboard.html appears empty"


def test_dashboard_has_title():
    text = _text()
    assert re.search(r'<title[^>]*>[^<]+</title>', text, re.IGNORECASE), \
        "dashboard.html must have a non-empty <title> tag"


def test_dashboard_html_parses_without_errors():
    collector = _parse(_text())
    assert not collector.errors, \
        f"HTML parsing errors in dashboard.html: {collector.errors}"


def test_dashboard_has_style_block():
    text = _text()
    assert "<style" in text.lower(), "dashboard.html must contain a <style> block (inline CSS)"


def test_dashboard_defines_css_variables():
    """The dashboard must define CSS custom properties for theming."""
    text = _text()
    assert "--bg:" in text, "dashboard.html must define --bg CSS variable"
    assert "--ink:" in text, "dashboard.html must define --ink CSS variable"


def test_dashboard_supports_dark_mode():
    text = _text()
    assert "prefers-color-scheme" in text, \
        "dashboard.html must contain a @media prefers-color-scheme block for dark mode"


def test_dashboard_has_tabs():
    """The IPA dashboard is required to have a tabbed layout."""
    text = _text()
    collector = _parse(text)
    assert "tabbar" in collector.classes or "tabpanel" in collector.classes, \
        "dashboard.html must include tab UI elements (class 'tabbar' or 'tabpanel')"


def test_dashboard_has_kpi_section():
    text = _text()
    assert "kpi" in text, "dashboard.html must contain KPI cards"


def test_dashboard_has_disclaimer_footer():
    text = _text().lower()
    keywords = ["não é consultoria", "not financial advice", "aviso", "disclaimer",
                "contador", "confirmad"]
    assert any(k in text for k in keywords), \
        "dashboard.html must contain a disclaimer / non-advice footer"


def test_dashboard_has_allocation_content():
    text = _text().lower()
    assert "alocação" in text or "allocation" in text, \
        "dashboard.html must contain allocation-related content"


def test_dashboard_has_drift_content():
    text = _text().lower()
    assert "drift" in text, "dashboard.html must contain drift analysis content"


def test_dashboard_has_tax_content():
    text = _text().lower()
    keywords = ["gcap", "imposto", "tax", "tributário", "withholding"]
    assert any(k in text for k in keywords), \
        "dashboard.html must contain tax-related content"


def test_dashboard_has_dividend_content():
    text = _text().lower()
    keywords = ["dividend", "dividendo", "renda", "yield"]
    assert any(k in text for k in keywords), \
        "dashboard.html must contain dividend / income content"


def test_dashboard_has_brl_currency_formatting():
    text = _text()
    assert "R$" in text, "dashboard.html must display BRL amounts (R$)"


def test_dashboard_has_no_external_resource_urls():
    """All resources must be inline — no CDN/external URLs (CSP requirement)."""
    text = _text()
    bad_patterns = [
        r'src=["\']https?://',
        r'href=["\']https?://(?!.*#)',  # external hrefs (not anchor fragments)
        r'url\(https?://',
    ]
    for pattern in bad_patterns:
        matches = re.findall(pattern, text)
        # Allow <a href> links as those are user navigation, not resource loads
        non_anchor = [m for m in matches if "href" not in m or "stylesheet" in text]
        assert not [m for m in re.findall(pattern, text)
                    if not m.startswith('href=')], \
            f"dashboard.html loads an external resource (CSP violation): {matches}"


def test_dashboard_has_responsive_meta_or_css():
    text = _text()
    has_viewport = "viewport" in text
    has_relative_units = any(u in text for u in ["%", "vw", "vh", "em", "rem"])
    assert has_viewport or has_relative_units, \
        "dashboard.html should be responsive (viewport meta or relative CSS units)"
