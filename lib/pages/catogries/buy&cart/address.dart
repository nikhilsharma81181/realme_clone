import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realme_clone/models/user-address-model.dart';

CollectionReference addressRef = FirebaseFirestore.instance
    .collection('users')
    .doc(user!.uid)
    .collection('address');
final user = FirebaseAuth.instance.currentUser;

class Address extends StatefulWidget {
  final bool buying;
  const Address({Key? key, required this.buying}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  changeDefaultAddress(String addressId) {
    FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'default-address': addressId,
    });
  }

  deleteAddress(String addressId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('address')
        .doc(addressId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool hasAddress = context.watch<UserAddress>().hasAddress;
    String address = context.watch<UserAddress>().defaultAdd;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selected Address',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddAddress(
                    hasAddress: hasAddress,
                    id: '',
                    name: '',
                    mobile: '',
                    pincode: '',
                    city: '',
                    state: '',
                    fullAddress: '',
                    email: '',
                    landmark: '',
                    edit: false,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.black,
              size: MediaQuery.of(context).size.width * 0.07,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          )
        ],
      ),
      body: Container(
          color: Colors.grey.shade300.withOpacity(0.7),
          width: width,
          child: StreamBuilder<QuerySnapshot>(
              stream: addressRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.32,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.pink.withOpacity(0.8),
                              size: MediaQuery.of(context).size.width * 0.27,
                            ),
                            Text('No Address'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.37,
                              height: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: RawMaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => AddAddress(
                                              hasAddress: hasAddress,
                                              id: '',
                                              name: '',
                                              mobile: '',
                                              pincode: '',
                                              city: '',
                                              state: '',
                                              fullAddress: '',
                                              email: '',
                                              landmark: '',
                                              edit: false,
                                            )),
                                  );
                                },
                                child: Text('Add address'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                      children: snapshot.data!.docs
                          .map((e) => GestureDetector(
                                onTap: () {
                                  if (widget.buying) {
                                    context
                                        .read<UserAddress>()
                                        .selectAddress(e.id);
                                    Navigator.pop(context);
                                  } else {}
                                },
                                child: Container(
                                    padding: EdgeInsets.all(width * 0.05),
                                    margin: EdgeInsets.all(width * 0.022),
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width * 0.85,
                                              child: Row(
                                                mainAxisAlignment: widget.buying
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(e['Full Name'],
                                                      style: TextStyle(
                                                          fontSize:
                                                              width * 0.039,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  SizedBox(
                                                      width: width * 0.042),
                                                  Container(
                                                    child: e.id == address
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        width *
                                                                            0.007,
                                                                    horizontal:
                                                                        width *
                                                                            0.032),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .yellow
                                                                        .shade900),
                                                                color: Colors
                                                                    .yellow
                                                                    .shade800
                                                                    .withOpacity(
                                                                        0.2)),
                                                            child: Text(
                                                              'Default',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.032,
                                                                  color: Colors
                                                                      .yellow
                                                                      .shade900),
                                                            ),
                                                          )
                                                        : Text(''),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            widget.buying
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      AddAddress(
                                                                        hasAddress:
                                                                            hasAddress,
                                                                        id: e
                                                                            .id,
                                                                        name: e[
                                                                            'Full Name'],
                                                                        mobile:
                                                                            e['Mobile Number'],
                                                                        pincode:
                                                                            e['Pincode'],
                                                                        city: e[
                                                                            'City'],
                                                                        state: e[
                                                                            'State'],
                                                                        fullAddress:
                                                                            e['full-address'],
                                                                        email: e[
                                                                            'Email'],
                                                                        landmark:
                                                                            e['Landmark'],
                                                                        edit:
                                                                            true,
                                                                      )));
                                                    },
                                                    child: Icon(Icons.edit))
                                                : Text(''),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.007),
                                        Text(e['Mobile Number'],
                                            style: TextStyle(
                                                fontSize: width * 0.038,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height: height * 0.007),
                                        Text(e['full-address']),
                                        SizedBox(height: width * 0.05),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                changeDefaultAddress(e.id);
                                                setState(() {});
                                                context
                                                    .read<UserAddress>()
                                                    .defaultAddress();
                                              },
                                              child: Text(
                                                'Save as default',
                                                style: TextStyle(
                                                  fontSize: width * 0.0332,
                                                  color: e.id == address
                                                      ? Colors.grey.shade400
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.05),
                                            GestureDetector(
                                              onTap: () {
                                                deleteAddress(e.id);
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    fontSize: width * 0.0332),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.05),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddAddress(
                                                              hasAddress:
                                                                  hasAddress,
                                                              id: e.id,
                                                              name: e[
                                                                  'Full Name'],
                                                              mobile: e[
                                                                  'Mobile Number'],
                                                              pincode:
                                                                  e['Pincode'],
                                                              city: e['City'],
                                                              state: e['State'],
                                                              fullAddress: e[
                                                                  'full-address'],
                                                              email: e['Email'],
                                                              landmark:
                                                                  e['Landmark'],
                                                              edit: true,
                                                            )));
                                              },
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    fontSize: width * 0.0332),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              ))
                          .toList());
                } else
                  return CircularProgressIndicator(
                    color: Colors.yellow.shade700,
                  );
              })),
    );
  }
}

