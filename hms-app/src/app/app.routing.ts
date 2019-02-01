import { RouterModule, Routes } from '@angular/router';
import { ModuleWithProviders } from "@angular/core";
import { AnalysisComponent } from './analysis/analysis.component';
import { ReportsComponent } from './reports/reports.component';


const routes: Routes = [
    { path: '',  redirectTo: 'Analysis', pathMatch: 'full' },
    { path: 'Analysis', component: AnalysisComponent },
    { path: 'Reports', component: ReportsComponent },

];


export const routingModule: ModuleWithProviders = RouterModule.forRoot(routes);

