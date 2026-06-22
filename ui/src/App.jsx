import { useState, useEffect } from 'react'
import './App.css'

const features = [
  { title: 'Powerlevel10k', desc: 'Classic prompt style with git status, execution time, virtualenv, and more.' },
  { title: 'Oh My Zsh', desc: '12 curated plugins — git, docker, npm, zoxide, extract, sudo, web-search, dirhistory & more.' },
  { title: 'Smart Navigation', desc: 'zoxide replaces cd with fuzzy muscle memory. fzf with Ctrl+R / Ctrl+T / Alt+C.' },
  { title: 'Syntax Highlighting', desc: 'Real-time zsh-syntax-highlighting + zsh-autosuggestions as you type.' },
  { title: 'Modern Aliases', desc: 'ls → eza with icons, lt → tree view, ff → fzf + bat preview. Git & docker shortcuts.' },
  { title: 'Cross-Platform', desc: 'Same great experience on macOS and Linux. Auto-detects Homebrew vs apt paths.' },
  { title: 'git-delta', desc: 'Syntax-highlighted git diffs with side-by-side navigation. Configured as default pager.' },
  { title: 'Performance', desc: 'History dedup, transient prompt, instant prompt. fastfetch shows system info on start.' },
  { title: 'NVM', desc: 'Node Version Manager pre-integrated. Switch Node versions seamlessly.' },
]

const testimonials = [
  { quote: 'Set up my entire dev environment in under 2 minutes. The aliases alone saved me hours of config tweaking.', author: 'Alex M.', role: 'Backend Engineer' },
  { quote: 'Switched from macOS to Linux and my terminal felt identical. Cross-platform support is a lifesaver.', author: 'Priya K.', role: 'Full-Stack Developer' },
  { quote: 'The eza + bat + fzf combination is incredible. I use ff (fzf preview) dozens of times a day now.', author: 'Jordan T.', role: 'DevOps Engineer' },
]

function App() {
  const [theme, setTheme] = useState(() => {
    if (typeof window !== 'undefined') {
      return localStorage.getItem('zsh-theme') || 'light'
    }
    return 'light'
  })

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('zsh-theme', theme)
  }, [theme])

  const toggleTheme = () => setTheme(t => t === 'light' ? 'dark' : 'light')

  const copyCmd = () => {
    navigator.clipboard.writeText('bash -c "$(curl -fsSL https://raw.githubusercontent.com/alivinshiva/zsh-setup/master/install.sh)"')
  }

  return (
    <div className="layout">
      <div className="topbar">
        <span className="topbar-brand">zsh-setup</span>
        <button className="theme-toggle" onClick={toggleTheme} aria-label="Toggle theme">
          {theme === 'light' ? (
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>
          ) : (
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="5"/><line x1="12" y1="1" x2="12" y2="3"/><line x1="12" y1="21" x2="12" y2="23"/><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"/><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"/><line x1="1" y1="12" x2="3" y2="12"/><line x1="21" y1="12" x2="23" y2="12"/><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"/><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"/></svg>
          )}
        </button>
      </div>

      <header className="hero">
        <div className="hero-badge">zsh-setup</div>
        <h1 className="hero-title">
          Your terminal,<br />
          <span className="hero-em">elevated.</span>
        </h1>
        <p className="hero-desc">
          A portable, cross-platform Oh My Zsh + Powerlevel10k configuration<br />
          with modern CLI tools, smart aliases, and performance tweaks.
        </p>
        <div className="hero-actions">
          <a href="https://github.com/alivinshiva/zsh-setup" className="btn btn-primary" target="_blank" rel="noopener noreferrer">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
            GitHub
          </a>
          <a href="https://github.com/alivinshiva/zsh-setup" className="btn btn-outline" target="_blank" rel="noopener noreferrer">
            View on GitHub →
          </a>
        </div>
      </header>

      <section className="section">
        <h2 className="section-title">Features</h2>
        <p className="section-sub">Everything you need for a modern terminal workflow.</p>
        <div className="grid">
          {features.map((f) => (
            <div key={f.title} className="card">
              <h3 className="card-title">{f.title}</h3>
              <p className="card-desc">{f.desc}</p>
            </div>
          ))}
        </div>
      </section>

      <section className="section section-alt">
        <h2 className="section-title">What people are saying</h2>
        <p className="section-sub">Loved by developers who value a polished terminal.</p>
        <div className="testimonials">
          {testimonials.map((t, i) => (
            <div key={i} className="testimonial-card">
              <svg className="testimonial-icon" width="20" height="20" viewBox="0 0 24 24" fill="currentColor" opacity="0.3"><path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10H14.017zM0 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151C7.546 6.068 5.983 8.789 5.983 11H10v10H0z"/></svg>
              <p className="testimonial-quote">{t.quote}</p>
              <div className="testimonial-author">
                <strong>{t.author}</strong>
                <span>{t.role}</span>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="section section-install">
        <h2 className="section-title">Installation</h2>
        <p className="section-sub">One command, fully automated. Works on macOS &amp; Linux.</p>
        <div className="install-block">
          <div className="install-header">
            <span className="install-label">curl</span>
            <button className="copy-btn" onClick={copyCmd} title="Copy to clipboard">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
            </button>
          </div>
          <pre className="install-code"><code>bash -c "$(curl -fsSL https://raw.githubusercontent.com/alivinshiva/zsh-setup/master/install.sh)"</code></pre>
        </div>
        <div className="install-alt">
          <p>Or clone &amp; run:</p>
          <pre className="install-code alt"><code>git clone https://github.com/alivinshiva/zsh-setup.git<br/>cd zsh-setup<br/>./install.sh</code></pre>
        </div>
      </section>

      <section className="section">
        <h2 className="section-title">Support the project</h2>
        <p className="section-sub">Star the repo, contribute, or help improve the setup.</p>
        <div className="cta-grid">
          <a href="https://github.com/alivinshiva/zsh-setup" className="cta-card" target="_blank" rel="noopener noreferrer">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
            <h3>Star on GitHub</h3>
            <p>Show your support by starring the repository.</p>
          </a>
          <a href="https://github.com/alivinshiva/zsh-setup/blob/master/CONTRIBUTING.md" className="cta-card" target="_blank" rel="noopener noreferrer">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            <h3>Contribute</h3>
            <p>Submit a PR, report a bug, or suggest a feature.</p>
          </a>
          <a href="https://github.com/alivinshiva/zsh-setup/issues" className="cta-card" target="_blank" rel="noopener noreferrer">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <h3>Report an Issue</h3>
            <p>Found a bug? Let us know on GitHub Issues.</p>
          </a>
        </div>
      </section>

      <footer className="footer">
        <div className="footer-inner">
          <span className="footer-brand">zsh-setup</span>
          <span className="footer-divider">·</span>
          <a href="https://github.com/alivinshiva/zsh-setup" target="_blank" rel="noopener noreferrer">GitHub</a>
          <span className="footer-divider">·</span>
          <a href="https://github.com/alivinshiva/zsh-setup/blob/master/CONTRIBUTING.md" target="_blank" rel="noopener noreferrer">Contributing</a>
          <span className="footer-divider">·</span>
          <span>MIT License</span>
        </div>
      </footer>
    </div>
  )
}

export default App
