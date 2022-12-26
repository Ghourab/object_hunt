import '../models/user.dart';

List<User> getUsersList() {
  return <User>[
    User(
      name: 'Ahmed Sameh',
      id: 1,
      email: 'ahmed@gmail.com',
      password: 'ahmed22',
      dob: '06/08/2001',
      image: 'http://'
    )
  ];
}
