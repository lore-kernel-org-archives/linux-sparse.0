Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A853C433F5
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 23:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4287661178
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 23:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhI0XuF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:50:05 -0400
Received: from avasout02.plus.net ([212.159.14.17]:40914 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbhI0XuE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Sep 2021 19:50:04 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id V0JGmVrutrasdV0JHmS0x2; Tue, 28 Sep 2021 00:45:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632786323; bh=cD1HzRWaHvTbv53SY60l+IsBqX9tasq0WuBUFu8+JJo=;
        h=To:Cc:From:Subject:Date;
        b=LELOwc8zRs5tfIIi9eNGyNgN0mcB4gOom27pnPL+MmYA11sqXjs5xvu5rNT/VoRT2
         li524rv0tySUT9w/Aqdo5IBaoNglkB9ET0pyU0YUlL7gz+camHE8dIi1oSqVA4KJOJ
         PALGBOEfIQ8CoC7MM3EUiO/gNn500HlS2GOBPNKKLbmDv513uJYTeUckxauQLapCwU
         cq6dC/Bvrj1VzyLHGILR2qUeW0k5AQ1k2hdEFgaNg0o4czmw2UeGkCRV+ExteB+cZ2
         cx7mqdSBP7eG9pGgNUwdC2A1uzVMY322ldnI29noBwE6A6fuxsQjyyF6gJmkZjMw4U
         RSGJbGnMH+ewg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=dIE9ZNRb c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=b4LDLZbEAAAA:8 a=EBOSESyhAAAA:8 a=Sk9poceGs4Y71efpYO0A:9
 a=QEXdDO2ut3YA:10 a=20T61YgZp4ItGotXEy2O:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] parse: warn about a 'case label' on empty statement
Message-ID: <c47fb74a-0439-138a-4837-97ff9c983b71@ramsayjones.plus.com>
Date:   Tue, 28 Sep 2021 00:45:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE0npydCVi8/LgyZsYDZzfnKiunwwS+bSY6OXk8NhLNwZrD8MW4uGtGsgRs3b3A2C4KFD1QFR27Vcc1FroKgZB9zm0g/oLq0HptNfZfv85+VirFEoMNG
 0xm5h89z6epMRJZwtZpPkcp55/Us9NfFhe3lSh6rWxFAj2Yay4Gx7AbT/klcAhtcifsmWxDZdI/iCQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


Commit 0d6bb7e1 ("handle more graciously labels with no statement",
2020-10-26) allowed a label to appear just before the closing brace
of a compound statement. This is not valid C (which would require
at least a null statement). Similarly, a case label is also not
allowed to appear just before a closing brace.

So, extend the solution of commit 0d6bb7e1 to issue a warning for
case labels and 'insert' a null statement.

Note that the next C standard (C23 ?) will allow even more freedom
in the placement of labels (see N2508 [1]) and make this placement
(along with others) legal C.

[1] https://www9.open-std.org/JTC1/SC22/WG14/www/docs/n2508.pdf

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 parse.c                        |  5 +++++
 validation/label-positioning.c | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 validation/label-positioning.c

diff --git a/parse.c b/parse.c
index bc1c0602..9f2a3cdf 100644
--- a/parse.c
+++ b/parse.c
@@ -2329,6 +2329,11 @@ static inline struct token *case_statement(struct token *token, struct statement
 	stmt->type = STMT_CASE;
 	token = expect(token, ':', "after default/case");
 	add_case_statement(stmt);
+	if (match_op(token, '}')) {
+		warning(token->pos, "statement expected after case label");
+		stmt->case_statement = alloc_statement(token->pos, STMT_NONE);
+		return token;
+	}
 	return statement(token, &stmt->case_statement);
 }
 
diff --git a/validation/label-positioning.c b/validation/label-positioning.c
new file mode 100644
index 00000000..583661ca
--- /dev/null
+++ b/validation/label-positioning.c
@@ -0,0 +1,22 @@
+extern int someval(void);
+
+static void func (int x)
+{
+	if (x > someval())
+		goto end;
+	switch (x) { case 0: }
+	switch (x) { case 1 ... 9: }
+	switch (x) { default: }
+end:
+}
+
+/*
+ * check-name: label-positioning
+ *
+ * check-error-start
+label-positioning.c:7:30: warning: statement expected after case label
+label-positioning.c:8:36: warning: statement expected after case label
+label-positioning.c:9:31: warning: statement expected after case label
+label-positioning.c:11:1: warning: statement expected after label
+ * check-error-end
+ */
-- 
2.33.0
