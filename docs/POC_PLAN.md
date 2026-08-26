# Kế hoạch PoC đọc PPKX trực tiếp trên iPad

## Phạm vi

PoC chứng minh chuỗi xử lý native trên iPad. Không dùng backend, không gửi PPKX lên
cloud và không phụ thuộc LandClip Windows.

## Giai đoạn 0 — scaffold

- SwiftUI app chỉ dành cho iPad.
- Chọn `.ppkx` bằng document picker.
- Model trạng thái scan và unit test.
- C ABI để nối C++ engine.
- CI build bằng macOS simulator.

## Giai đoạn 1 — native dependencies

- Build XCFramework cho GDAL, PROJ, GEOS, SQLite và thư viện 7z.
- Chỉ bật các driver OpenFileGDB, GPKG và GeoJSON.
- Kiểm tra license của dependency trước khi phân phối.

## Giai đoạn 2 — catalog thật

- Sao chép PPKX vào sandbox theo luồng streaming.
- Giải nén vào `Library/Caches`.
- Tìm mọi `.gdb` và liệt kê layer, geometry, CRS, feature count.
- Hủy scan an toàn và dọn file tạm.

## Tiêu chí pass

1. Đọc đúng số geodatabase và layer so với tool Windows/ArcGIS.
2. Không đưa dữ liệu ra khỏi iPad.
3. Peak memory không tăng theo toàn bộ kích thước layer.
4. Scan có progress và cancel.
5. File tạm được dọn sau khi hoàn thành hoặc hủy.

