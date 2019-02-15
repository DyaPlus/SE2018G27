import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ShowAnalysisComponent } from './show-analysis.component';

describe('ShowAnalysisComponent', () => {
  let component: ShowAnalysisComponent;
  let fixture: ComponentFixture<ShowAnalysisComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ShowAnalysisComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ShowAnalysisComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
