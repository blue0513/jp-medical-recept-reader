;;; jp-medical-recept-reader --- show japanese medical recept info

;; Author: blue0513
;; URL: https://github.com/blue0513/point-history
;; Version: 0.1.0

;;; Commentary:

;; Edit your init.el
;;
;; (require 'jp-medical-recept-reader)
;;

;;; Code:

(require 'posframe)
(require 'dash)

(defvar mrr-recept-posframe-buffer " *recept-posframe")
(defvar mrr-recept-buffer-showing nil)

(defun mrr--build-day-info (limit)
  (let* ((value))
    (dotimes (number limit value)
      (let* ((str (format "%s日の情報" (+ 1 number))))
        (setq value (cons str value))))
    (reverse value)))

(defvar ir-record-header
  (list
   "レコード識別情報"
   "審査支払機関"
   "都道府県"
   "点数表"
   "医療機関コード"
   "予備"
   "医療機関名称"
   "請求年月"
   "マルチボリューム識別情報"
   "電話番号"
   ))

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

(defvar gr-record-header
  (list
   "レコード識別情報"
   "医科点数表算定理由"
   "ＤＰＣコード"))

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
  (-flatten (list
   "レコード識別情報"
   "診療識別"
   "負担区分"
   "診療行為コード"
   "数量データ"
   "点数"
   "回数"
   "コメントコード"
   "文字データ"
   "コメントコード"
   "文字データ"
   "コメントコード"
   "文字データ"
   (mrr--build-day-info 31))))

(defvar iy-record-header
  (-flatten (list
   "レコード識別情報"
   "診療識別"
   "負担区分"
   "医薬品コード"
   "使用量"
   "点数"
   "回数"
   "コメントコード"
   "文字データ"
   "コメントコード"
   "文字データ"
   "コメントコード"
   "文字データ"
   (mrr--build-day-info 31))))

(defvar to-record-header
  (-flatten (list
   "レコード識別情報"
   "診療識別"
   "負担区分"
   "特定器材コード"
   "使用量"
   "点数"
   "回数"
   "単位コード"
   "単価"
   "予備"
   "商品名及び規格又はサイズ"
   "コメントコード"
   "文字データ"
   "コメントコード"
   "文字データ"
   "コメントコード"
   "文字データ"
   (mrr--build-day-info 31))))

(defvar co-record-header
  (list
   "レコード識別情報"
   "診療識別"
   "負担区分"
   "コメントコード"
   "文字データ"))

(defvar sj-record-header
  (list
   "レコード識別情報"
   "症状詳記区分"
   "症状詳記データ"))

(defun mrr--build-message (result)
  (let* ((value ""))
    (dolist (element result)
      (setq value
            (concat value (format "%s : %s\n" (car element) (cdr element)))))
    value))

(defun mrr-show-recept-info-of (record-header my-list)
  (let* ((result (mapcar* #'cons record-header my-list))
         (str (mrr--build-message result)))
    (mrr-recept-show str)))

(defun mrr-recept-show (str)
  (posframe-show
   mrr-recept-posframe-buffer
   :string str
   :posion (point)
   :min-width 40
   :no-properties nil
   :internal-border-width 10
   :background-color "black")
  (setq mrr-recept-buffer-showing t))

(defun mrr-show-recept-info ()
  (let* ((line (thing-at-point 'line t))
         (my-list (split-string line ",")))
    (when (string= (car my-list) "IR")
      (mrr-show-recept-info-of ir-record-header my-list))
    (when (string= (car my-list) "RE")
      (mrr-show-recept-info-of re-record-header my-list))
    (when (string= (car my-list) "HO")
      (mrr-show-recept-info-of ho-record-header my-list))
    (when (string= (car my-list) "KO")
      (mrr-show-recept-info-of ko-record-header my-list))
    (when (string= (car my-list) "GR")
      (mrr-show-recept-info-of gr-record-header my-list))
    (when (string= (car my-list) "SY")
      (mrr-show-recept-info-of sy-record-header my-list))
    (when (string= (car my-list) "SI")
      (mrr-show-recept-info-of si-record-header my-list))
    (when (string= (car my-list) "IY")
      (mrr-show-recept-info-of iy-record-header my-list))
    (when (string= (car my-list) "TO")
      (mrr-show-recept-info-of to-record-header my-list))
    (when (string= (car my-list) "CO")
      (mrr-show-recept-info-of co-record-header my-list))
    (when (string= (car my-list) "SJ")
      (mrr-show-recept-info-of sj-record-header my-list))))

(defun mrr-hide-recept-info ()
  (setq mrr-recept-buffer-showing nil)
  (posframe-delete mrr-recept-posframe-buffer))

(defun recept-info-toggle ()
  (interactive)
  (if mrr-recept-buffer-showing
      (mrr-hide-recept-info)
    (mrr-show-recept-info)))

;; * provide

(provide 'jp-medical-recept-reader)

;;; jp-medical-recept-reader.el ends here
