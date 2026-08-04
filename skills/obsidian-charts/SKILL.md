---
name: obsidian-charts
description: "Chart implementation reference for Obsidian `dataviewjs` blocks: YAML chart-block mode (phibr0 plugin) and direct `window.renderChart` (Chart.js v3, including a top-of-bar labels plugin), with the standard color palette and known pitfalls."
when_to_use: "Use when building or debugging chart code inside an Obsidian `dataviewjs` block."
---

Build charts inside `dataviewjs` code blocks using the **obsidian-charts plugin** (phibr0).

## Two rendering modes

### 1. YAML chart block (simple — no data labels)

Output a fenced ` ```chart ``` ` block as a string and pass it to `dv.paragraph()`. Supported for line and bar charts.

```javascript
const NL = String.fromCharCode(10); // never use \n inside JS string literals in dataviewjs

function lineChart(labels, series) {
  return [
    '```chart', 'type: line',
    'labels: ' + JSON.stringify(labels),
    'series:', ...series,
    'tension: 0.3', 'width: 100%', 'labelColors: true',
    'transparency: 0.1', 'fill: false', 'beginAtZero: false',
    '```'
  ].join(NL);
}

// series item helper
function seriesYaml(title, data) {
  return [`  - title: "${title}"`, `    data: ${JSON.stringify(data)}`].join(NL);
}

dv.paragraph(lineChart(['Jan', 'Feb', 'Mar'], [seriesYaml('Sales', [10, 20, 15])]));
```

**Use this mode for:** line charts, when data labels above bars are not needed.

**Supported YAML options:** `type`, `labels`, `series`, `tension`, `width`, `labelColors`, `transparency`, `fill`, `beginAtZero`, `spanGaps`, `stacked`, `indexAxis`, `borderWidth`, `borderColor`, `pointStyle`.

**`dataLabels: true` does NOT exist in this plugin** — it is silently ignored.

---

### 2. window.renderChart (full Chart.js — supports data labels)

Use `window.renderChart(config, container)` to get access to Chart.js directly. Required whenever values need to appear above bars.

```javascript
const topLabelsPlugin = {
  id: 'topLabels',
  afterDatasetsDraw(chart) {
    const ctx = chart.ctx;
    ctx.save();
    ctx.font = 'bold 11px sans-serif';
    ctx.textAlign = 'center';
    ctx.textBaseline = 'bottom';
    chart.data.datasets.forEach((ds, di) => {
      const meta = chart.getDatasetMeta(di);
      if (meta.hidden) return;
      ds.data.forEach((val, i) => {
        if (val == null || val === 0) return;
        const bar = meta.data[i];
        if (!bar) return;
        ctx.fillStyle = '#666';
        ctx.fillText(String(val), bar.x, bar.y - 3);
      });
    });
    ctx.restore();
  }
};
```

**Container element:**

- **Single chart per dataviewjs block:** use `this.container` (the block's own container).
- **Multiple charts in one block:** create a fresh container per chart with `dv.el('div', '')`.

```javascript
// Multiple charts in one block
function renderBar(title, labelsArr, seriesArr) {
  dv.header(3, title);
  const el = dv.el('div', '');
  window.renderChart({
    type: 'bar',
    data: {
      labels: labelsArr,
      datasets: seriesArr.map((s, i) => ({
        label: s.title,
        data: s.data,
        backgroundColor: BAR_COLORS[i % BAR_COLORS.length][0],
        borderColor:     BAR_COLORS[i % BAR_COLORS.length][1],
        borderWidth: 1
      }))
    },
    options: {
      responsive: true,
      plugins: { legend: { display: true } },
      scales: { y: { beginAtZero: true } },
      layout: { padding: { top: 20 } }  // room for labels above tallest bar
    },
    plugins: [topLabelsPlugin]
  }, el);
}
```

**`plugins` is a top-level key** in the config object (Chart.js v3 per-chart plugin syntax), not inside `options`.

---

## Standard color palette

```javascript
const BAR_COLORS = [
  ['rgba(54,162,235,0.7)',  'rgba(54,162,235,1)'],   // blue
  ['rgba(255,159,64,0.7)', 'rgba(255,159,64,1)'],    // orange
  ['rgba(153,102,255,0.7)','rgba(153,102,255,1)'],   // purple
];
```

---

## Pitfalls

- **Never use `\n` inside JS string literals** in a dataviewjs block — it causes a SyntaxError when Obsidian parses the block. Always use `const NL = String.fromCharCode(10)` and build multi-line strings with `.join(NL)`.
- **Plugin id collisions:** if multiple `window.renderChart` calls share the same plugin object but register under the same `id`, Chart.js may warn. Give each plugin instance a unique `id` (`'topLabels'`, `'topLabels2'`, etc.) when rendering multiple charts.
- **`chartjs-plugin-datalabels` is not bundled** in the obsidian-charts plugin. Do not attempt to use it.
- **Dataview DataArray is not a plain array.** `dv.pages().map().filter()` returns a Dataview `DataArray`, which does not have `.reduce()`, `.indexOf()`, or other standard Array methods. Call `.array()` to convert before using them: `dv.pages().map(...).filter(...).array()`. `for...of` and `.length` work on DataArrays without conversion.
