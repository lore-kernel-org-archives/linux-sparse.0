Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E6C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B570601FC
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCUMyh (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCUMya (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:54:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6CEC061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:54:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k10so16884549ejg.0
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=csq4c4+LIJ0/AwzwdbQxgLTS9q4atH+0KJxCKofT6es=;
        b=VdJQgRNaVyx7THbW31JNdIsBIEAPNtzk45kQX3oJ6PPV0CAirmdy0yec5WPeoYeSlM
         QT2ufX0A8GdRhccxGCi6AmT/iJtEPftDb4UlllZHhXng6evrPbt1DE3DH7vvQTcOQIT/
         pjF/tVl+p1oSzq24DDdtPAqdRz4lWN+7V3s2Mx97Cu5adai77w2LzIY8IDNi6RZyYOcJ
         KdKPq9fzVp3j+EAD+Ho9UHk5MtmaXMvGfZeTWF9Efq7QY3YXMkDMVq4bSpjhg7y+WNaa
         cbSy+kTF+JxLYamAWqlbBfvatl7g8fW/2rV8jrafS8izDubhshzwBaXsScgQRy0UMgUj
         y4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=csq4c4+LIJ0/AwzwdbQxgLTS9q4atH+0KJxCKofT6es=;
        b=hTGX9k/GseUhH549KPTZX1BDH715XYls/9nCs9/Wr08mDPjbWtMyNGp5pATVH+08wm
         aVyzauLyMT+PHw+WPz555BirjtWVzr6j50oEGDNc+Q2HSwow64qw06sjQ6H1moLnTTS5
         RVLwKD/ktMTQ92W7sk8epEXtezQ8sciNSPkxx3NJIHVr9Q6SaU/7E+4f16o7So+X4ys/
         hJBw/w8EI8FGpbuDpSriFp+xO1OrmS20sOxiNUAKvuChNXLUTQ6xsrEd2aU7eLc0+8Bx
         IwmLBVAOYQRReqyZ35o38mBNSEXN4EegMVbzvbTg0rOnHpV6uBPJcQClE+mS0BK1wqGj
         0CSg==
X-Gm-Message-State: AOAM530ycAbjZeV2kahQPTr0emn+9wJrTikTnhLFW0fTRtu3qooGd2A6
        9mp3pJCCHB+wCNKY+YQI8f4WpxAfPXk=
X-Google-Smtp-Source: ABdhPJxl1wbCPdLJLTLEAikm0A/bdoijFTXmf+rmFiIzHa/1baDNeLtHIygBTmWvYfTrbqMhNdyxLw==
X-Received: by 2002:a17:907:9152:: with SMTP id l18mr14109669ejs.376.1616331268978;
        Sun, 21 Mar 2021 05:54:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id k12sm8278852edr.60.2021.03.21.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:54:28 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: add option '-r' to 'test-suite format'
Date:   Sun, 21 Mar 2021 13:54:25 +0100
Message-Id: <20210321125425.28528-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Because laziness is a virtue, add an option '-r' to the 'format'
subcommand of the testsuite to quickly create a test template for
linearized code which should just return 1.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index 1b05c75e9f74..370cd35a8f70 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -512,6 +512,7 @@ echo "options:"
 echo "    -a                         append the created test to the input file"
 echo "    -f                         write a test known to fail"
 echo "    -l                         write a test for linearized code"
+echo "    -r                         write a test for linearized code returning 1"
 echo "    -p                         write a test for pre-processing"
 echo
 echo "argument(s):"
@@ -528,6 +529,7 @@ do_format()
 	append=0
 	linear=0
 	fail=0
+	ret=''
 
 	while [ $# -gt 0 ] ; do
 		case "$1" in
@@ -538,6 +540,9 @@ do_format()
 		-l)
 			def_cmd='test-linearize -Wno-decl $file'
 			linear=1 ;;
+		-r)
+			def_cmd='test-linearize -Wno-decl $file'
+			ret=1 ;;
 		-p)
 			def_cmd='sparse -E $file' ;;
 
@@ -582,6 +587,12 @@ _EOF
 	if [ $fail != 0 ]; then
 		echo " * check-known-to-fail"
 	fi
+	if [ "$ret" != '' ]; then
+		echo ' *'
+		echo ' * check-output-ignore'
+		echo " * check-output-returns: $ret"
+		rm -f "$file.output.got"
+	fi
 	if [ $linear != 0 ]; then
 		echo ' *'
 		echo ' * check-output-ignore'
-- 
2.31.0

