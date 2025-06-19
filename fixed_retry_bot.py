import pyautogui
import time
import os
import sys
import cv2
import numpy as np
try:
    import pytesseract
    TESSERACT_AVAILABLE = True
except ImportError:
    TESSERACT_AVAILABLE = False

# --- CONFIGURAZIONE DI PRECISIONE ---
# Posizione di riposo del mouse al CENTRO dello schermo
def get_center_position():
    screen_width, screen_height = pyautogui.size()
    return (screen_width // 2, screen_height // 2)

# SOGLIA DI CERTEZZA: L'OCR deve essere sicuro almeno al 65% che il testo sia "Retry".
OCR_CONFIDENCE_THRESHOLD = 65

# Intervalli
SCAN_INTERVAL_SECONDS = 2
WAIT_AFTER_CLICK_SECONDS = 8

def find_button_candidates(screenshot_np):
    """
    FASE 1: PROPONI. Trova tutti i potenziali pulsanti (candidati) basandosi sulla forma.
    Restituisce una lista di rettangoli (x, y, w, h). NON muove il mouse.
    """
    candidates = []
    try:
        gray = cv2.cvtColor(screenshot_np, cv2.COLOR_RGB2GRAY)
        edges = cv2.Canny(gray, 50, 150)
        contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        
        for contour in contours:
            area = cv2.contourArea(contour)
            if 500 < area < 8000: # Filtro per area plausibile
                x, y, w, h = cv2.boundingRect(contour)
                aspect_ratio = w / h if h > 0 else 0
                if 1.5 < aspect_ratio < 8: # Filtro per forma plausibile (più largo che alto)
                    candidates.append((x, y, w, h))
        return candidates
    except Exception:
        return []

def verify_candidate_is_retry(button_image_np):
    """
    FASE 2: VERIFICA. Esegue un OCR di precisione su un piccolo ritaglio di un candidato.
    Restituisce True solo se trova 'Retry' con alta confidenza.
    """
    try:
        data = pytesseract.image_to_data(button_image_np, output_type=pytesseract.Output.DICT, config='--psm 7')
        for i, text in enumerate(data['text']):
            if text.strip().lower() == 'retry':
                confidence = int(data['conf'][i])
                if confidence >= OCR_CONFIDENCE_THRESHOLD:
                    print(f"    [+] VERIFICA OK: Trovato 'Retry' con certezza del {confidence}%.")
                    return True # CERTEZZA RAGGIUNTA
        return False # Non è lui o la confidenza è troppo bassa
    except Exception:
        return False

def execute_click_and_reset(x, y, side=""):
    """
    FASE 3: ESEGUI. Muove il mouse, clicca e torna al CENTRO dello schermo.
    Questa funzione viene chiamata SOLO quando c'è certezza al 100%.
    """
    center_pos = get_center_position()
    print(f"[!] BERSAGLIO CONFERMATO {side}. Inizio azione...")
    pyautogui.moveTo(x, y, duration=0.4)
    pyautogui.click()
    print(f"    [+] CLICK ESEGUITO su ({x}, {y}) {side}.")
    time.sleep(1) # Breve pausa post-click
    print(f"    [+] Ritorno al centro dello schermo {center_pos}.")
    pyautogui.moveTo(center_pos, duration=0.5)

def scan_region(region_name, region_coords):
    """
    Scansiona una specifica regione dello schermo alla ricerca di pulsanti Retry.
    Restituisce le coordinate assolute del pulsante se trovato, altrimenti None.
    """
    try:
        screenshot = pyautogui.screenshot(region=region_coords)
        screenshot_np = cv2.cvtColor(np.array(screenshot), cv2.COLOR_RGB2BGR)
        
        # FASE 1: PROPONI
        candidates = find_button_candidates(screenshot_np)
        
        if candidates:
            # FASE 2: VERIFICA
            for (x, y, w, h) in candidates:
                button_snippet = screenshot_np[y:y+h, x:x+w]
                
                if verify_candidate_is_retry(button_snippet):
                    # BERSAGLIO CONFERMATO! Calcola le coordinate assolute
                    abs_x = region_coords[0] + x + w // 2
                    abs_y = region_coords[1] + y + h // 2
                    return (abs_x, abs_y, region_name)
        
        return None
    except Exception as e:
        print(f"    [!] Errore nella scansione {region_name}: {e}")
        return None

def main():
    """Bot principale con protocollo di sicurezza "Proponi e Verifica" - DUAL SCREEN."""
    pyautogui.FAILSAFE = True
    
    # Calcola le dimensioni dello schermo e definisce le regioni
    screen_width, screen_height = pyautogui.size()
    center_pos = get_center_position()
    
    # Definisci le due regioni: sinistra e destra
    left_region = (0, screen_height // 2, screen_width // 2, screen_height // 2)
    right_region = (screen_width // 2, screen_height // 2, screen_width // 2, screen_height // 2)
    
    print("=" * 80)
    print("🤖 BOT DUAL SCREEN - PROTOCOLLO 'PROPONI E VERIFICA'")
    print("=" * 80)
    print(f"[*] STATO: Ricerca passiva. Il mouse è bloccato a {center_pos} (CENTRO).")
    print(f"[*] SOGLIA DI CERTEZZA: {OCR_CONFIDENCE_THRESHOLD}%")
    print(f"[*] REGIONI MONITORATE:")
    print(f"    • SINISTRA: {left_region}")
    print(f"    • DESTRA: {right_region}")
    print(f"[*] Il mouse si muoverà SOLO dopo una verifica positiva.")
    print(f"🚨 FAILSAFE ATTIVO: Muovi il mouse in un angolo per terminare.")
    print("-" * 80)

    # Posiziona il mouse al centro
    pyautogui.moveTo(center_pos, duration=0.5)

    try:
        while True:
            # Scansiona entrambe le regioni
            left_result = scan_region("SINISTRA", left_region)
            right_result = scan_region("DESTRA", right_region)
            
            # Priorità: se entrambi sono presenti, clicca prima quello di sinistra
            if left_result:
                abs_x, abs_y, side = left_result
                execute_click_and_reset(abs_x, abs_y, f"({side})")
                print(f"    Azione completata. Pausa di {WAIT_AFTER_CLICK_SECONDS} secondi.")
                time.sleep(WAIT_AFTER_CLICK_SECONDS)
                print("-" * 80)
            elif right_result:
                abs_x, abs_y, side = right_result
                execute_click_and_reset(abs_x, abs_y, f"({side})")
                print(f"    Azione completata. Pausa di {WAIT_AFTER_CLICK_SECONDS} secondi.")
                time.sleep(WAIT_AFTER_CLICK_SECONDS)
                print("-" * 80)

            time.sleep(SCAN_INTERVAL_SECONDS)
            
    except KeyboardInterrupt:
        print("\n\n🛑 PROTOCOLLO TERMINATO DALL'UTENTE.")
        # Riporta il mouse al centro prima di uscire
        pyautogui.moveTo(center_pos, duration=0.5)

if __name__ == "__main__":
    if not TESSERACT_AVAILABLE:
        print("[ERRORE CRITICO] Libreria Tesseract non trovata. Il bot non può avviarsi.")
        sys.exit(1)
    main()