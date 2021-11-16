import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  Rules({Key? key}) : super(key: key);

  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                  Colors.teal.shade900,
                  Colors.teal.shade600
                ])),
          ),
          backgroundColor: Colors.teal.shade800,
          title: Text('Điều khoản'),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fitWidth)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.only(right: 15, top: 15, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300.withOpacity(0.85),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      minLeadingWidth: 1,
                      title: Text(
                          '''Sự Tuân Thủ Của Bạn Bạn đồng ý tuân thủ với tất cả hướng dẫn, thông báo, quy tắc hoạt động, chính sách và chỉ dẫn liên quan đến việc mua Sản Phẩm thông qua Nền Tảng PlantsShop, cũng như bất kỳ sửa đổi, điều chỉnh nào đối với những quy định nói trên do PlantsShop ban hành vào từng thời điểm (cho dù đó là một phần của việc sử dụng Nền Tảng PlantsShop hoặc liên quan đến việc mua Sản Phẩm, thay mặt cho Nhà Bán Hàng).
         PlantsShop có quyền sửa đổi các hướng dẫn, thông báo, quy tắc hoạt động, chính sách và chỉ dẫn vào bất kỳ thời điểm nào bằng cách thông báo trước cho bạn và bạn được xem là đã biết và chịu sự ràng buộc với những thay đổi, điều chỉnh sau khi những thông báo, điều chỉnh này được công bố trên Nền Tảng PlantsShop phù hợp với chính sách của PlantsShop và quy định pháp luật áp dụng.''',
                          style: TextStyle(fontSize: 17)),
                      leading: Icon(
                        Icons.fiber_manual_record,
                        size: 15,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 1,
                      leading: Icon(
                        Icons.fiber_manual_record,
                        size: 17,
                        color: Colors.teal.shade800,
                      ),
                      title: Text(
                          '''Nhà Bán Hàng Nhà Bán Hàng bán các Sản Phẩm trên Nền Tảng của PlantsShop. 
         Thông tin về một Sản Phẩm cụ thể được Nhà Bán hàng bán trên Nền Tảng PlantsShop được nêu rõ trên trang mô tả sản phẩm trên Nền Tảng PlantsShop. 
         Các Sản Phẩm do Nhà Bán Hàng Bán cho Khách Hàng sẽ chịu sự điều chỉnh của hợp đồng với Khách Hàng tương ứng:
          (a) đối với Sản Phẩm do Nhà Bán Hàng (không phải PlantsShop) bán,sẽ được thỏa thuận trực tiếp giữa Nhà Bán Hàng đó và bạn; 
          (b) đối với Sản Phẩm do PlantsShop bán, sẽ được thỏa thuận trực tiếp giữa PlantsShop và bạn. ''',
                          style: TextStyle(fontSize: 17)),
                    ),
                    ListTile(
                      minLeadingWidth: 1,
                      leading: Icon(
                        Icons.fiber_manual_record,
                        size: 17,
                        color: Colors.teal.shade800,
                      ),
                      title: Text(
                          '''Giá Sản Phẩm \n 3.1 Giá niêm yết trên Nền Tảng PlantsShop là giá sau cùng và đã bao gồm thuế giá trị gia tăng (GTGT). 
        Giá có thể thay đổi tùy theo từng thời điểm và chương trình ưu đãi được áp dụng. 
        Phí vận chuyển và/hoặc phí giao hàng (nếu có), sẽ được hiển thị rõ ràng trên trang thanh toán khi Đơn Đặt Hàng được đặt. 
         3.2 PlantsShop luôn cố gắng đảm bảo chính xác tất cả các thông tin và giá cả hiển thị cho từng Sản Phẩm, tuy nhiên, thỉnh thoảng có thể có một số lỗi hoặc thiếu sót do các yếu tố khách quan. Nếu phát hiện có sai sót về giá, hệ thống sẽ tự động hủy Đơn Đặt Hàng, gửi thư điện tử và tin nhắn văn bản SMS thông báo cho bạn. 
         Sau đó,  yêu cầu hoàn tiền sẽ ngay lập tức được thực hiện (nếu Đơn Đặt Hàng đã được thanh toán trước). 
         3.3 Nhà Bán Hàng trên Nền Tảng PlantsShop có thể phân phối cùng một Sản Phẩm với các chính sách giá khác nhau, bạn có quyền tự do lựa chọn và so sánh ưu đãi của Nhà Bán Hàng khác nhau để lựa chọn mức giá hợp lý nhất.
         PlantsShop sẽ không can thiệp vào chính sách giá của Nhà Bán Hàng nếu có tranh chấp.
         ''',
                          style: TextStyle(fontSize: 17)),
                    ),
                    ListTile(
                      minLeadingWidth: 1,
                      leading: Icon(
                        Icons.fiber_manual_record,
                        size: 17,
                        color: Colors.teal.shade800,
                      ),
                      title: Text(
                          'Thông Tin Và Mô Tả Sản Phẩm Trong trường hợp Sản Phẩm nhận được không giống như mô tả trên Nền Tảng PlantsShop, bạn có quyền thông báo cho Nhà Bán Hàng hoặc bộ phận hỗ trợ của PlantsShop càng sớm càng tốt sau khi nhận được Sản Phẩm và đồng thời, đảm bảo rằng Sản Phẩm chưa được sử dụng trước khi trả lại. ',
                          style: TextStyle(fontSize: 17)),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      leading: Icon(
                        Icons.fiber_manual_record,
                        size: 17,
                        color: Colors.teal.shade800,
                      ),
                      title: Text(''' Đặt Hàng Và Xác Nhận 
        5.1 Bạn có thể thực hiện Đơn Đặt Hàng bằng cách điền và gửi thông tin được yêu cầu trên Nền Tảng PlantsShop. 
        Nhà Bán Hàng sẽ không chấp nhận các Đơn Đặt Hàng được thực hiện theo bất kỳ cách nào khác. Bạn phải chịu trách nhiệm đảm bảo tính chính xác của thông tin trong Đơn Đặt Hàng. Để đảm bảo tính công bằng và bảo vệ quyền lợi của tất cả Khách Hàng, PlantsShop có quyền từ chối các Đơn Đặt Hàng thuộc (nhưng không giới hạn) các trường hợp sau:
         (a) Các Đơn Đặt Hàng không nhằm mục đích sử dụng cá nhân, mua số lượng lớn hoặc phục vụ cho mục đích bán lại. Đối với các Sản Phẩm thuộc ngành hàng điện máy, bạn chỉ được mua tối đa hai (2) Sản Phẩm/ngày và năm (5) Sản Phẩm/tháng. Đối với các Sản Phẩm không thuộc ngành hàng điện máy, bạn chỉ được mua tối đa năm (5) Sản Phẩm/ngày và mười (10) Sản Phẩm/tháng. 
         (b) Nếu Khách Hàng không tuân thủ bất kỳ quy định, chính sách nào của PlantsShop, PlantsShop có quyền từ chối Đơn Đặt Hàng của Khách Hàng cũng như đình chỉ hoặc chấm dứt Tài Khoản Người Dùng PlantsShop của Khách Hàng vĩnh viễn mà không cần thông báo trước. 
         (c) Khách Hàng không thể thay đổi Địa chỉ giao hàng và/hoặc địa chỉ gửi hóa đơn thanh toán mà Khách Hàng đã cung cấp trong quá trình đặt hàng sau khi PlantsShop và/hoặc Nhà Bán Hàng nhận được Đơn Đặt Hàng. Để thay đổi thông tin đó, Khách Hàng cần phải hủy Đơn Đặt Hàng hiện tại và đặt một Đơn Đặt Hàng mới với địa chỉ cập nhật chính xác. 
         5.2 Đơn Đặt Hàng là không thể hủy ngang và hủy vô điều kiện: Tất cả các Đơn Đặt Hàng sẽ được coi là không thể hủy ngang và vô điều kiện khi được gửi thông qua Nền Tảng PlantsShop và Nhà Bán Hàng có quyền (nhưng không có nghĩa vụ) xử lý (các) Đơn Đặt Hàng đó mà không cần có thêm chấp thuận từ Khách Hàng và không cần phải thông báo thêm cho Khách Hàng.
          Tuy nhiên, trong một số trường hợp nhất định như đã nêu trong Điều Khoản Sử Dụng này, Khách Hàng có quyền yêu cầu.
          ''', style: TextStyle(fontSize: 17)),
                    ),
                    ListTile(
                      minLeadingWidth: 1,
                      leading: Icon(
                        Icons.fiber_manual_record,
                        size: 17,
                        color: Colors.teal.shade800,
                      ),
                      title: Text('''. Hình thức thanh toán 
        6.1 Bạn có quyền thanh toán Đơn Đặt Hàng bằng phương thức (i) thanh toán khi nhận hàng hoặc (ii) thanh toán trực tuyến (bằng thẻ tín dụng, thẻ ngân hàng hoặc ví điện tử có trên Nền Tảng PlantsShop).
         Đối với trường hợp Sản Phẩm được cung cấp bởi Nhà Bán Hàng là thương nhân nước ngoài không có hiện diện thương mại tại Việt Nam, bạn đồng ý ủy quyền không hủy ngang cho PlantsShop tiến hành các thủ tục cần thiết với ngân hàng tại Việt Nam để thanh toán cho Nhà Bán Hàng, bao gồm cả việc mua ngoại tệ và chuyển ngoại tệ cho Nhà Bán Hàng tại nước ngoài. 
         Để tránh nhầm lẫn, PlantsShop, trong mọi trường hợp, sẽ không được ghi nhận là bên nhập khẩu, xuất khẩu, ký gửi hoặc nhận ký gửi trong bất kỳ tài liệu xuất khẩu hoặc nhập khẩu nào. 
         6.2 Thông thường, Khách Hàng có quyền lựa chọn một trong các hình thức thanh toán nêu trên khi tiến hành đặt hàng.
          Tuy nhiên, đối những Đơn Đặt Hàng có giá trị cao từ 50 triệu Đồng trở lên, Khách Hàng không thể lựa chọn hình thức thanh toán bằng tiền mặt khi nhận hàng. Trong quá trình hoạt động, giá trị đơn hàng có thể thanh toán bằng tiền mặt khi nhận hàng có thể được điều chỉnh phù hợp với tình hình hoạt động thực tế. 
          6.3 Trừ trường hợp được quy định khác và có thông báo khác bởi PlantsShop, bạn sẽ không cần phải thanh toán bất kỳ khoản tiền đặt cọc nào cho Đơn Đặt Hàng. Trong trường hợp bạn nhận được yêu cầu này từ phía PlantsShop, vui lòng từ chối thanh toán và thông báo với bộ phận hỗ trợ tại để được hỗ trợ thêm. 
          6.4 Bạn đồng ý rằng bạn phải tuân theo thỏa thuận người dùng áp dụng cho phương thức thanh toán bạn đã chọn. 
          Bạn không được khiếu nại Nhà Bán Hàng hoặc bất kỳ đại lý ủy quyền nào của Nhà Bán Hàng (có thể bao gồm cả PlantsShop) về bất kỳ sự cố, gián đoạn hoặc lỗi nào liên quan đến phương thức thanh toán bạn đã chọn.
          ''', style: TextStyle(fontSize: 17)),
                    ),
                    ListTile(
                      minLeadingWidth: 1,
                      leading: Icon(
                        Icons.fiber_manual_record,
                        size: 17,
                        color: Colors.teal.shade800,
                      ),
                      title: Text('''Thanh Toán An Toàn 
         Tất cả thông tin của Khách Hàng giao dịch trên Nền Tảng PlantsShop qua thẻ tín dụng hoặc thẻ ngân hàng đều được bảo mật thông tin bằng mã hóa. Bên cạnh đó, khi thực hiện thanh toán trực tuyến, Khách Hàng vui lòng lưu ý các chi tiết sau: 
        (a) Chỉ thanh toán trên các website, ứng dụng có chứng chỉ an toàn, bảo mật hệ thống thẻ. 
        (b) Tuyệt đối không cho người khác mượn thẻ tín dụng, thẻ ngân hàng của mình để thực hiện thanh toán trên Nền Tảng PlantsShop; trong trường hợp phát sinh giao dịch ngoài ý muốn, bạn vui lòng thông báo ngay lập tức để PlantsShop có thể hỗ trợ kịp thời. 
        (c) Kiểm tra thẻ tín dụng, thẻ ngân hàng của mình thường xuyên để đảm bảo tất cả giao dịch qua thẻ đều nằm trong tầm kiểm soát của bạn.
        ''', style: TextStyle(fontSize: 17)),
                    )
                  ],
                ),
              ),
            )));
  }
}
