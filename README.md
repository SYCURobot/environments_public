Environments
============

RobotBoard &amp; MegaBoard environments

#How to
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
   * uncomment ' //  "display" : true,' in the filters you want to see. For example :
       * common/vision_filters/ball_detection.json
       * common/vision_filters/goals.json
       * common/vision_filters/robots.json
       * common/vision_filters/colors.json
   * ./run.sh
   * lunch rhio
   * naviate in the images:
       * u : update
       * n : next
       * p : previous
       * space : repeat
   * at the end, comment again the // "display" : true. For example you can use git checkout
