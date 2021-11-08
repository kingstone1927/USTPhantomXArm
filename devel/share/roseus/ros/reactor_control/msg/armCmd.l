;; Auto-generated. Do not edit!


(when (boundp 'reactor_control::armCmd)
  (if (not (find-package "REACTOR_CONTROL"))
    (make-package "REACTOR_CONTROL"))
  (shadow 'armCmd (find-package "REACTOR_CONTROL")))
(unless (find-package "REACTOR_CONTROL::ARMCMD")
  (make-package "REACTOR_CONTROL::ARMCMD"))

(in-package "ROS")
;;//! \htmlinclude armCmd.msg.html


(defclass reactor_control::armCmd
  :super ros::object
  :slots (_current _accel _vel _angle _msg_ctr ))

(defmethod reactor_control::armCmd
  (:init
   (&key
    ((:current __current) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:accel __accel) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:vel __vel) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:angle __angle) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:msg_ctr __msg_ctr) 0)
    )
   (send-super :init)
   (setq _current __current)
   (setq _accel __accel)
   (setq _vel __vel)
   (setq _angle __angle)
   (setq _msg_ctr (round __msg_ctr))
   self)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:accel
   (&optional __accel)
   (if __accel (setq _accel __accel)) _accel)
  (:vel
   (&optional __vel)
   (if __vel (setq _vel __vel)) _vel)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:msg_ctr
   (&optional __msg_ctr)
   (if __msg_ctr (setq _msg_ctr __msg_ctr)) _msg_ctr)
  (:serialization-length
   ()
   (+
    ;; float32[6] _current
    (* 4    6)
    ;; float32[6] _accel
    (* 4    6)
    ;; float32[6] _vel
    (* 4    6)
    ;; float32[6] _angle
    (* 4    6)
    ;; uint32 _msg_ctr
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[6] _current
     (dotimes (i 6)
       (sys::poke (elt _current i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[6] _accel
     (dotimes (i 6)
       (sys::poke (elt _accel i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[6] _vel
     (dotimes (i 6)
       (sys::poke (elt _vel i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[6] _angle
     (dotimes (i 6)
       (sys::poke (elt _angle i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; uint32 _msg_ctr
       (write-long _msg_ctr s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[6] _current
   (dotimes (i (length _current))
     (setf (elt _current i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[6] _accel
   (dotimes (i (length _accel))
     (setf (elt _accel i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[6] _vel
   (dotimes (i (length _vel))
     (setf (elt _vel i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[6] _angle
   (dotimes (i (length _angle))
     (setf (elt _angle i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; uint32 _msg_ctr
     (setq _msg_ctr (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get reactor_control::armCmd :md5sum-) "5117dac10d971bfa5afe9a1d2ba6497a")
(setf (get reactor_control::armCmd :datatype-) "reactor_control/armCmd")
(setf (get reactor_control::armCmd :definition-)
      "float32[6] current #amp
float32[6] accel #deg/s^2
float32[6] vel #deg/s
float32[6] angle #deg
uint32 msg_ctr  # count number of messages to detect missed msgs

")



(provide :reactor_control/armCmd "5117dac10d971bfa5afe9a1d2ba6497a")


