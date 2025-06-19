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
# Posizione di riposo del mouse. Non si muoverà da qui se non c'è certezza.
MOUSE_RESET_POSITION = (10, 200)

# SOGLIA DI CERTEZZA: L'OCR deve essere sicuro almeno al 65% che il testo sia "Retry".
# Questo è il nostro scudo contro i falsi positivi.
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

def execute_click_and_reset(x, y):
    """
    FASE 3: ESEGUI. Muove il mouse, clicca e torna alla base.
    Questa funzione viene chiamata SOLO quando c'è certezza al 100%.
    """
    print(f"[!] BERSAGLIO CONFERMATO. Inizio azione...")
    pyautogui.moveTo(x, y, duration=0.4)
    pyautogui.click()
    print(f"    [+] CLICK ESEGUITO su ({x}, {y}).")
    time.sleep(1) # Breve pausa post-click
    print(f"    [+] Ritorno alla posizione di riposo {MOUSE_RESET_POSITION}.")
    pyautogui.moveTo(MOUSE_RESET_POSITION, duration=0.5)

def main():
    """Bot principale con protocollo di sicurezza "Proponi e Verifica"."""
    pyautogui.FAILSAFE = True
    print("=" * 70)
    print("🤖 BOT DI PRECISIONE ASSOLUTA - PROTOCOLLO 'PROPONI E VERIFICA'")
    print("=" * 70)
    print(f"[*] STATO: Ricerca passiva. Il mouse è bloccato a {MOUSE_RESET_POSITION}.")
    print(f"[*] SOGLIA DI CERTEZZA: {OCR_CONFIDENCE_THRESHOLD}%")
    print(f"[*] Il mouse si muoverà SOLO dopo una verifica positiva.")
    print(f"🚨 FAILSAFE ATTIVO: Muovi il mouse in un angolo per terminare.")
    print("-" * 70)

    pyautogui.moveTo(MOUSE_RESET_POSITION, duration=0.5)

    try:
        while True:
            # Cattura la zona di interesse (più efficiente)
            screen_width, screen_height = pyautogui.size()
            region_to_scan = (screen_width // 2, screen_height // 2, screen_width // 2, screen_height // 2)
            screenshot = pyautogui.screenshot(region=region_to_scan)
            screenshot_np = cv2.cvtColor(np.array(screenshot), cv2.COLOR_RGB2BGR)
            
            # --- FASE 1: PROPONI ---
            # print("Fase 1: Cerco candidati...") # Puoi decommentare per debug extra
            candidates = find_button_candidates(screenshot_np)
            
            confirmed_target = None
            if candidates:
                # print(f"Trovati {len(candidates)} candidati. Inizio verifica...") # Debug
                # --- FASE 2: VERIFICA ---
                for (x, y, w, h) in candidates:
                    # Ritaglia l'immagine del singolo candidato per l'analisi
                    button_snippet = screenshot_np[y:y+h, x:x+w]
                    
                    if verify_candidate_is_retry(button_snippet):
                        # BERSAGLIO CONFERMATO! Calcola le coordinate assolute
                        abs_x = region_to_scan[0] + x + w // 2
                        abs_y = region_to_scan[1] + y + h // 2
                        confirmed_target = (abs_x, abs_y)
                        break # Trovato, non serve verificare gli altri
            
            # --- FASE 3: ESEGUI (SOLO SE C'È UN BERSAGLIO CONFERMATO) ---
            if confirmed_target:
                execute_click_and_reset(confirmed_target[0], confirmed_target[1])
                print(f"    Azione completata. Pausa di {WAIT_AFTER_CLICK_SECONDS} secondi.")
                time.sleep(WAIT_AFTER_CLICK_SECONDS)
                print("-" * 70)

            time.sleep(SCAN_INTERVAL_SECONDS)
            
    except KeyboardInterrupt:
        print("\n\n🛑 PROTOCOLLO TERMINATO DALL'UTENTE.")

if __name__ == "__main__":
    if not TESSERACT_AVAILABLE:
        print("[ERRORE CRITICO] Libreria Tesseract non trovata. Il bot non può avviarsi.")
        sys.exit(1)
    main()