Rails.application.routes.draw do   
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  root 'sessions#new'   # home  

  post 'login' => 'sessions#create'    # user login

  delete 'logout' => 'sessions#destroy'    # user logout 

  get 'about' => 'static_pages#about'   # about page 

  get 'contact' => 'static_pages#contact'   # contact page 

  post 'contact' => 'static_pages#create'   # send contact message 
 
  post 'acceptor' => 'acceptors#create'

  post 'record_time' => 'acceptors#record_time'  # record time user works on job
   
  post 'urgent' => 'jobs#mark_as_urgent'   # mark job as urgent job
 
  get 'completed_jobs' => 'jobs#completed_jobs'   # show all completed jobs
 
  get 'my_jobs' => 'jobs#my_jobs'   # show all my current jobs
  
  get 'active_jobs' => 'jobs#active_jobs'  # show allactive jobs(urgents+currents)
  
  post 'close_job' => 'jobs#close_job'  # close completed jobs
 
  post 'reactivate_job' => 'jobs#reactivate_job'   # re-active job
 
  post 'disable' => 'users#disable_user'    # delete user
 
  # RESTful architecture
  resources :comments, only: [:create, :destroy]
  resources :users, only: [:new, :create, :edit, :update, :index]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :jobs, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :rigs, only: [:new, :create, :edit, :update, :destroy, :index] 
 
  get '*path' => redirect('/')   # if no route matches, redirect to root-path  

end
