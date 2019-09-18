(defvar recept-posframe-buffer " *recept-posframe")
(defvar recept-buffer-showing nil)

(defvar ir-record-header
  (list))

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

(defvar gr-record-header
  (list))

(defvar ho-record-header
  (list
   "レコード識別情報"
   "保険者番号"
   "被保険者証"
   "被保険者証"
   "診療実日数"
   "合計点数"
   "予備"
   "食事療養回数"
   "食事療養合計金額"
   "職務上の事由"
   "証明書番号"
   "負担金額医療保険"
   "減免区分"
   "減額割合"
   "減額金額"))

(defvar ko-record-header
  (list
   "レコード識別情報"
   "公費負担者番号"
   "公費受給者番号"
   "任意給付区分"
   "診療実日数"
   "合計点数"
   "公費負担金額"
   "公費給付対象外来一部負担金"
   "公費給付対象入院一部負担金"
   "予備"
   "食事療養・生活療養回数"
   "食事療養・生活療養合計金額"))

(defvar sy-record-header
  (list
   "レコード識別情報"
   "傷病名コード"
   "診療開始日"
   "転帰区分"
   "修飾語コード"
   "傷病名称"
   "主傷病"
   "補足コメント"))

(defvar si-record-header
  (list))

(defvar to-record-header
  (list))

(defvar co-record-header
  (list))

(defvar sj-record-header
  (list))

(defun build-message (result)
  (let* ((value ""))
    (dolist (element result)
      (setq value
            (concat value (format "%s : %s\n" (car element) (cdr element)))))
    value))

(defun show-recept-info-of (record-header my-list)
  (let* ((result (mapcar* #'cons record-header my-list))
         (str (build-message result)))
    (recept-show str)))

(defun recept-show (str)
  (posframe-show
   recept-posframe-buffer
   :string str
   :no-properties nil
   :background-color "black")
  (setq recept-buffer-showing t))

(defun show-recept-info ()
  (let* ((line (thing-at-point 'line t))
         (my-list (split-string line ",")))
    (when (string= (car my-list) "IR")
      (show-recept-info-of ir-record-header my-list))
    (when (string= (car my-list) "RE")
      (show-recept-info-of re-record-header my-list))
    (when (string= (car my-list) "GR")
      (show-recept-info-of gr-record-header my-list))
    (when (string= (car my-list) "HO")
      (show-recept-info-of ho-record-header my-list))
    (when (string= (car my-list) "KO")
      (show-recept-info-of ko-record-header my-list))
    (when (string= (car my-list) "SY")
      (show-recept-info-of sy-record-header my-list))
    (when (string= (car my-list) "SI")
      (show-recept-info-of si-record-header my-list))
    (when (string= (car my-list) "TO")
      (show-recept-info-of to-record-header my-list))
    (when (string= (car my-list) "CO")
      (show-recept-info-of co-record-header my-list))
    (when (string= (car my-list) "SJ")
      (show-recept-info-of sj-record-header my-list))))

(defun hide-recept-info ()
  (setq recept-buffer-showing nil)
  (posframe-delete recept-posframe-buffer))

(defun toggle-recept-info ()
  (interactive)
  (if recept-buffer-showing
      (hide-recept-info)
    (show-recept-info)))
