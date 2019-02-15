import { RouterModule, Routes, PreloadingStrategy } from '@angular/router';
import { ModuleWithProviders } from "@angular/core";
import { AnalysisComponent } from './analysis/analysis.component';
import { ReportsComponent } from './reports/reports.component';
import { HealthinsuranceComponent } from './healthinsurance/healthinsurance.component';
import { SignupComponent } from './signup/signup.component';
import { OnlineReserveComponent } from './online-reserve/online-reserve.component';
import { AboutusComponent } from './aboutus/aboutus.component';
import { HomepageComponent } from './homepage/homepage.component';
import { LoginComponent } from './login/login.component';
import { ProfileComponent } from './profile/profile.component';
import { PrescribtionComponent } from './prescribtion/prescribtion.component';
import { FeedbackComponent } from './feedback/feedback.component';


const routes: Routes = [
    { path: '',  redirectTo: 'HomePage', pathMatch: 'full' },
    //{ path: 'Analysis', component: AnalysisComponent },
    { path: 'Reports', component: ReportsComponent },
    { path: 'SignUp', component: SignupComponent },
    { path: 'OnlineReservations', component: OnlineReserveComponent },
    { path:'AboutUs',    component:AboutusComponent},
    { path:'HomePage',    component:HomepageComponent},
    { path:'Login',    component:LoginComponent},
    {path:"Profile",component:ProfileComponent},
    {path:"Make_prescription",component:PrescribtionComponent},
    {path:"Feedback",component:FeedbackComponent}



];


export const routingModule: ModuleWithProviders = RouterModule.forRoot(routes);

