from flask import Flask, jsonify, request, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///invictus.db"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
CORS(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(100), nullable=False)
    password = db.Column(db.String(100), nullable=False)

    def __repr__(self) -> str:
        return f"#{self.id} - {self.email}"

@app.route('/add', methods=['POST'])
def add():    
    email = request.json['email']
    password = request.json['password']
    
    existing_user = User.query.filter_by(email=email).first()
    if existing_user:
        return jsonify({'success': False, 'message': 'Email already exists'}), 400

    # hashed_password = generate_password_hash(password, method='sha256')

    # new_user = User(email=email, password=hashed_password)
    new_user = User(email=email, password=password)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'success': True, 'message': 'Signup successful'}), 200
  
@app.route('/show')
def all():   
    return jsonify({'success': True, 'message': 'To be implemented'}), 200

@app.route('/update/<int:sno>', methods=['GET', 'POST'])
def update(sno):    
    return jsonify({'success': True, 'message': 'To be implemented'}), 200

@app.route('/delete/<int:sno>')
def delete(sno):
    user = User.query.filter_by(sno=sno).first()
    db.session.delete(user)
    db.session.commit()
    return jsonify({'success': True, 'message': 'User deleted'}), 200

with app.app_context():   
    db.create_all()
if __name__ == "__main__":
    app.run(debug=True, port=8000)