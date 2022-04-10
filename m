Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A21AC433F5
	for <linux-sparse@archiver.kernel.org>; Sun, 10 Apr 2022 14:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiDJOCu (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 10 Apr 2022 10:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiDJOCu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 10 Apr 2022 10:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A6E31E3EB
        for <linux-sparse@vger.kernel.org>; Sun, 10 Apr 2022 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649599237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aFAKldw0FhFQ25eyFiFDczXMzgjYeOjeErSmgooQUh8=;
        b=Sb+3mKhJsF5uSafM3eg6JXXFmQIiAd199m+0lTwXRYkL4ZWAi6ePbbKwCoc+wQp1djuSwi
        v/ZMdRinX0/Ea7xWM8rnLqDQ6KZdstZthGkXP7gNxn0GIBUISHYXOLVMPtdB5GsBV/Vn/q
        IqY8pTIauC/Qb4wwntFueT+sGOy6M1o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-WpT_bwvfPbCLpmhIIE4cRA-1; Sun, 10 Apr 2022 10:00:36 -0400
X-MC-Unique: WpT_bwvfPbCLpmhIIE4cRA-1
Received: by mail-qk1-f197.google.com with SMTP id h8-20020a05620a244800b00699fb28d5e4so5909193qkn.22
        for <linux-sparse@vger.kernel.org>; Sun, 10 Apr 2022 07:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFAKldw0FhFQ25eyFiFDczXMzgjYeOjeErSmgooQUh8=;
        b=deVqwxtSsNYLdGolwr3Y2XCF1xoYD1uLlQozhLc9z1SrOQ0Pk/7zAiXOqcZxeeiLne
         fTFL78EKi/IWDFL1CCfPPbJIL5It4ltYzKIHOqAmFseC+uxrx3AG/npc0ALG/xuxxYM/
         VWBCSLkjlfpsdqUFIbs4jDtkBZnL5xZhcKomSx61glbYwjNAZkqRIgApIQ/K6jkOqktg
         Winq9ZEOeL/cSz3bFdZsONR9ybiP8ygzvzwgrt1aGZtBjLC10H4nY28qnwawFmHfsMw0
         ITXSYhocX03CYEXypcHhHJR7u7GeAl9+Nxim85gD7at2aExEHmiMgHMmIUPGUKUxI+wb
         dUIw==
X-Gm-Message-State: AOAM531gY/rBLkSyg2VWsGQf3j7xUfBAQDuW1y9Z+jTHmK63taUZrrrx
        PEoZY0kHQHzPNmeqJ8MkU9WxzAGy9AmJc1/F2tjc7p1O4yHorND/DZmQpsjqV7Zqpm70vpdURuc
        pynzpUyUujVJhBGO+HkoJBkcXrfj34Dqfan+R4NVQsSzukk8ONUaYQ0owItFAI/xbcyRyBsE=
X-Received: by 2002:a05:620a:178c:b0:67d:ae92:5ee with SMTP id ay12-20020a05620a178c00b0067dae9205eemr18921788qkb.420.1649599235554;
        Sun, 10 Apr 2022 07:00:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTmYRCKFwPaPd9grZbhsadDAmTeatXVHfeI4nkh2mn2Vxk2Y1ta0obMDBDdiey4D3KMpW6Ow==
X-Received: by 2002:a05:620a:178c:b0:67d:ae92:5ee with SMTP id ay12-20020a05620a178c00b0067dae9205eemr18921767qkb.420.1649599235274;
        Sun, 10 Apr 2022 07:00:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i184-20020a37b8c1000000b00699fa585088sm7291351qkf.46.2022.04.10.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 07:00:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     linux-sparse@vger.kernel.org, dan.carpenter@oracle.com
Cc:     Tom Rix <trix@redhat.com>
Subject: [PATCH] cgcc: handle -x assembler
Date:   Sun, 10 Apr 2022 10:00:26 -0400
Message-Id: <20220410140026.1830513-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On linux-next, using
make CC=cgcc

fails with
cgcc: unknown assembler invoked
scripts/Kconfig.include:50: Sorry, this assembler is not supported.

cgcc is being invoked with
cgcc -Wa,--version -c -x assembler /dev/null -o /dev/null
And dieing when the '-x c' is not matched.

Add a check for -x assember.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 cgcc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cgcc b/cgcc
index 9c78ee63..dc5cb624 100755
--- a/cgcc
+++ b/cgcc
@@ -42,10 +42,10 @@ while (@ARGV) {
 	$nargs = 1;
     }
 
-    # Ignore the extension if '-x c' is given.
+    # Ignore the extension if '-x c' or '-x assembler' is given.
     if ($_ eq '-x') {
 	die ("$0: missing argument for $_") if !@ARGV;
-	die ("$0: invalid argument for $_") if $ARGV[0] ne 'c';
+	die ("$0: invalid argument for $_") if $ARGV[0] ne 'c' and $ARGV[0] ne 'assembler';
 	$do_check = 1;
 	$nargs = 1;
     }
-- 
2.27.0

