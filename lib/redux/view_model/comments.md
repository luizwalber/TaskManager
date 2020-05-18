All View Models need to have an == and hashcode, if you don't create these the widget will rebuild every time the state change instead of only when the data in VM change


if the model extends from BaseModel and adds :super(equals: [parameters]) in the constructor you don't need to implement the equals and hashcode methods