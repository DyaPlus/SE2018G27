import { RouterModule, Routes } from '@angular/router';
import { ModuleWithProviders } from "@angular/core";
import { AnalysisComponent } from './analysis/analysis.component';
import { ReportsComponent } from './reports/reports.component';
import { HealthinsuranceComponent } from './healthinsurance/healthinsurance.component';
import { SignupComponent } from './signup/signup.component';


const routes: Routes = [
    { path: '',  redirectTo: 'Analysis', pathMatch: 'full' },
    { path: 'Analysis', component: AnalysisComponent },
    { path: 'Reports', component: ReportsComponent },
    { path: 'SignUp', component: SignupComponent },

];


export const routingModule: ModuleWithProviders = RouterModule.forRoot(routes);

