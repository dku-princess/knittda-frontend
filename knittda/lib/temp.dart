return Padding(
padding: EdgeInsets.only(top: 10),
child: SizedBox(
width: double.infinity,
height: 36,
child: TextButton(
onPressed: () {
// 버튼 클릭 동작
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => ChangeNotifierProvider(
create: (_) => AddWorkViewModel(context.read<WorkViewModel>()),
child: SearchPatterns(),
)
),
);

},
style: TextButton.styleFrom(
backgroundColor: Colors.grey[300],
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(5),
),
padding: EdgeInsets.zero,
),
child: Icon(
Icons.add,
color: Colors.white,
size: 24,
),
),
),
);
}
},
),
),
],
