<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>example.local</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            position: relative;
            transition: background 0.5s ease;
        }

        @media (prefers-color-scheme: dark) {
            body {
                background: #0f172a;
                color: #e2e8f0;
            }
            
            .grid-background {
                position: absolute;
                width: 100%;
                height: 100%;
                background-image: 
                    linear-gradient(rgba(99, 102, 241, 0.03) 1.5px, transparent 1.5px),
                    linear-gradient(90deg, rgba(99, 102, 241, 0.03) 1.5px, transparent 1.5px);
                background-size: 60px 60px;
                background-position: center center;
            }
            
            h1 {
                color: #e2e8f0;
                font-weight: 700;
                letter-spacing: -0.03em;
            }
            
            .dot {
                color: #6366f1;
            }
        }

        @media (prefers-color-scheme: light) {
            body {
                background: #f1f5f9;
                color: #0f172a;
            }
            
            .grid-background {
                position: absolute;
                width: 100%;
                height: 100%;
                background-image: 
                    linear-gradient(rgba(148, 163, 184, 0.08) 1.5px, transparent 1.5px),
                    linear-gradient(90deg, rgba(148, 163, 184, 0.08) 1.5px, transparent 1.5px);
                background-size: 60px 60px;
                background-position: center center;
            }
            
            h1 {
                color: #0f172a;
                font-weight: 700;
                letter-spacing: -0.03em;
            }
            
            .dot {
                color: #6366f1;
            }
        }

        .container {
            position: relative;
            text-align: center;
            z-index: 10;
            perspective: 1000px;
        }

        h1 {
            font-size: 4rem;
            position: relative;
            animation: fadeInUp 1.2s cubic-bezier(0.22, 1, 0.36, 1);
            display: inline-block;
        }

        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .particle {
            position: fixed;
            pointer-events: none;
            z-index: 5;
            border-radius: 50%;
            width: 4px;
            height: 4px;
        }

        @media (prefers-color-scheme: dark) {
            .particle {
                animation: convergeParticleDark 2.5s cubic-bezier(0.22, 1, 0.36, 1) forwards;
            }
        }

        @media (prefers-color-scheme: light) {
            .particle {
                animation: convergeParticleLight 2.5s cubic-bezier(0.22, 1, 0.36, 1) forwards;
            }
        }

        @keyframes convergeParticleDark {
            0% {
                transform: translate(0, 0) scale(0);
                opacity: 0;
            }
            15% {
                opacity: 1;
            }
            85% {
                opacity: 1;
            }
            100% {
                transform: translate(var(--target-x), var(--target-y)) scale(1);
                opacity: 0;
            }
        }

        @keyframes convergeParticleLight {
            0% {
                transform: translate(0, 0) scale(0);
                opacity: 0;
            }
            15% {
                opacity: 0.8;
            }
            85% {
                opacity: 0.8;
            }
            100% {
                transform: translate(var(--target-x), var(--target-y)) scale(1);
                opacity: 0;
            }
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="grid-background"></div>
    
    <div class="container">
        <h1>example<span class="dot">.</span>local</h1>
    </div>

    <script>
        const isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

        const colorsDark = [
            '#6366f1', // Indigo
            '#8b5cf6', // Violet
            '#ec4899', // Pink
            '#f59e0b', // Amber
            '#10b981', // Emerald
            '#06b6d4', // Cyan
            '#3b82f6', // Blue
            '#a855f7', // Purple
            '#14b8a6', // Teal
            '#f97316', // Orange
        ];

        const colorsLight = [
            '#6366f1', // Indigo
            '#8b5cf6', // Violet
            '#ec4899', // Pink
            '#f59e0b', // Amber
            '#10b981', // Emerald
            '#06b6d4', // Cyan
            '#3b82f6', // Blue
            '#a855f7', // Purple
            '#14b8a6', // Teal
            '#f97316', // Orange
        ];

        function getDotPosition() {
            const dot = document.querySelector('.dot');
            const rect = dot.getBoundingClientRect();
            
            const centerX = rect.left + (rect.width / 2);
            const threeQuartersY = rect.top + (rect.height * 3 / 4);
            
            return {
                x: centerX,
                y: threeQuartersY
            };
        }

        function createParticle() {
            const particle = document.createElement('div');
            particle.classList.add('particle');
            
            const angle = Math.random() * Math.PI * 2;
            const distance = 400 + Math.random() * 400;
            const startX = Math.cos(angle) * distance;
            const startY = Math.sin(angle) * distance;
            
            particle.style.left = (window.innerWidth / 2 + startX) + 'px';
            particle.style.top = (window.innerHeight / 2 + startY) + 'px';
            
            const dotPos = getDotPosition();
            const targetX = dotPos.x - (window.innerWidth / 2 + startX);
            const targetY = dotPos.y - (window.innerHeight / 2 + startY);
            
            particle.style.setProperty('--target-x', targetX + 'px');
            particle.style.setProperty('--target-y', targetY + 'px');
            
            const colors = isDark ? colorsDark : colorsLight;
            const color = colors[Math.floor(Math.random() * colors.length)];
            
            particle.style.backgroundColor = color;
            particle.style.boxShadow = `
                0 0 10px ${color},
                0 0 20px ${color}
            `;
            
            particle.style.animationDelay = Math.random() * 0.3 + 's';
            
            document.body.appendChild(particle);
            
            setTimeout(() => {
                particle.remove();
            }, 3000);
        }

        window.addEventListener('load', () => {
            setTimeout(() => {
                for (let i = 0; i < 200; i++) {
                    setTimeout(() => createParticle(), i * 10);
                }
            }, 600);
        });
    </script>
</body>
</html>