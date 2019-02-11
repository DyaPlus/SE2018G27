import { RouterModule, Routes } from '@angular/router';
import { ModuleWithProviders } from "@angular/core";
import { AnalysisComponent } from './analysis/analysis.component';
import { ReportsComponent } from './reports/reports.component';
import { HealthinsuranceComponent } from './healthinsurance/healthinsurance.component';
import { SignupComponent } from './signup/signup.component';
import { OnlineReserveComponent } from './online-reserve/online-reserve.component';
import { AboutusComponent } from './aboutus/aboutus.component';
import { HomepageComponent } from './homepage/homepage.component';
import { LoginComponent } from './login/login.component';


const routes: Routes = [
    { path: '',  redirectTo: 'HomePage', pathMatch: 'full' },
    //{ path: 'Analysis', component: AnalysisComponent },
    { path: 'Reports', component: ReportsComponent },
    { path: 'SignUp', component: SignupComponent },
    { path: 'OnlineReservations', component: OnlineReserveComponent },
    { path:'AboutUs',    component:AboutusComponent},
    { path:'HomePage',    component:HomepageComponent},
    { path:'Login',    component:LoginComponent}


];


export const routingModule: ModuleWithProviders = RouterModule.forRoot(routes);

