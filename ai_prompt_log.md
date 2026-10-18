# NHẬT KÝ TƯƠNG TÁC AI (AI PROMPT LOG)

**Học viên:** Data Engineer  
**Mục tiêu:** Thảo luận lý thuyết JOIN, tối ưu hóa câu lệnh SQL và giải thuật xử lý dữ liệu.

---

## Prompt 1: Bản chất của lệnh JOIN mặc định trong MySQL
* **User Input:**  
  > "Trong cơ sở dữ liệu MySQL, mặc định từ khóa JOIN (khi không ghi rõ LEFT hay RIGHT) sẽ hoạt động như thế nào? Nó sẽ bỏ qua hay giữ lại các bản ghi không có sự trùng khớp ở cả hai bảng?"
* **AI Output Summary:**  
  - Từ khóa `JOIN` khi không ghi rõ mặc định là `INNER JOIN`.
  - Cơ chế: Chỉ lấy phần giao (Intersection) giữa hai tập hợp. Nếu một bản ghi ở bảng này không khớp với bất kỳ bản ghi nào ở bảng kia, nó sẽ bị loại bỏ hoàn toàn khỏi kết quả.

---

## Prompt 2: Phân biệt `COUNT(*)` và `COUNT(column)` khi dùng `LEFT JOIN`
* **User Input:**  
  > "Khi tôi sử dụng LEFT JOIN và đếm số lượng đơn hàng bằng hàm COUNT, tôi nên dùng `COUNT(*)` hay `COUNT(tên_cột_khóa_chính_bảng_order)`? Sự khác biệt khi kết quả trả về NULL là gì?"
* **AI Output Summary:**  
  - `COUNT(*)` đếm số lượng dòng (rows) trả về, không quan tâm nội dung dòng đó có NULL hay không, dẫn đến việc đếm nhầm dòng kết nối NULL thành 1.
  - `COUNT(column_name)` bỏ qua các giá trị NULL, đếm chính xác số lượt xuất hiện của dữ liệu thực tế (trả về 0 nếu cột mang giá trị NULL).

---

## Prompt 3: So sánh Hiệu năng giữa Anti-Join và Subquery (`NOT IN`)
* **User Input:**  
  > "Hãy phân tích hiệu năng (Performance) của việc dùng `LEFT JOIN ... WHERE IS NULL` so với việc dùng subquery `NOT IN` khi muốn tìm kiếm các bản ghi không tồn tại trong bảng khác."
* **AI Output Summary:**  
  - `LEFT JOIN ... WHERE IS NULL` (Anti-Join) có hiệu năng tối ưu và ổn định nhờ tận dụng được Index trên khóa ngoại và thuật toán Hash/Nested-Loop Join của trình tối ưu hóa (Query Optimizer).
  - Subquery với `NOT IN` có thể dẫn đến hiện tượng quét toàn bộ bảng (Table Scan) hoặc gây lỗi/kết quả rỗng bất ngờ nếu tập dữ liệu phụ chứa giá trị `NULL`.
