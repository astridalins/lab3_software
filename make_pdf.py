from fpdf import FPDF
import unicodedata

def to_latin(text):
    result = []
    for ch in text:
        try:
            ch.encode("latin-1")
            result.append(ch)
        except UnicodeEncodeError:
            nfkd = unicodedata.normalize("NFKD", ch)
            ascii_ch = nfkd.encode("ascii", "ignore").decode("ascii")
            result.append(ascii_ch if ascii_ch else "-")
    return "".join(result)

pdf = FPDF()
pdf.set_auto_page_break(auto=True, margin=15)
pdf.set_margins(15, 15, 15)
pdf.add_page()

with open("index_explained.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()

for line in lines:
    line = to_latin(line.rstrip())
    stripped = line.strip()

    if "===" in stripped and stripped.replace("=","").strip() == "":
        continue

    if stripped.startswith("BLOC") or stripped.startswith("FLUX") or stripped.startswith("EXPLICACIO"):
        pdf.ln(3)
        pdf.set_font("Helvetica", "B", 12)
        pdf.set_fill_color(60, 90, 150)
        pdf.set_text_color(255, 255, 255)
        pdf.set_x(15)
        pdf.cell(180, 7, "  " + stripped, fill=True, new_x="LMARGIN", new_y="NEXT")
        pdf.ln(2)
        pdf.set_text_color(0, 0, 0)
        continue

    if stripped.startswith("---") and stripped.replace("-","").strip() == "":
        pdf.ln(1)
        pdf.set_draw_color(180, 180, 180)
        pdf.line(15, pdf.get_y(), 195, pdf.get_y())
        pdf.ln(4)
        continue

    if stripped.startswith("5.") or stripped.startswith("DIFERENCIA") or stripped.startswith("EXEMPLE"):
        pdf.ln(2)
        pdf.set_font("Helvetica", "B", 10)
        pdf.set_fill_color(220, 230, 245)
        pdf.set_text_color(30, 60, 120)
        pdf.set_x(15)
        pdf.cell(180, 6, "  " + stripped, fill=True, new_x="LMARGIN", new_y="NEXT")
        pdf.ln(1)
        pdf.set_text_color(0, 0, 0)
        continue

    if stripped == "":
        pdf.ln(2)
        continue

    pdf.set_x(15)
    if stripped.startswith("$(") or (stripped.startswith("App.") and "=" in stripped):
        pdf.set_font("Courier", "B", 8)
        pdf.set_text_color(180, 60, 0)
    elif stripped.startswith("->") or stripped.startswith("- "):
        pdf.set_font("Helvetica", "", 9)
        pdf.set_text_color(50, 50, 50)
    else:
        pdf.set_font("Helvetica", "", 9)
        pdf.set_text_color(30, 30, 30)

    pdf.multi_cell(180, 5, stripped)
    pdf.set_text_color(0, 0, 0)

pdf.output("index_explained.pdf")
print("PDF creat a index_explained.pdf")
