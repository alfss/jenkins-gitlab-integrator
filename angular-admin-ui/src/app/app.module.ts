import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule }   from '@angular/forms';
import { HttpModule }    from '@angular/http';

// companents
import { AppComponent }  from './app.component';
// config
import { ConfigComponent } from './components/config/index/config.component';
import { ConfigService } from './services/config.service';
// gitlab webhooks
// delayed task
import { DelayedTasksComponent } from './components/delayed-task/index/delayed-tasks.component';
import { DelayedTaskService } from './services/delayed-task.service';
import { DelayedTaskDetailComponent } from './components/delayed-task/show/delayed-task-detail.component';

// pipe
import { KeysPipe } from './pipes/keys.pipe';

// routing
import { AppRoutingModule } from './app-routing.module';


@NgModule({
  declarations: [
    AppComponent,
    ConfigComponent,
    DelayedTasksComponent,
    DelayedTaskDetailComponent,
    KeysPipe
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    AppRoutingModule
  ],
  providers: [
    ConfigService,
    DelayedTaskService
  ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
