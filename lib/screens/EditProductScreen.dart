import 'package:Yummy/providers/Product.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../providers/Products.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    id: "",
  );
  bool _isInit = true;
  // since we are populating the textfields with previous values of product, we use map
  var _initValues = {
    "title": "",
    "price": "",
    "description": "",
    "imageUrl": "",
  };
  var _isLoading = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    //makes below code run only one time
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments;
      //fills editedproduct with selected product
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        // runs when we are editing products
        _initValues = {
          "title": _editedProduct.title,
          "price": _editedProduct.price.toString(),
          "description": _editedProduct.description,
          "imageUrl": "",
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode
        .dispose(); //manually dispose focus node. otherwise, they lead to memory leakage
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
  }

  //saves form state
  void _saveform() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    //we defined global key for form for this reason - to save the form state
    _formKey.currentState.save();
    //when the user tries to save form, set _isLoading to true so that loading spinner shows, then set false in if-else block
    setState(() {
      _isLoading = true;
    });
    // if the product already exist, you can check this by using product id,
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      // connecting products provider and adding new products to the items which we get from our form
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
          actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveform)],
        ),
        // if form is being submitted and waiting for response, display loading spinner
        body: _isLoading
            ? Center(
                child: SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  //this allows us to interact with the state managed by the form widget
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          child: TextFormField(
                            initialValue: _initValues["title"],
                            decoration: InputDecoration(
                                labelText: "Title",
                                contentPadding: EdgeInsets.all(9)),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            //validates the text field
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter a valid title";
                              }
                              return null;
                            },
                            onSaved: (title) {
                              _editedProduct = Product(
                                title: title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl,
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                              );
                            },
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            initialValue: _initValues["price"],
                            decoration: InputDecoration(
                                labelText: "Price",
                                contentPadding: EdgeInsets.all(9)),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _priceFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty ||
                                  (double.parse(value) == null) ||
                                  (double.parse(value) <= 0)) {
                                return "Please enter a valid price!";
                              }
                              return null;
                            },
                            onSaved: (price) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: double.parse(price),
                                imageUrl: _editedProduct.imageUrl,
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                              );
                            },
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            initialValue: _initValues["description"],
                            decoration: InputDecoration(
                                labelText: "Description",
                                contentPadding: EdgeInsets.all(9)),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            focusNode: _descriptionFocusNode,
                            validator: (value) {
                              if (value.isEmpty || value.length <= 5) {
                                return "Please enter a valid description(at least 5 characters long)";
                              }
                              return null;
                            },
                            onSaved: (description) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                description: description,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl,
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please enter a valid URL";
                                    }
                                    return null;
                                  },
                                  onSaved: (imageUrl) {
                                    _editedProduct = Product(
                                      title: _editedProduct.title,
                                      description: _editedProduct.description,
                                      price: _editedProduct.price,
                                      imageUrl: imageUrl,
                                      isFavorite: _editedProduct.isFavorite,
                                      id: _editedProduct.id,
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