class AddAddress extends StatefulWidget {
  final bool hasAddress;
  final String id;
  final String name;
  final String mobile;
  final String pincode;
  final String city;
  final String state;
  final String fullAddress;
  final String email;
  final String landmark;
  final bool edit;

  const AddAddress({
    Key? key,
    required this.hasAddress,
    required this.id,
    required this.name,
    required this.mobile,
    required this.pincode,
    required this.city,
    required this.state,
    required this.fullAddress,
    required this.email,
    required this.landmark,
    required this.edit,
  }) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _fullAddress = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  bool isDefault = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    setState(() {
      _name.text = widget.name;
      _mobile.text = widget.mobile;
      _pincode.text = widget.pincode;
      _city.text = widget.city;
      _state.text = widget.state;
      _fullAddress.text = widget.fullAddress;
      _email.text = widget.email;
      _landmark.text = widget.landmark;
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    _pincode.dispose();
    _city.dispose();
    _state.dispose();
    _email.dispose();
    _landmark.dispose();
    _fullAddress.dispose();
    super.dispose();
  }

  Future addAddress() async {
    try {
      if (!widget.edit) {
        DocumentReference _docRef = await addressRef.add({
          'Full Name': _name.text.trim(),
          'Mobile Number': _mobile.text.trim(),
          'Pincode': _pincode.text.trim(),
          'City': _city.text.trim(),
          'State': _state.text.trim(),
          'full-address': _fullAddress.text.trim(),
          'Email': _email.text.trim(),
          'Landmark': _landmark.text.trim(),
          'addressId': ''
        });
        await addressRef.doc(_docRef.id).update({
          'addressId': _docRef.id,
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'default-address': _docRef.id,
        });
        context.read<UserAddress>().addressAvailable();
      } else if (widget.edit) {
        await addressRef.doc(widget.id).update({
          'Full Name': _name.text.trim(),
          'Mobile Number': _mobile.text.trim(),
          'Pincode': _pincode.text.trim(),
          'City': _city.text.trim(),
          'State': _state.text.trim(),
          'full-address': _fullAddress.text.trim(),
          'Email': _email.text.trim(),
          'Landmark': _landmark.text.trim(),
          'addressId': ''
        });
      }
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Address',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildForm('Full Name', _name),
              divider(),
              buildForm('Mobile Number', _mobile),
              divider(),
              buildForm('Zip / Posrtal Code', _pincode),
              divider(),
              buildForm('City / Town', _city),
              divider(),
              buildForm('State / Province / Region', _state),
              divider(),
              fullAddress(
                  'Address Format (preffered): Flat / House No., Floor, Building , Street',
                  _fullAddress),
              divider(),
              buildForm('Email (required)', _email),
              divider(),
              buildForm('Landmark (optional)', _landmark),
              divider(),
              Row(
                children: [
                  Checkbox(
                      value: widget.hasAddress ? isDefault : true,
                      onChanged: (_) {
                        setState(() {
                          isDefault ? isDefault = false : isDefault = true;
                        });
                      }),
                  Text('set as default address')
                ],
              ),
              SizedBox(height: height * 0.042),
              _name.text.isEmpty ||
                      _mobile.text.isEmpty ||
                      _pincode.text.isEmpty ||
                      _city.text.isEmpty ||
                      _state.text.isEmpty ||
                      _email.text.isEmpty
                  ? Container(
                      height: width * 0.12,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade300,
                      ),
                      child: RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            addAddress();
                          });
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.038,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: width * 0.12,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.yellow.shade700.withOpacity(0.7),
                      ),
                      child: RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            addAddress();
                          });
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.038,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget fullAddress(String hinttext, TextEditingController controller) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: width * 0.04),
      width: width,
      height: width * 0.18,
      child: TextFormField(
        controller: controller,
        onChanged: (_) {
          setState(() {});
        },
        cursorColor: Colors.yellow.shade800,
        cursorWidth: 1.2,
        maxLines: 3,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: width * 0.032),
            hintText: hinttext,
            hintStyle: TextStyle(fontSize: width * 0.037),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget buildForm(String hinttext, TextEditingController controller) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: width * 0.04),
      width: width,
      height: width * 0.06,
      child: TextFormField(
        controller: controller,
        onChanged: (_) {
          setState(() {});
        },
        cursorColor: Colors.yellow.shade800,
        cursorWidth: 1.2,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(fontSize: width * 0.037),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }

  Widget divider() {
    return Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }
}
