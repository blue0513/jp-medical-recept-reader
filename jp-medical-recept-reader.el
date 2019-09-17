(defvar recept-posframe-buffer " *recept-posframe")

(defvar re-record-header
  (list
   "レコード識別情報"
   "レセプト番号"
   "レセプト種別"
   "診療年月"
   "氏名"
   "男女区分"
   "生年月日"
   "給付割合"
   "入院年月日"
   "病棟区分"
   "一部負担金"
   "レセプト特記事項"
   "病床数"
   "カルテ番号等"
   "割引点数単価"
   "予備"
   "予備"
   "予備"
   "検索番号"
   "記録条件仕様年月情報"
   "請求情報"
   "診療科名"
   "人体の部位等"
   "性別等"
   "医学的処置"
   "特定疾病"
   "診療科名"
   "人体の部位等"
   "性別等"
   "医学的処置"
   "特定疾病"
   "診療科名"
   "人体の部位等"
   "性別等"
   "医学的処置"
   "特定疾病"
   "カタカナ（氏名）"
   "患者の状態"))

(defun build-message (result)
  (let* ((value ""))
    (dolist (element result)
      (setq value (concat value (format "%s : %s\n" (car element) (cdr element)))))
    (recept-show (format "%s" value))))

(defun recept-show (str)
  (posframe-show
   recept-posframe-buffer
   :string str
   :no-properties nil
   :background-color "black"))

(defun show-recept-info ()
  (interactive)
  (let* ((line (thing-at-point 'line t))
         (my-list (split-string line ",")))
    (when (string= (car my-list) "RE")
      (let* ((result (mapcar* #'cons re-record-header my-list)))
        (build-message result)))))
