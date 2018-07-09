import * as React from 'react';

import './SignIn.css';

import { AuthenticationDetails, CognitoUser, CognitoUserPool } from 'amazon-cognito-identity-js';

interface ISignInPageProps{ siteSettings:SiteSettings };
export default class SignInPage extends React.Component<ISignInPageProps> {
  protected usernameComponentRef: React.RefObject<HTMLInputElement>;
  protected passwordComponentRef: React.RefObject<HTMLInputElement>;
  constructor(props:ISignInPageProps){
      super(props);
      this.signIn = this.signIn.bind(this);
      this.usernameComponentRef = React.createRef();
      this.passwordComponentRef = React.createRef();
    }

    public render(){
        return <form className="form-signin" onSubmit={this.signIn}>
        <h1 className="h3 mb-3 font-weight-normal">Please sign in</h1>
        <label htmlFor="userId" className="sr-only">Email address</label>
        <input type="text" id="userId" className="form-control" placeholder="User name/email address" ref={this.usernameComponentRef}  required={true} autoFocus={true}/>
        <label htmlFor="inputPassword" className="sr-only"  >Password</label>
        <input type="password" id="inputPassword" className="form-control" placeholder="Password" ref={this.passwordComponentRef} required={true}/>
        <div className="checkbox mb-3">
          <label>
            <input type="checkbox" value="remember-me"/><label>Remember me</label>
          </label>
        </div>
        <button className="btn btn-lg btn-primary btn-block" type="submit" >Sign in</button>
        <p className="mt-5 mb-3 text-muted">© 2017-2018</p>
      </form>;
    }

    private signIn(event:React.FormEvent<HTMLFormElement>) {
      event.preventDefault();
      const username=this.usernameComponentRef.current && this.usernameComponentRef.current.value;
      if(!username){
        return;
      }

      const password=this.passwordComponentRef.current && this.passwordComponentRef.current.value;
      if(!password){
        return;
      }

      const { siteSettings } = this.props;
      const user=new CognitoUser({
        Pool: new CognitoUserPool({UserPoolId:siteSettings.identity.userPoolId,ClientId:siteSettings.identity.clientId}),
        Username: username
      });

      user.authenticateUser(new AuthenticationDetails({Username:username,Password:password}),{
        onFailure: (err)=>{siteSettings.identity.token=''},
        onSuccess: (result)=>{
          siteSettings.identity.token = result.getAccessToken().getJwtToken();
        }
      })
    }    
}
