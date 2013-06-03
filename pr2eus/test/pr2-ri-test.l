(require :unittest "lib/llib/unittest.l")
(load "package://pr2eus/pr2-interface.l")

(init-unit-test)

(deftest test-wait-interpolation
  (setq *pr2* (pr2))

  (while (or (not (boundp '*ri*)) (send *ri* :simulation-modep))
    (setq *ri* (instance pr2-interface :init)))

  (send *pr2* :reset-pose)
  (send *ri* :angle-vector (send *pr2* :angle-vector) 2000)
  (send *ri* :wait-interpolation)

  (makunbound '*ri*)
  )

(deftest test-tuckle-arm
  (dotimes (i 3)
    (while (or (not (boundp '*ri*)) (send *ri* :simulation-modep))
      (setq *ri* (instance pr2-interface :init)))
    (pr2-tuckarm-pose :larm)
    (pr2-tuckarm-pose :rarm)
    (makunbound '*ri*)
    ))

(run-all-tests)
(exit)
