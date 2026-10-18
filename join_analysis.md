# GIẢI TRÌNH NGHIỆP VỤ VỀ LỰA CHỌN HÀM COUNT VỚI LEFT JOIN

**Dự án:** Hệ thống Báo cáo FlashMart  
**Vai trò:** Data Engineer  

---

## Giải trình kỹ thuật: Tại sao dùng `COUNT(o.order_id)` thay vì `COUNT(*)`?

Khi thực hiện `LEFT JOIN` giữa bảng `Customers` (bảng gốc bên trái) và bảng `Orders` (bảng tham chiếu bên phải), những khách hàng chưa từng phát sinh đơn hàng (như *Charlie*) vẫn được giữ lại trong tập kết quả, nhưng tất cả các cột thuộc bảng `Orders` sẽ mang giá trị `NULL`.

1. **Nếu dùng `COUNT(*)`:** Hàm sẽ đếm tất cả các dòng trả về trong nhóm, tính cả dòng chứa giá trị `NULL`. Do đó, khách hàng chưa mua hàng vẫn bị đếm là **1** đơn hàng (sai lệch nghiêm trọng so với thực tế).
2. **Khi dùng `COUNT(o.order_id)`:** Hàm `COUNT(column)` có đặc tính kỹ thuật là **bỏ qua (ignore) các giá trị `NULL`**. Do `o.order_id` của khách hàng chưa mua mang giá trị `NULL`, hàm trả về kết quả chính xác bằng **0**.

Sử dụng `COUNT(o.order_id)` là giải pháp bắt buộc để bảo toàn tính toàn vẹn dữ liệu báo cáo Marketing.
