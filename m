Return-Path: <SRS0=zxAK=BH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89685C433DF
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jul 2020 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BF620786
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jul 2020 18:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgG1Sf0 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:35:26 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:36206 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgG1SfZ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Jul 2020 14:35:25 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 95AE820460;
        Tue, 28 Jul 2020 18:35:23 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] dissect: add support for _Generic
Date:   Tue, 28 Jul 2020 20:35:07 +0200
Message-Id: <20200728183507.422662-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Tue, 28 Jul 2020 18:35:23 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

No special support needed for _Generic, so just suppress the warning
about unknown type.

Before:

$ ./test-dissect validation/generic-functions.c

FILE: validation/generic-functions.c

  13:1                    def   f testf                            void ( ... )
  13:1   testf            def . v a                                float
validation/generic-functions.c:13:1: warning: bad expr->type: 31
  13:1   testf            -r- . v a                                float
  14:1                    def   f testd                            void ( ... )
  14:1   testd            def . v a                                double
validation/generic-functions.c:14:1: warning: bad expr->type: 31
  14:1   testd            -r- . v a                                double
  15:1                    def   f testl                            void ( ... )
  15:1   testl            def . v a                                long double
validation/generic-functions.c:15:1: warning: bad expr->type: 31
  15:1   testl            -r- . v a                                long double

After:

$ ./test-dissect validation/generic-functions.c

FILE: validation/generic-functions.c

  13:1                    def   f testf                            void ( ... )
  13:1   testf            def . v a                                float
  13:1   testf            -r- . v a                                float
  14:1                    def   f testd                            void ( ... )
  14:1   testd            def . v a                                double
  14:1   testd            -r- . v a                                double
  15:1                    def   f testl                            void ( ... )
  15:1   testl            def . v a                                long double
  15:1   testl            -r- . v a                                long double

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 dissect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dissect.c b/dissect.c
index ccb7897b..b494f93c 100644
--- a/dissect.c
+++ b/dissect.c
@@ -342,6 +342,7 @@ again:
 	case EXPR_TYPE:		// [struct T]; Why ???
 	case EXPR_VALUE:
 	case EXPR_FVALUE:
+	case EXPR_GENERIC:
 
 	break; case EXPR_LABEL:
 		ret = &label_ctype;
-- 
2.25.4

