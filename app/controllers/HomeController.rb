class HomeController
 def initialize(homeDao, homeView, config)
  @homeDao, @homeView, @running, @config = homeDao, homeView, true, config
  @thread = Thread.new{ run() }
 end
    
 def run
  while @running
   @running = @homeView.getRunning()
   @config.mutex().lock
    if(@homeDao.isClientActiveResource() == true) then
     @running = false
     @homeView.asignDataImage(@homeDao.dataResource()) 
    end
    @homeView.status(@homeDao.getStatus())
   @config.mutex().unlock
   sleep(1)       
  end
  @homeDao.killServer
 end
    
 def threadPresent
  return @thread
 end 
end