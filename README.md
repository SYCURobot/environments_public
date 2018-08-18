Environments
============

RobotBoard &amp; MegaBoard environments

#How to
##Take logs

   * from workspace cd tools
   * prepare the robot and ./run
   * ./start_manual_log.php
    Note:
      * When the robot is handled, it doesn't take any images.
      * Try to take images in all the possible situations in game.
        If the images are too similar the robot might overfit.
      * It would be better to take images with all the robots
        since the vision can a bit different.
   * shutdown the motors rhio 10.0.0.1 em
   * create and go to the folder in which you want to download the logs
   * run the script from this folder: ../path_to_workspace/tools/dowloadManualLogs.sh
   * when it's finished you can halt the robot

##Lunch fake mode
###Without logs

   * from workspace cd env/fake
   * ln -sf ../common/vision_filters/all_fake.json env/fake/vision_config.json
   * ./prepare.sh robot_name
   * ./run_nv.sh
   * lunch rhio

###With logs

   * from workspace cd src/sycurobot/environments_public/fake
   * ln -sf ../common/vision_filters/all_fake.json vision_config.json
   * ./prepare.sh robot_name path_to_log
     Note: path_to_log should be the path to a folder containing lowLevel.log
   * cd ../common/vision_filters
   * uncomment ' //  "display" : true,' in the filters you want to see. For example :
       * ball_detection.json
       * goals.json
       * robots.json
       * colors.json
   * ./run.sh
   * navigate in the images (you have to click on of the images window):
       * u : update
       * n : next
       * p : previous
       * space : repeat last command
   * you can also lunch rhio and tune the parameters of the filters
   * at the end, comment again the // "display" : true. For example you can use git checkout

##Train neural networks
###Extract patches

   * from workspace cd src/sycurobot/environments_public/fake
   * ln -sf ../common/vision_filters/roi_extractor.json vision_config.json
   * in vision_config.json
       * choose which data you would like to extract
         ball/goal/obstacle by commenting (//) the ones you don't want.
       * choose the periode
         Note: period=1 means that all the images will be processed.
   * ./extract_patches.sh path_to_logs
       * path_to_log should be the path to a folder containing the folder sycu2 or sycu4.
       * extract_patches.sh removes the previous patches folder 
   * if you have to much or not enough images, change the period value or take new logs
 
