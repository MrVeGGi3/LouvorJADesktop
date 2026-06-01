#!/usr/bin/env python3
"""
Rebuild TImageList Bitmap sections in dmComponentes.lfm using the native
LCL LAZ3 format ('Li' signature).

LAZ3 binary layout (from imglist.inc DoReadLaz3):
  2 bytes : 'Li'
  4 bytes : count  (LE uint32)
  4 bytes : width  (LE uint32)
  4 bytes : height (LE uint32)
  count * width * height * 4 bytes : raw pixels per image,
    each image top-to-bottom, left-to-right, 4 bytes per pixel
    in TRGBAQuad order = Blue, Green, Red, Alpha (BGRA byte order).

Uses ImageMagick 'convert' to read PNGs → no external Python deps needed.
"""

import subprocess
import struct
import os

PROJECT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LFM_PATH = os.path.join(PROJECT, "dmComponentes.lfm")
ICO_BASE = os.path.join(PROJECT, "Arquivos Projeto/ico")

IMAGE_LISTS = [
    # (il_name, subdir, img_width, img_height)
    ("ico_40x40", "40x40", 40, 40),
    ("ico_24x24", "24x24", 24, 24),
    ("ico_16x16", "16x16", 16, 16),
]


def png_to_bgra(png_path, width, height):
    """Read PNG → raw BGRA bytes (top-to-bottom, width×height pixels)."""
    result = subprocess.run(
        ["convert", png_path,
         "-resize", f"{width}x{height}!",
         "-background", "none",
         "-alpha", "on",
         "-depth", "8",
         "BGRA:-"],
        capture_output=True
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.decode())
    data = result.stdout
    expected = width * height * 4
    if len(data) != expected:
        raise RuntimeError(f"Expected {expected} bytes, got {len(data)}")
    return data


def blank_bgra(width, height):
    return b'\x00' * (width * height * 4)


def build_laz3_binary(images_bgra, img_width, img_height):
    """Return the LAZ3 binary blob for a TImageList."""
    count = len(images_bgra)
    header = b'Li'
    header += struct.pack('<I', count)
    header += struct.pack('<I', img_width)
    header += struct.pack('<I', img_height)
    return header + b''.join(images_bgra)


def load_png_dir(png_dir, count, img_width, img_height):
    """Load up to `count` numbered PNGs from png_dir (skip underscore-prefixed)."""
    png_files = [f for f in os.listdir(png_dir)
                 if f.endswith('.png') and not f.startswith('_')]
    png_by_idx = {}
    for f in png_files:
        try:
            idx = int(os.path.splitext(f)[0])
            png_by_idx[idx] = os.path.join(png_dir, f)
        except ValueError:
            pass

    images = []
    loaded = 0
    skipped = 0
    for i in range(count):
        if i in png_by_idx:
            try:
                images.append(png_to_bgra(png_by_idx[i], img_width, img_height))
                loaded += 1
            except Exception as e:
                print(f"    [WARN] img {i}: {e}")
                images.append(blank_bgra(img_width, img_height))
                skipped += 1
        else:
            images.append(blank_bgra(img_width, img_height))
            skipped += 1

    print(f"  Loaded {loaded} images, {skipped} blank/missing")
    return images


def get_original_count(original_hex):
    """Extract image count from the original IL header (SIG_D3 format)."""
    binary = bytes.fromhex(original_hex)
    sig = binary[:2]
    if sig == b'IL':
        # D3 format: count at bytes 4-5 (LE word, after sig+version)
        return struct.unpack_from('<H', binary, 4)[0]
    elif sig in (b'Li', b'Lz'):
        # LAZ3/LAZ4: count at bytes 2-5 (LE uint32)
        return struct.unpack_from('<I', binary, 2)[0]
    return 0


def extract_bitmap_hex(lines, bitmap_line_idx):
    """Collect hex content from 'Bitmap = {' line until closing '}'."""
    parts = []
    i = bitmap_line_idx + 1
    while i < len(lines):
        stripped = lines[i].strip()
        if stripped.endswith('}'):
            parts.append(stripped[:-1])  # strip closing '}'
            return ''.join(parts), i
        parts.append(stripped)
        i += 1
    raise RuntimeError("No closing '}' for Bitmap section")


def process_il(il_name, png_dir, img_width, img_height, lines):
    """Find and replace the Bitmap section for il_name."""
    # Find object declaration
    obj_line = None
    for i, line in enumerate(lines):
        if f'object {il_name}: TImageList' in line:
            obj_line = i
            break
    if obj_line is None:
        print(f"  SKIP: {il_name} not found in LFM")
        return lines

    # Find 'Bitmap = {' within this object (search up to 20 lines ahead)
    bitmap_line = None
    for i in range(obj_line, min(obj_line + 20, len(lines))):
        if 'Bitmap = {' in lines[i]:
            bitmap_line = i
            break
    if bitmap_line is None:
        print(f"  SKIP: Bitmap = {{ not found for {il_name}")
        return lines

    original_hex, end_line = extract_bitmap_hex(lines, bitmap_line)
    count = get_original_count(original_hex)
    print(f"  {il_name}: original count={count}, {img_width}x{img_height}")

    # Load PNG images
    images_bgra = load_png_dir(png_dir, count, img_width, img_height)

    # Build LAZ3 binary
    new_binary = build_laz3_binary(images_bgra, img_width, img_height)
    print(f"  LAZ3 binary: {len(new_binary)} bytes")

    # Format as LFM hex (6-space indent, 64 hex chars = 32 bytes per line)
    hex_str = new_binary.hex().upper()
    chunk_lines = [hex_str[j:j + 64] for j in range(0, len(hex_str), 64)]
    indent = '      '
    new_content = []
    for j, chunk in enumerate(chunk_lines):
        if j == len(chunk_lines) - 1:
            new_content.append(indent + chunk + '}')
        else:
            new_content.append(indent + chunk)

    # Splice into lines list
    return lines[:bitmap_line + 1] + new_content + lines[end_line + 1:]


def main():
    print(f"Reading {LFM_PATH}")
    with open(LFM_PATH, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()
    lines = content.split('\n')
    print(f"Total lines: {len(lines)}")

    for il_name, subdir, img_w, img_h in IMAGE_LISTS:
        print(f"\nProcessing {il_name}...")
        png_dir = os.path.join(ICO_BASE, subdir)
        if not os.path.isdir(png_dir):
            print(f"  SKIP: {png_dir} not found")
            continue
        lines = process_il(il_name, png_dir, img_w, img_h, lines)

    print(f"\nWriting {LFM_PATH}")
    with open(LFM_PATH, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
    print("Done.")


if __name__ == '__main__':
    main()
