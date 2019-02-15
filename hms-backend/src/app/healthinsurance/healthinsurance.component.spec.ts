import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HealthinsuranceComponent } from './healthinsurance.component';

describe('HealthinsuranceComponent', () => {
  let component: HealthinsuranceComponent;
  let fixture: ComponentFixture<HealthinsuranceComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HealthinsuranceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthinsuranceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
