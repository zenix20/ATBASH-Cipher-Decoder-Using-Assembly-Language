# ATBASH-Cipher-Decoder-Using-Assembly-Language (x86 Assembly)

An assembly language program that decodes text using the ATBASH cipher and searches for the name "ZAINAB QURESHI" in the decoded output.

## About the ATBASH Cipher
The ATBASH cipher is a substitution cipher where:
- The first letter of the alphabet maps to the last (`A ↔ Z`)
- The second letter maps to the second last (`B ↔ Y`)
- ...and so on (`M ↔ N`).

Example:  
`GSV` (encoded) → `THE` (decoded)

---

## Program Features
1. **Decodes ATBASH-encoded text** from 15 pre-loaded lines.
2. **Searches for "ZAINAB QURESHI"** in the decoded text.
3. **Outputs results**:
   - Line number where the name was found (if present).
   - The full decoded line containing the name.
   - Error message if the name is not found.

---

## Assembly Details
- **Architecture**: x86 (16-bit)
- **Syntax**: MASM (Microsoft Macro Assembler)
- **Environment**: DOS or DOS emulator (e.g., DOSBox)
- **Dependencies**: MASM assembler, LINK for linking.

---

## How to Run
### Prerequisites
1. Install [DOSBox](https://www.dosbox.com/).
2. Install MASM (e.g., [MASM32](http://www.masm32.com/) or use a package like `masm` in Linux).

### Steps
1. **Assemble**:
   ```bash
   masm/ml ATBASH-CIPHER-DECODER.asm;
2. **Link**:
   ```bash
   link MIDTERM.obj;
3. **Run in DOSBox**:
   ```bash
   MIDTERM.exe


