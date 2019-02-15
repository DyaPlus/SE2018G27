import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PrescribtionComponent } from './prescribtion.component';

describe('PrescribtionComponent', () => {
  let component: PrescribtionComponent;
  let fixture: ComponentFixture<PrescribtionComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PrescribtionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PrescribtionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
