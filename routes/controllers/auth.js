const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken');
const rp = require('request-promise')

const { Auth } = require('../../db')


function signIn (req, res, next) {
  Auth.getUserByUsername(req.body.username).then( user => {
    user = user[0]
    console.log('what we get !!!!!!', user)
    if (!user) {
      res.status(401).json({
        error: true,
        message: 'Username or Password is Wrong'
      });
    }

    bcrypt.compare(req.body.password, user.hash_pass, function (err, valid) {
      if (!valid) {
       return res.status(404).json({
               error: true,
               message: 'Username or Password is Wrong'
         });
      }

      delete user.hash_pass, user.created_at, user.updated_at

      let data = {
        id: user.id,
        username: user.username
      }
      const token = jwt.sign(data, 'AKJOISDNFLKHALKNDSFIOHSLKJDSFLKHSDIOES');
      res.json({
         user: user,
         token: token
       });
     })
  }).catch( err => {
    console.log('what error we get !!!!!!', err)
    console.log(err);
  })
}

function signUp (req, res, next) {
  const body = req.body;
  const hash = bcrypt.hashSync(body.password.trim(), 10);
  const user = {
    username: body.username.trim(),
    hash_pass: hash,
  };

  Auth.getUserByUsername(user.username).then(response => {
    console.log('checking if username exists:  ', response)
    if (response.length) {
      res.status(401).json({
        error: true,
        message: 'Username already exists'
      });
    } else {
      Auth.createUser(user).then( response => {
        user.id = response[0].id
        delete user.hash_pass
        console.log('the user has successfully been created:  ', user)
        const token = jwt.sign(user, 'AKJOISDNFLKHALKNDSFIOHSLKJDSFLKHSDIOES');
        res.json({
           user: user,
           token: token
        });
      })
    }
  })
}


module.exports = {
  signIn,
  signUp
}
