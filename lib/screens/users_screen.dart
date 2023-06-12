import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/consts/global_colors.dart';
import 'package:store_app/models/user_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/loading_widget.dart';
import 'package:store_app/widgets/my_error_widget.dart';
import 'package:store_app/widgets/no_data_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Column(children: [
        FutureBuilder<List<UserModel>>(
          future: APIHandler.getAllUsers(),
          builder: (context, snapshot) {
            // laoding
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            // no data
            else if (!snapshot.hasData) {
              return const NoData();
            }
            // error
            else if (snapshot.hasError) {
              return MyErrorWidget(
                  errorMessage: 'An Error Occured ${snapshot.error}');
            }
            // success
            return UserListTile(
              userList: snapshot.data!,
            );
          },
        ),
      ]),
    );
  }
}

class UserListTile extends StatelessWidget {
  final List<UserModel> userList;
  const UserListTile({
    super.key,
    required this.userList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
              value: userList[index], child: const UserTile()),
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserModel userModelProvider = Provider.of(context);
    return ListTile(
      leading: Image.network(userModelProvider.avatar!),
      title: Text(userModelProvider.name.toString()),
      subtitle: Text(userModelProvider.email.toString()),
      trailing: Text(
        userModelProvider.role.toString(),
        style: TextStyle(color: lightIconsColor),
      ),
    );
  }
}
