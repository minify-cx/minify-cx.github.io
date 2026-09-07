(() => {
  const root = document.documentElement;
  const themeButtons = [...document.querySelectorAll('[data-theme-choice]')];
  const applyTheme = theme => {
    root.dataset.theme = theme;
    localStorage.setItem('minify-theme', theme);
    themeButtons.forEach(button => {
      button.classList.toggle('active', button.dataset.themeChoice === theme);
    });
  };

  applyTheme(localStorage.getItem('minify-theme') || 'system');
  themeButtons.forEach(button => {
    button.onclick = () => applyTheme(button.dataset.themeChoice);
  });

  const escapeHtml = source => source
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');

  const tokenize = (text, rules) => {
    const source = rules.map(rule => '(' + rule[0].source + ')').join('|');
    const re = new RegExp(source, 'gm');
    return text.replace(re, function () {
      for (let i = 0; i < rules.length; i++) {
        if (arguments[i + 1] !== undefined) {
          return '<span class="' + rules[i][1] + '">' + arguments[i + 1] + '</span>';
        }
      }
      return arguments[0];
    });
  };

  const highlightCode = (raw, language) => {
    const text = escapeHtml(raw);
    if (language === 'plaintext' || !language) return text;

    if (language === 'bash') {
      return tokenize(text, [
        [/^[ \t]*#.*$/m, 'com'],
        [/&quot;[^&\n]*?&quot;|'[^'\n]*?'/g, 'str'],
        [/(?:^|[\s])--?[a-zA-Z0-9][\w-]*/g, 'kw'],
        [/\b(make|curl|git|cmake|nift|minify|python3)\b/g, 'cmd']
      ]);
    }

    if (language === 'json') {
      return tokenize(text, [
        [/&quot;[^&\n]*?&quot;(?=\s*:)/g, 'key'],
        [/&quot;[^&\n]*?&quot;/g, 'str'],
        [/\b(true|false|null)\b/g, 'kw'],
        [/\b-?\d+(?:\.\d+)?\b/g, 'num']
      ]);
    }

    if (language === 'cpp') {
      return tokenize(text, [
        [/#(?:include|define|if|ifdef|ifndef|endif)[^\n]*/g, 'pre'],
        [/\/\/[^\n]*|\/\*[\s\S]*?\*\//g, 'com'],
        [/&quot;[^&\n]*?&quot;|'[^'\n]*?'/g, 'str'],
        [/\b(bool|char|class|const|double|else|enum|false|float|for|if|int|namespace|nullptr|private|public|return|std|string|struct|true|void|while)\b/g, 'kw'],
        [/\b\d+(?:\.\d+)?\b/g, 'num']
      ]);
    }

    if (language === 'javascript' || language === 'jsx') {
      return tokenize(text, [
        [/\/\/[^\n]*|\/\*[\s\S]*?\*\//g, 'com'],
        [/&quot;[^&\n]*?&quot;|'[^'\n]*?'|`[^`]*?`/g, 'str'],
        [/\b(import|export|from|default|function|class|extends|const|let|var|return|new|async|await|true|false|null)\b/g, 'kw'],
        [/\b\d+(?:\.\d+)?\b/g, 'num']
      ]);
    }

    return text;
  };

  document.querySelectorAll('pre code').forEach(code => {
    const raw = code.textContent;
    const languageClass = [...code.classList].find(name => name.startsWith('language-'));
    const language = languageClass ? languageClass.slice('language-'.length) : '';
    const highlighted = highlightCode(raw, language);

    code.innerHTML = highlighted;
    const button = document.createElement('button');
    button.className = 'copy';
    button.title = 'Copy';
    button.setAttribute('aria-label', 'Copy code');
    button.onclick = async () => {
      await navigator.clipboard.writeText(raw);
      button.classList.add('ok');
      setTimeout(() => button.classList.remove('ok'), 1200);
    };
    code.parentElement.appendChild(button);
  });
})();
