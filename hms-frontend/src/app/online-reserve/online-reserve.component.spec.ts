import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OnlineReserveComponent } from './online-reserve.component';

describe('OnlineReserveComponent', () => {
  let component: OnlineReserveComponent;
  let fixture: ComponentFixture<OnlineReserveComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OnlineReserveComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OnlineReserveComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
