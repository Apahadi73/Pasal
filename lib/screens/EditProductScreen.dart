import 'package:Yummy/providers/product.dart';
import 'package:flutter/material.dart';

//edits the product item when user goes to manage product screen and press edit button
class EditProductScreen extends StatefulWidget {
  static const routeName = "/EditProductScreen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  //text editing controller for the image url textfield
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    title: "",
    price: 0.0,
    description: "",
    imageUrl: "",
  );

  @override
  void initState() {
    super.initState();
    //adds listner to the _imageUrlController
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        setState(() {}); //saves state
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose(); //manually dispose focus node. otherwise, they lead to memory leakage
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
  }

//saves form state
  void _saveform() {
    //we defined global key for form for this reason - to save the form state
    _formKey.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.id);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
          actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveform)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            //this allows us to interact with the state managed by the form widget
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Title", contentPadding: EdgeInsets.all(9)),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (title) {
                        _editedProduct = Product(
                          title: title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Price", contentPadding: EdgeInsets.all(9)),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (price) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(price),
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Description", contentPadding: EdgeInsets.all(9)),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (description) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                        );
                      },
                    ),
                  ),
                  Card(
                    child: Row(
                      children: [
                        Card(
                          child: Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(
                              top: 8,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            )),
                            child: _imageUrlController.text.isEmpty
                                ? Text(
                                    "Enter an image URL",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  )
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Image URL",
                              contentPadding: EdgeInsets.all(8),
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveform();
                            },
                            onSaved: (imageUrl) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: imageUrl,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
