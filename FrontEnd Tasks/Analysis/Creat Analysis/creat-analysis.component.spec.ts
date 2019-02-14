import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CreatAnalysisComponent } from './creat-analysis.component';

describe('CreatAnalysisComponent', () => {
  let component: CreatAnalysisComponent;
  let fixture: ComponentFixture<CreatAnalysisComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CreatAnalysisComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CreatAnalysisComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
