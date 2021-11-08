;; Auto-generated. Do not edit!


(when (boundp 'reactor_control::reactorTelemetry)
  (if (not (find-package "REACTOR_CONTROL"))
    (make-package "REACTOR_CONTROL"))
  (shadow 'reactorTelemetry (find-package "REACTOR_CONTROL")))
(unless (find-package "REACTOR_CONTROL::REACTORTELEMETRY")
  (make-package "REACTOR_CONTROL::REACTORTELEMETRY"))

(in-package "ROS")
;;//! \htmlinclude reactorTelemetry.msg.html


(defclass reactor_control::reactorTelemetry
  :super ros::object
  :slots (_angle _vel _current _startSyncTime _isrTicks _bufferHealth ))

(defmethod reactor_control::reactorTelemetry
  (:init
   (&key
    ((:angle __angle) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:vel __vel) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:current __current) (make-array 6 :initial-element 0.0 :element-type :float))
    ((:startSyncTime __startSyncTime) (instance ros::time :init))
    ((:isrTicks __isrTicks) 0)
    ((:bufferHealth __bufferHealth) 0)
    )
   (send-super :init)
   (setq _angle __angle)
   (setq _vel __vel)
   (setq _current __current)
   (setq _startSyncTime __startSyncTime)
   (setq _isrTicks (round __isrTicks))
   (setq _bufferHealth (round __bufferHealth))
   self)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:vel
   (&optional __vel)
   (if __vel (setq _vel __vel)) _vel)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:startSyncTime
   (&optional __startSyncTime)
   (if __startSyncTime (setq _startSyncTime __startSyncTime)) _startSyncTime)
  (:isrTicks
   (&optional __isrTicks)
   (if __isrTicks (setq _isrTicks __isrTicks)) _isrTicks)
  (:bufferHealth
   (&optional __bufferHealth)
   (if __bufferHealth (setq _bufferHealth __bufferHealth)) _bufferHealth)
  (:serialization-length
   ()
   (+
    ;; float32[6] _angle
    (* 4    6)
    ;; float32[6] _vel
    (* 4    6)
    ;; float32[6] _current
    (* 4    6)
    ;; time _startSyncTime
    8
    ;; uint32 _isrTicks
    4
    ;; uint8 _bufferHealth
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[6] _angle
     (dotimes (i 6)
       (sys::poke (elt _angle i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[6] _vel
     (dotimes (i 6)
       (sys::poke (elt _vel i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[6] _current
     (dotimes (i 6)
       (sys::poke (elt _current i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; time _startSyncTime
       (write-long (send _startSyncTime :sec) s) (write-long (send _startSyncTime :nsec) s)
     ;; uint32 _isrTicks
       (write-long _isrTicks s)
     ;; uint8 _bufferHealth
       (write-byte _bufferHealth s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[6] _angle
   (dotimes (i (length _angle))
     (setf (elt _angle i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[6] _vel
   (dotimes (i (length _vel))
     (setf (elt _vel i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[6] _current
   (dotimes (i (length _current))
     (setf (elt _current i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; time _startSyncTime
     (send _startSyncTime :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _startSyncTime :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _isrTicks
     (setq _isrTicks (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _bufferHealth
     (setq _bufferHealth (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get reactor_control::reactorTelemetry :md5sum-) "fbf117927605fc3413c0528694294257")
(setf (get reactor_control::reactorTelemetry :datatype-) "reactor_control/reactorTelemetry")
(setf (get reactor_control::reactorTelemetry :definition-)
      "#Header header 
float32[6] angle # degrees
float32[6] vel # deg/s
float32[6] current # amps
#time armReadTimestamp 
time startSyncTime 
uint32 isrTicks # this would overflow if the robot is left on for 497 days straight at 100 hz 
uint8 bufferHealth
")



(provide :reactor_control/reactorTelemetry "fbf117927605fc3413c0528694294257")


