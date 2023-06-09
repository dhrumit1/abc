import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Employee(),));
}

class SaveEmployee
{
  String empName = "";
  String empId = "";
  String empPos = "";
  int empSal = 0;
}

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController Enm = TextEditingController();
  TextEditingController Eid = TextEditingController();
  TextEditingController Epos = TextEditingController();
  double Esal = 10000;
  List<SaveEmployee> sEmp = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          SizedBox(height: 30,),
          TextField(controller: Enm,decoration: InputDecoration(labelText: "Enter the Employee Name",border: OutlineInputBorder())),
          SizedBox(height: 10,),
          TextField(controller: Eid,decoration: InputDecoration(labelText: "Enter the Employee Id",border: OutlineInputBorder())),
          SizedBox(height: 10,),
          TextField(controller: Epos,decoration: InputDecoration(labelText: "Enter the Employee Position",border: OutlineInputBorder())),
          SizedBox(height: 10,),
          Text("Salary"),
          Slider(min: 10000,max: 300000,value: Esal, onChanged: (value) {
            Esal = value;
            setState(() {
              
            });
          },),
          SizedBox(height: 10,),
          Text(Esal.toInt().toString()),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: () {
            SaveEmployee emp = new SaveEmployee();
            emp.empName = Enm.text;
            emp.empId = Eid.text;
            emp.empPos = Epos.text;
            emp.empSal = Esal.toInt();
            sEmp.add(emp);
            print(emp);
          }, child: Text("save")),
        ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ListEmployee(sEmp);
        },));
      },child: Text("view"),),
    );
  }
}

class ListEmployee extends StatefulWidget {
  List<SaveEmployee> sEmp = [];
  ListEmployee(this.sEmp);

  @override
  State<ListEmployee> createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee")),
      body: ListView.builder(itemCount: widget.sEmp.length,itemBuilder: (context, index) {
        return Card(child: ListTile(
          leading: Icon(Icons.account_circle),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Details(widget.sEmp,index);
            },));
          },
          title: Text(widget.sEmp[index].empName),
          subtitle: Text(widget.sEmp[index].empId),
        ),);
      },),
    );
  }
}
class Details extends StatefulWidget {
  List<SaveEmployee> sEmp;
  int index;
  Details(this.sEmp,this.index);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text("Name:" + widget.sEmp[widget.index].empName),
            SizedBox(height: 10,),
            Text("Id:" + widget.sEmp[widget.index].empId),
            SizedBox(height: 10,),
            Text("Position:" + widget.sEmp[widget.index].empPos),
            SizedBox(height: 10,),
            Text("Salary:" + widget.sEmp[widget.index].empSal.toString()),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              widget.sEmp.removeAt(widget.index);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return ListEmployee(widget.sEmp);
              },));
            }, child: Text("Delete")),
            SizedBox(height: 10,), 
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Edit(widget.sEmp,widget.index);
              },));
            }, child: Text("Edit")),  
          ],
        ),
      ),
    );
  }
}

class Edit extends StatefulWidget {
  List<SaveEmployee> sEmp;
  int index;
  Edit(this.sEmp,this.index);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController ueNm = TextEditingController(text: widget.sEmp[widget.index].empName);
    TextEditingController ueId = TextEditingController(text: widget.sEmp[widget.index].empId);
    TextEditingController uePos = TextEditingController(text: widget.sEmp[widget.index].empPos);
    TextEditingController ueSal = TextEditingController(text: widget.sEmp[widget.index].empSal.toString());
    return Scaffold(
      appBar: AppBar(title: Text("Edit Details")),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("Name:"),
          TextField(controller: ueNm,),
          SizedBox(height: 10,),
          Text("Id:"),
          TextField(controller: ueId,),
          SizedBox(height: 10,),
          Text("Position:"),
          TextField(controller: uePos,),
          SizedBox(height: 10,),
          Text("Salary:"),
          TextField(controller: ueSal,),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: () {
            widget.sEmp[widget.index].empName = ueNm.text;
            widget.sEmp[widget.index].empId = ueId.text;
            widget.sEmp[widget.index].empPos = uePos.text;
            widget.sEmp[widget.index].empSal = int.parse(ueSal.text);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return ListEmployee(widget.sEmp);
            },));
          }, child: Text("Edit")),
        ],
      ),
    );
  }
}