import '../../import.dart';

class ProductPage extends StatelessWidget {
  final int id;
  final ProductCtrl _productCtrl = Get.find<ProductCtrl>();

  Widget CardWidget({required ChoiceModel choice}){
    
    return Padding(
    padding: EdgeInsets.only(top: 10),
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: WTextWidget(choice.title, fontWeight: 7, fontSize: 15),
          ),
          Divider(thickness: 0.8),
          //radio button
          choice.type == 1 ?
          ProductRadio(options: choice.options, choiceid: choice.id)
          //checkbox
          : choice.type == 2 ?
          ProductCheckbox(options: choice.options, choiceid: choice.id)
          : SizedBox(),
          SizedBox(height: 8),
        ],
      )
    ));
  }

  ProductPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: 
        Obx(() => 
        _productCtrl.isLoading.value ? 
        Center(child: CircularProgressIndicator())
        : _productCtrl.isError.value ? 
        Material(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true
              ),
              SliverToBoxAdapter(child: 
              ErrorReloadWidget(
                action: _productCtrl.loadLocalData,
                height: deviceHeight / 4 * 3
              ))
            ]
          )
        )
        : Material(
          color: bg1,
          child:CustomScrollView(
                slivers: [
                SliverAppBar(
                  centerTitle: false,
                  expandedHeight: deviceHeight / 4 * 1.5,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        WImageWidget(
                          imageType: ImageType.network,
                          image: _productCtrl.product.image,
                          boxfit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            height: deviceHeight / 4 * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WTextWidget(_productCtrl.product.title, fontWeight: 7, fontSize: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      WTextWidget(_productCtrl.product.price.toStringAsFixed(2), fontWeight: 7, fontSize: 16),
                                      WTextWidget("Base price", color: text3, height: 2)
                                    ],
                                  )
                                ],
                              ),
                              WTextWidget(_productCtrl.product.description, color: text3, height: 2) 
                            ]),
                          ),
                        ),
                      ],
                    ),
                    
                  ),
                  
                ),
                SliverToBoxAdapter(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(_productCtrl.product.choices.length, 
                      (index) => CardWidget(choice: _productCtrl.product.choices[index])),
                    ),
                  ),
                
                ],
              ),
        ),
        ))
        );
  }
}

class ProductRadio extends StatefulWidget{
  int choiceid;
  List<OptionModel> options;

  ProductRadio({super.key, required this.options, required this.choiceid});

  @override
  State<StatefulWidget> createState() => _stateProductRadio();
}

class _stateProductRadio extends State<ProductRadio>{
  final ProductCtrl _productCtrl = Get.find<ProductCtrl>();
  String selectedValues = "";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedValues = widget.options[0].id.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
            children: List.generate(widget.options.length, (index) => 
            
           
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: Text(widget.options[index].title),
              secondary: Text(widget.options[index].price.toStringAsFixed(2)),
              value: widget.options[index].id.toString(),
              groupValue: selectedValues,
              onChanged: (value) {
                setState(() {
                  selectedValues = value.toString();
                });

                _productCtrl.changeSelection(optionid: widget.choiceid, selected_option: selectedValues);
              },
            ),
            (index < widget.options.length - 1) ? Divider(height: 0, thickness: 1) : SizedBox(),
          ],
        ) ),
          );
  }
}


class ProductCheckbox extends StatefulWidget{
  int choiceid;
  List<OptionModel> options;

  ProductCheckbox({super.key, required this.choiceid, required this.options});

  @override
  State<StatefulWidget> createState() => _stateProductCheckbox();
}

class _stateProductCheckbox extends State<ProductCheckbox>{
  final ProductCtrl _productCtrl = Get.find<ProductCtrl>();
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: List.generate(widget.options.length, (index) =>    
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(widget.options[index].title),
              secondary: widget.options[index].price > 0 ? Text("+ ${widget.options[index].price.toStringAsFixed(2)}") : Text(""),
              value: selectedValues.contains(widget.options[index].id.toString()),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    selectedValues.add(widget.options[index].id.toString());
                  } else {
                    selectedValues.remove(widget.options[index].id.toString());
                  }
                  _productCtrl.changeSelection(optionid: widget.choiceid, selected_options: selectedValues);
                });
              },
            ),
            (index < widget.options.length - 1) ? Divider(height: 0, thickness: 1) : SizedBox(),
          ],
        ) ),
          );
  }
}
