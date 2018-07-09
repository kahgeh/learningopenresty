
import * as React from 'react';

import SignInPage from '~/components/SignInPage';

declare var siteSettings: SiteSettings;

class App extends React.Component {
  public render() {
    return (
      <SignInPage siteSettings={siteSettings}/> 
    );
  }
}

export default App;
